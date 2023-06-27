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

  BaseConfig get subConfig => config.supabase;

  Future<void> runDev() async {
    final cfg = await getConfig();

    final exitOnError = getProperty((c) => c.exitWatchOnFailure) ?? true;
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
    final devCompilerLevel =
        getProperty((c) => c.devCompilerLevel) ?? CompilerLevel.O1;

    for (final fn in cfg.supabase.functions.entries) {
      final fnDir = p.join(cfg.supabase.projectPath, 'functions', fn.key);
      final entryFile = File(p.join(fnDir, 'index.ts'));
      if (!entryFile.parent.existsSync()) {
        await entryFile.parent.create(recursive: true);
      }

      final compiler = Compiler(
        logger: logger,
        entryPoint: p.join(Directory.current.path, fn.value),
        outputDirectory: fnDir,
        outputFileName: 'main.dart.js',
        level: devCompilerLevel,
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

    final numberOfProcessors = getProperty((cfg) => cfg.isolatePoolSize) ??
        Platform.numberOfProcessors;

    final pool = Pool(numberOfProcessors);
    final functionsToCompile = cfg.supabase.functions.keys.toList();

    final useIsolates = getProperty((c) => c.useIsolates) ?? true;
    final level = getProperty((c) => c.prodCompilerLevel) ?? CompilerLevel.O1;

    if (useIsolates) {
      logger.detail('Using isolates with pool size $numberOfProcessors');
    }
    final progress =
        logger.progress('Compiling ${functionsToCompile.length} functions');

    final contents = edgeFunctionEntryFileDefaultValue('main.dart.js');

    final compilations = <Future<FunctionCompilationResult>>[];
    final ioFutures = <Future>[];
    for (final fn in cfg.supabase.functions.entries) {
      final fnDir = p.join(cfg.supabase.projectPath, 'functions', fn.key);
      final entryFile = File(p.join(fnDir, 'index.ts'));

      final compiler = Compiler(
        logger: logger,
        entryPoint: p.join(Directory.current.path, fn.value),
        outputDirectory: fnDir,
        outputFileName: 'main.dart.js',
        level: level,
        fileName: fn.value,
        showProgress: false,
        throwOnError: true,
      );

      compilations.add(pool.withResource(() async {
        try {
          if (useIsolates) {
            await Isolate.run(() => compiler.compile());
          } else {
            await compiler.compile();
          }
          return FunctionCompilationSuccess(fn.key);
        } on CompilerException catch (e) {
          return FunctionCompilationFailure(fn.key, e);
        }
      }));

      ioFutures.add(Future(() async {
        if (!entryFile.parent.existsSync()) {
          await entryFile.parent.create(recursive: true);
        }
        await entryFile.writeAsString(contents);
      }));
    }

    const _clearLine = '\x1b[2K\r';
    int failures = 0;
    await for (final res in Stream.fromFutures(compilations)) {
      // clear the current line
      functionsToCompile.remove(res.function);
      final header = switch (res) {
        FunctionCompilationSuccess _ => lightGreen.wrap('✓'),
        FunctionCompilationFailure _ => red.wrap('✗'),
      };
      logger.info('$_clearLine${header} ${res.function}');
      if (res case FunctionCompilationFailure(:final exception)) {
        failures++;
        logger.err(exception.stdout);
      }
      progress.update('Compiling ${functionsToCompile.length} functions');
    }

    await Future.wait(ioFutures);

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

sealed class FunctionCompilationResult {
  final String function;

  FunctionCompilationResult(this.function);
}

class FunctionCompilationSuccess extends FunctionCompilationResult {
  FunctionCompilationSuccess(super.function);
}

class FunctionCompilationFailure extends FunctionCompilationResult {
  final CompilerException exception;

  FunctionCompilationFailure(super.function, this.exception);
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
