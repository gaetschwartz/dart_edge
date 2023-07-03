// ignore_for_file: invalid_annotation_target

import 'package:edge/src/compiler.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yaml/yaml.dart';

part 'config.freezed.dart';
part 'config.g.dart';

mixin BaseConfig {
  CompilerLevel? get devCompilerLevel;
  CompilerLevel? get prodCompilerLevel;
  int? get isolates;
  bool? get exitWatchOnFailure;
  List<String>? get additionalCompilerArgs;

  static T? evaluate<T extends Object>(
    List<BaseConfig> configs,
    T? Function(BaseConfig) propertyGetter,
  ) {
    return configs.reversed
        .map(propertyGetter)
        .firstWhere((e) => e != null, orElse: () => null);
  }
}

@freezed
class Config with _$Config {
  const factory Config({
    @Default(SupabaseConfig()) SupabaseConfig supabase,
    @Default(GlobalConfig()) GlobalConfig global,
  }) = _Config;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  factory Config.loadFromYaml(String yaml) {
    return Config.fromJson(
      loadYamlNode(yaml).toProperJson() as Map<String, dynamic>,
    );
  }

  const Config._();

  T? get<T extends Object>(
    BaseConfig cfg,
    T? Function(BaseConfig cfg) propertyGetter,
  ) {
    return BaseConfig.evaluate([global, cfg], propertyGetter);
  }
}

@freezed
class SupabaseConfig with BaseConfig, _$SupabaseConfig {
  const factory SupabaseConfig({
    @Default('.') String projectPath,
    @Default([EntryPoint('lib/main.dart', name: 'dart_edge')])
    @EntryPointsConverter()
    List<EntryPoint> functions,
    CompilerLevel? devCompilerLevel,
    CompilerLevel? prodCompilerLevel,
    bool? exitWatchOnFailure,
    List<String>? additionalCompilerArgs,
    int? isolates,
  }) = _SupabaseConfig;

  factory SupabaseConfig.fromJson(Map<String, dynamic> json) =>
      _$SupabaseConfigFromJson(json);
}

@freezed
class GlobalConfig with BaseConfig, _$GlobalConfig {
  const factory GlobalConfig({
    CompilerLevel? devCompilerLevel,
    CompilerLevel? prodCompilerLevel,
    bool? exitWatchOnFailure,
    int? isolates,
    List<String>? additionalCompilerArgs,
  }) = _GlobalConfig;

  factory GlobalConfig.fromJson(Map<String, dynamic> json) =>
      _$GlobalConfigFromJson(json);
}

extension on YamlNode {
  dynamic toProperJson() {
    if (this is YamlMap) {
      return <String, dynamic>{
        for (final node in (this as YamlMap).nodes.entries)
          (node.key as YamlNode).value as String: node.value.toProperJson(),
      };
    }
    if (this is YamlList) {
      return <dynamic>[
        for (final node in (this as YamlList).nodes) node.toProperJson(),
      ];
    }
    return value;
  }
}

class EntryPointsConverter
    implements JsonConverter<List<EntryPoint>, Map<String, String>> {
  const EntryPointsConverter();

  @override
  List<EntryPoint> fromJson(Map<String, String> json) {
    return json.entries.map((e) => EntryPoint(e.value, name: e.key)).toList();
  }

  @override
  Map<String, String> toJson(List<EntryPoint> object) {
    return {for (final e in object) e.name: e.path};
  }
}
