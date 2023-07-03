import 'dart:io';

import 'package:ansi_styles/ansi_styles.dart';
import 'package:mason_logger/mason_logger.dart';

extension LoggerExtension on Logger {
  /// Writes an empty line to the console.
  void lineBreak() => write('\n');

  Never fatal(String message, {StackTrace? stackTrace, int exitCode = 1}) {
    err(message);
    if (stackTrace != null) {
      err(stackTrace.toString());
    }
    exit(1);
  }
}

extension StringExtension on String {
  /// Indents the string by [width] spaces.
  String indent(int width) {
    return (' ' * width) + this;
  }

  /// Prefixes the string with [char].
  String prefix(String char) {
    return AnsiStyles.gray(char) + ' ' + this;
  }
}
