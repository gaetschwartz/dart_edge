import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:edge/src/logger.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;
import 'package:pool/pool.dart';

enum CompilerLevel {
  /// Disables some of the default optimizations.
  O0,

  /// Default level of optimizations.
  O1,

  /// Enables minification but keeps the same behavior as O1.
  O2,

  /// Enables potentially unsafe optimizations.
  O3,

  /// Enables even more (potentially unsafe) optimizations.
  O4,
}

abstract class Compiler {
  // The entry point of the application.
  final EntryPoint entryPoint;

  // The output directory path.
  final String outputDirectory;

  final CompilerLevel level;

  // The output file name. Defaults to `main.dart.js`.
  final String outputFileName;

  final String fileName;
  final List<String>? additionalArgs;

  Compiler({
    required this.entryPoint,
    required this.outputDirectory,
    required this.level,
    required this.fileName,
    required this.outputFileName,
    required this.additionalArgs,
  });

  String get outputFilePath => p.join(outputDirectory, outputFileName);

  Future<void> compile() async {
    final process = await Process.run('dart', [
      'compile',
      'js',
      '-${level.name}',
      '-o',
      (p.join(outputDirectory, outputFileName)),
      ...additionalArgs ?? ['--server-mode'],
      entryPoint.path,
    ]);

    if (process.exitCode != 0) {
      throw CompilerException(
        exitCode: process.exitCode,
        stderr: process.stderr as String,
        stdout: process.stdout as String,
      );
    }
  }
}

class InternalCompiler extends Compiler {
  InternalCompiler({
    required super.entryPoint,
    required super.outputDirectory,
    required super.level,
    super.fileName = 'Dart entry file',
    super.outputFileName = 'main.dart.js',
    super.additionalArgs,
  });
}

class ConsoleCompiler extends Compiler {
  final Logger logger;

  ConsoleCompiler({
    required String entryPoint,
    required super.outputDirectory,
    super.level = CompilerLevel.O1,
    required this.logger,
    super.fileName = 'Dart entry file',
    super.outputFileName = 'main.dart.js',
    super.additionalArgs,
    String? displayName,
  }) : super(
            entryPoint: switch (displayName) {
          final name? => EntryPoint(entryPoint, name: name),
          _ => EntryPoint.fromPath(entryPoint),
        });

  @override
  Future<void> compile() async {
    final entry = File(entryPoint.path);

    if (!entry.existsSync()) {
      logger.err(
          'Attempted to compile the entry file at ${entry.path}, but no file was found.');
      logger.lineBreak();

      final docs = link(
          uri: Uri.parse('https://docs.dartedge.dev'),
          message: 'https://docs.dartedge.dev');

      logger.info('Visit the docs for more information: $docs');
      exit(1);
    }
    final outputPath = p.join(outputDirectory, outputFileName);

    logger.detail(
        'Compiling with optimization level ${level.name} ${entry.path} to $outputPath');

    final progress = logger.progress('Compiling $fileName');

    try {
      await super.compile();
    } on CompilerException catch (e) {
      progress.cancel();
      logger.err('Compilation of the Dart entry file failed:');
      logger.lineBreak();
      logger.err(e.stdout);
      exit(1);
    }

    progress.complete('Compiled $fileName');
  }
}

class CompilerException implements Exception {
  final int exitCode;
  final String stderr;
  final String stdout;
  final String message;

  CompilerException({
    required this.exitCode,
    required this.stderr,
    required this.stdout,
  }) : message = 'Compiler exited with code $exitCode.';

  @override
  String toString() {
    return 'CompilerException: $message';
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

final class EntryPoint {
  final String name;
  final String path;

  const EntryPoint(this.path, {required this.name});

  EntryPoint.fromPath(this.path)
      : name = p.basenameWithoutExtension(path),
        assert(p.extension(path) == '.dart');

  static List<EntryPoint> fromMap(Map<String, String> map) {
    return map.entries.map((e) => EntryPoint(e.value, name: e.key)).toList();
  }

  @override
  String toString() => 'EntryPoint($name, $path)';
}

class MultiCompiler {
  final FutureOr<Compiler> Function(EntryPoint) compilerFactory;
  final FutureOr<void> Function(EntryPoint)? setup;
  final Logger logger;
  final int? isolateCount;
  final bool exitOnError;

  MultiCompiler({
    required this.compilerFactory,
    this.setup,
    required this.logger,
    this.isolateCount,
    this.exitOnError = true,
  });

  Future<void> compile(List<EntryPoint> entryPoints) async {
    const _clearLine = '\x1b[2K\r';

    final poolSize = switch (isolateCount) {
      0 || null => Platform.numberOfProcessors,
      final c when c > 0 => c,
      _ => logger.fatal('Invalid isolate count: $isolateCount')
    };

    final pool = Pool(poolSize);

    final _toCompile = List.of(entryPoints);

    @pragma('vm:prefer-inline')
    String _compilingMessage(List<EntryPoint> entryPoints) {
      return switch (entryPoints) {
        [final entryPoint] => 'Compiling ${styleBold.wrap(entryPoint.name)}',
        [] => 'Compiled all functions',
        List(:final length, :final first) =>
          'Compiling ${styleBold.wrap(first.name)} ${styleDim.wrap('and ${length - 1} more')}'
      };
    }

    final progress = logger.progress(_compilingMessage(entryPoints));

    await Future.wait(entryPoints.map((e) async => setup?.call(e)));

    final compilations = pool.forEach(
      entryPoints,
      (entry) async {
        final compiler = await compilerFactory(entry);
        try {
          if (poolSize > 1) {
            await Isolate.run(() async => await compiler.compile());
          } else {
            await compiler.compile();
          }
          return FunctionCompilationSuccess(entry.name);
        } on CompilerException catch (e) {
          return FunctionCompilationFailure(entry.name, e);
        }
      },
    );

    int failures = 0;
    await for (final res in compilations) {
      // clear the current line
      _toCompile.removeWhere((e) => e.name == res.function);
      final header = switch (res) {
        FunctionCompilationSuccess _ => lightGreen.wrap('✓'),
        FunctionCompilationFailure _ => red.wrap('✗'),
      };
      switch (res) {
        case FunctionCompilationSuccess():
          logger.info(
              '$_clearLine${header} Compiled ${styleBold.wrap(res.function)}');
        case FunctionCompilationFailure(:final exception):
          failures++;
          logger.err(
              '$_clearLine${header} Failed to compile ${styleBold.wrap(res.function)}');
          logger.err(exception.stdout);
      }
      if (_toCompile.isNotEmpty) {
        progress.update(_compilingMessage(_toCompile));
      }
    }

    stdout.write('$_clearLine\n');
    if (failures > 0) {
      progress.fail(
          'Compilation failed for ${styleBold.wrap(failures.toString())} functions');
      if (exitOnError) exit(1);
    } else {
      progress.complete(
          'All ${styleBold.wrap(entryPoints.length.toString())} functions compiled successfully');
    }
  }
}
