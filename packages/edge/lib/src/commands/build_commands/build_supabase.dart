import 'dart:async';
import 'dart:io';

import 'package:edge/src/config.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;

import '../../compiler.dart';
import '../../watcher.dart';
import '../base_command.dart';

class SupabaseBuildCommand extends BaseCommand {
  @override
  final name = "supabase_functions";

  @override
  final description = "Builds the project for Supabase Edge Functions.";

  SupabaseBuildCommand({
    required super.logger,
  }) {
    argParser.addFlag(
      'dev',
      help:
          'Runs Dart Edge in a local development environment with hot reload via Vercel CLI.',
    );
    argParser.addOption(
      'project-path',
      abbr: 'p',
      help: 'The path to the supabase project.',
    );
    argParser.addFlag('verbose', abbr: 'v', help: 'Enables verbose logging.');
  }

  @override
  Future<Config> updateConfig(Config cfg) async {
    Config config = cfg.copyWith(
      supabase: cfg.supabase.copyWith(
        projectPath: p.canonicalize(argResults!.wasParsed('project-path')
            ? argResults!['project-path'] as String
            : cfg.supabase.projectPath),
      ),
    );

    logger.detail('Supabase project path: ${config.supabase.projectPath}');
    logger.detail('Supabase functions: ${config.supabase.functions}');
    return config;
  }

  BaseConfig get subConfig => config.supabase;

  Future<void> runBuild() async {
    final cfg = await getConfig();

    final multiCompiler = _getMultiCompiler(cfg);

    await multiCompiler.compile(cfg.supabase.functions);
  }

  MultiCompiler _getMultiCompiler(
    Config cfg, {
    bool isDev = false,
    bool exitOnError = true,
  }) {
    final additionalArgs = getProperty((c) => c.additionalCompilerArgs);
    final isolateCount = getProperty((cfg) => cfg.isolates);
    final level =
        getProperty((c) => isDev ? c.devCompilerLevel : c.prodCompilerLevel) ??
            CompilerLevel.O1;

    logger.detail('Using isolates with pool size $isolateCount');

    final contents = _edgeFunctionEntryFileDefaultValue('main.dart.js');
    final multiCompiler = MultiCompiler(
      compilerFactory: (entryPoint) {
        return InternalCompiler(
          entryPoint: entryPoint,
          outputDirectory:
              p.join(cfg.supabase.projectPath, 'functions', entryPoint.name),
          outputFileName: 'main.dart.js',
          level: level,
          fileName: entryPoint.name,
          additionalArgs: additionalArgs,
        );
      },
      setup: (entryPoint) async {
        final entryFile = File(p.join(
          cfg.supabase.projectPath,
          'functions',
          entryPoint.name,
          'index.ts',
        ));
        if (!entryFile.parent.existsSync()) {
          await entryFile.parent.create(recursive: true);
        }
        await entryFile.writeAsString(contents);
      },
      logger: logger,
      isolateCount: isolateCount,
      exitOnError: exitOnError,
      minimal: isDev,
    );
    return multiCompiler;
  }

  Future<void> runDev() async {
    final cfg = await getConfig();

    final exitOnError = getProperty((c) => c.exitWatchOnFailure) ?? true;
    logger.detail("Watcher will ${exitOnError ? '' : 'not '}exit on error.");

    final watcher = Watcher(
      include: '**/*.dart',
      debounce: 500,
      watchPath: p.join(Directory.current.path, 'lib'),
    );

    final compiler = _getMultiCompiler(
      cfg,
      isDev: true,
      exitOnError: exitOnError,
    );

    await compiler.compile(cfg.supabase.functions);

    watcher.watch().listen((event) async {
      await compiler.compile(cfg.supabase.functions);
    });
  }

  @override
  void run() async {
    final isDev = argResults!['dev'] as bool;
    if (argResults!['verbose'] as bool) {
      logger.level = Level.verbose;
    }

    if (isDev) {
      await runDev();
    } else {
      await runBuild();
    }
  }
}

String _edgeFunctionEntryFileDefaultValue(String fileName) => '''
import { serve } from "https://deno.land/std@0.131.0/http/server.ts";
import "./${fileName}";

serve((request) => {
  if (self.__dartSupabaseFetchHandler) {
    return self.__dartSupabaseFetchHandler(request);
  }

  return new Response(
    "Something went wrong, unable to find the Dart handler.",
    { status: 500 },
  );
});

declare global {
  interface Window {
    __dartSupabaseFetchHandler?: (request: Request) => Promise<Response>;
  }
}
''';
