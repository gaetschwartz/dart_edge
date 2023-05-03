import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:edge/src/config.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';

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

  Future<void> runDev() async {
    final cfg = await getConfig();
    final exitOnError =
        cfg.get(cfg.supabase, (c) => c.exitWatchOnFailure) ?? true;
    logger.detail("Watcher will ${exitOnError ? '' : 'not '}exit on error.");

    final watcher = Watcher(
      include: '**/*.dart',
      debounce: 500,
      watchPath: p.join(Directory.current.path, 'lib'),
    );

    final compilers = <Compiler>[];
    final futures = <Future>[];
    final progress = logger.progress(
        'Compiling ' + cfg.supabase.functions.length.toString() + ' functions');
    for (final fn in cfg.supabase.functions.entries) {
      final fnDir = p.join(cfg.supabase.projectPath, 'functions', fn.key);
      final entryFile = File(p.join(fnDir, 'index.ts'));

      final compiler = Compiler(
        logger: logger,
        entryPoint: p.join(Directory.current.path, fn.value),
        outputDirectory: fnDir,
        outputFileName: 'main.dart.js',
        level: cfg.get(cfg.supabase, (c) => c.devCompilerLevel) ??
            CompilerLevel.O1,
        fileName: fn.value,
        showProgress: false,
        exitOnError: exitOnError,
      );

      futures.add(compiler.compile());

      futures.add(entryFile.writeAsString(
        edgeFunctionEntryFileDefaultValue('main.dart.js'),
      ));

      compilers.add(compiler);
    }
    await Future.wait(futures);

    progress.complete();

    watcher.watch().listen((event) async {
      final progress = logger.progress(
        'Compiling ' + cfg.supabase.functions.length.toString() + ' functions',
      );
      await Future.wait(
        compilers.map((compiler) => compiler.compile()),
      );
      progress.complete();
    });
  }

  Future<void> runBuild() async {
    final cfg = await getConfig();

    final numberOfProcessors = Platform.numberOfProcessors;
    final pool = Pool(numberOfProcessors);

    final futures = <Future<_CompilationResult?>>[];
    final functions = cfg.supabase.functions.keys.toList();
    final progress = logger.progress('Compiling ${functions.length} functions');
    final useIsolates = (cfg.get(cfg.supabase, (c) => c.useIsolates) ?? true);
    if (useIsolates) {
      logger.detail('Using isolates with pool size $numberOfProcessors');
    }

    for (final fn in cfg.supabase.functions.entries) {
      final fnDir = p.join(cfg.supabase.projectPath, 'functions', fn.key);
      final entryFile = File(p.join(fnDir, 'index.ts'));

      final compiler = Compiler(
        logger: logger,
        entryPoint: p.join(Directory.current.path, fn.value),
        outputDirectory: fnDir,
        outputFileName: 'main.dart.js',
        level: cfg.get(cfg.supabase, (c) => c.prodCompilerLevel) ??
            CompilerLevel.O2,
        fileName: fn.value,
        showProgress: false,
        exitOnError: cfg.get(cfg.supabase, (c) => c.exitWatchOnFailure) ?? true,
        throwOnError: true,
      );

      futures.add(pool.withResource(() async {
        try {
          if (useIsolates) {
            await Isolate.run(() => compiler.compile());
          } else {
            await compiler.compile();
          }
          return _CompilationResult(fn.key, true);
        } on CompilerException catch (e) {
          return _CompilationResult(fn.key, false, e);
        }
      }));

      futures.add(entryFile
          .writeAsString(
            edgeFunctionEntryFileDefaultValue('main.dart.js'),
          )
          .then((_) => null));
    }
    const _clearLine = '\x1b[2K\r';
    int failures = 0;
    await for (final res in Stream.fromFutures(futures)) {
      if (res != null) {
        // clear the current line
        functions.remove(res.function);
        final header = res.success ? lightGreen.wrap('✓') : red.wrap('✗');
        logger.info('$_clearLine${header} ${res.function}');
        if (!res.success) {
          failures++;
          logger.err(res.exception?.stdout);
        }
        progress.update('Compiling ${functions.length} functions');
      }
    }
    stdout.write('$_clearLine\n');
    if (failures > 0) {
      progress.fail('Failed to compile $failures functions');
      exit(1);
    } else {
      progress
          .complete('All ${cfg.supabase.functions.length} functions compiled');
    }
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

typedef _CompileFn = Future<void> Function(Future<void> Function());

class _CompilationResult {
  final String function;
  final bool success;
  final CompilerException? exception;

  _CompilationResult(this.function, this.success, [this.exception]);
}

final edgeFunctionEntryFileDefaultValue = (String fileName) => '''
import { serve } from "https://deno.land/std@0.131.0/http/server.ts";
import "./${fileName}";

serve((request) => {
  if (self.__dartSupabaseFetchHandler) {
    return self.__dartSupabaseFetchHandler(request);
  }

  return new Response("Something went wrong", { status: 500 });
});

declare global {
  interface Window {
    __dartSupabaseFetchHandler?: (request: Request) => Promise<Response>;
  }
}
''';
