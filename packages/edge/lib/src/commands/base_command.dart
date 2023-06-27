import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:edge/src/config.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as p;

abstract class BaseCommand extends Command {
  final Logger logger;

  final String configFilePath = p.join(Directory.current.path, 'edge.yaml');

  Config? _config;

  Config get config {
    if (_config == null) {
      throw Exception('Config not loaded');
    }
    return _config!;
  }

  /// Loads the config from the [configFilePath] and returns it.
  /// After the first call, the config is cached and returned.
  /// The config can then be accessed using the [config] getter.
  Future<Config> getConfig() async {
    if (_config != null) {
      return _config!;
    }
    final file = File(configFilePath);
    final Config config;
    if (!file.existsSync()) {
      config = Config();
    } else {
      config = await file
          .readAsString()
          .then(Config.loadFromYaml)
          .then(updateConfig);
    }
    _config = config;
    return config;
  }

  /// Override this method to update the config before it is used, useful to
  /// update the config with command line arguments.
  FutureOr<Config> updateConfig(Config cfg) {
    return cfg;
  }

  /// Gets a property from the config. The property is evaluated from the
  /// [subConfig] if it is not null, otherwise it is evaluated from the global
  /// config ([Config.global]).
  T? getProperty<T extends Object>(
    T? Function(BaseConfig cfg) propertyGetter,
  ) {
    return BaseConfig.evaluate(
      [config.global, subConfig ?? config.global],
      propertyGetter,
    );
  }

  /// Override this method to provide a sub config for the command. This allows
  /// commands to access sub config values using [getProperty].
  ///
  /// Example:
  /// ```dart
  /// class SupabaseBuildCommand extends BaseCommand {
  ///   @override
  ///   BaseConfig get subConfig => config.supabase;
  ///
  ///   Future<void> run() async {
  ///     final cfg = await getConfig();
  ///
  ///     final exitOnError = getProperty((c) => c.exitWatchOnFailure) ?? true;
  ///   }
  /// }
  /// ```
  BaseConfig? get subConfig => null;

  BaseCommand({
    required this.logger,
  });
}
