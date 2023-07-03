// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Config _$$_ConfigFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_Config',
      json,
      ($checkedConvert) {
        final val = _$_Config(
          supabase: $checkedConvert(
              'supabase',
              (v) => v == null
                  ? const SupabaseConfig()
                  : SupabaseConfig.fromJson(v as Map<String, dynamic>)),
          global: $checkedConvert(
              'global',
              (v) => v == null
                  ? const GlobalConfig()
                  : GlobalConfig.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_ConfigToJson(_$_Config instance) => <String, dynamic>{
      'supabase': instance.supabase.toJson(),
      'global': instance.global.toJson(),
    };

_$_SupabaseConfig _$$_SupabaseConfigFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_SupabaseConfig',
      json,
      ($checkedConvert) {
        final val = _$_SupabaseConfig(
          projectPath:
              $checkedConvert('project_path', (v) => v as String? ?? '.'),
          functions: $checkedConvert(
              'functions',
              (v) => v == null
                  ? const [EntryPoint('lib/main.dart', name: 'dart_edge')]
                  : const EntryPointsConverter()
                      .fromJson(v as Map<String, String>)),
          devCompilerLevel: $checkedConvert('dev_compiler_level',
              (v) => $enumDecodeNullable(_$CompilerLevelEnumMap, v)),
          prodCompilerLevel: $checkedConvert('prod_compiler_level',
              (v) => $enumDecodeNullable(_$CompilerLevelEnumMap, v)),
          exitWatchOnFailure:
              $checkedConvert('exit_watch_on_failure', (v) => v as bool?),
          additionalCompilerArgs: $checkedConvert('additional_compiler_args',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          isolates: $checkedConvert('isolates', (v) => v as int?),
        );
        return val;
      },
      fieldKeyMap: const {
        'projectPath': 'project_path',
        'devCompilerLevel': 'dev_compiler_level',
        'prodCompilerLevel': 'prod_compiler_level',
        'exitWatchOnFailure': 'exit_watch_on_failure',
        'additionalCompilerArgs': 'additional_compiler_args'
      },
    );

Map<String, dynamic> _$$_SupabaseConfigToJson(_$_SupabaseConfig instance) =>
    <String, dynamic>{
      'project_path': instance.projectPath,
      'functions': const EntryPointsConverter().toJson(instance.functions),
      'dev_compiler_level': _$CompilerLevelEnumMap[instance.devCompilerLevel],
      'prod_compiler_level': _$CompilerLevelEnumMap[instance.prodCompilerLevel],
      'exit_watch_on_failure': instance.exitWatchOnFailure,
      'additional_compiler_args': instance.additionalCompilerArgs,
      'isolates': instance.isolates,
    };

const _$CompilerLevelEnumMap = {
  CompilerLevel.O0: 'O0',
  CompilerLevel.O1: 'O1',
  CompilerLevel.O2: 'O2',
  CompilerLevel.O3: 'O3',
  CompilerLevel.O4: 'O4',
};

_$_GlobalConfig _$$_GlobalConfigFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_GlobalConfig',
      json,
      ($checkedConvert) {
        final val = _$_GlobalConfig(
          devCompilerLevel: $checkedConvert('dev_compiler_level',
              (v) => $enumDecodeNullable(_$CompilerLevelEnumMap, v)),
          prodCompilerLevel: $checkedConvert('prod_compiler_level',
              (v) => $enumDecodeNullable(_$CompilerLevelEnumMap, v)),
          exitWatchOnFailure:
              $checkedConvert('exit_watch_on_failure', (v) => v as bool?),
          isolates: $checkedConvert('isolates', (v) => v as int?),
          additionalCompilerArgs: $checkedConvert('additional_compiler_args',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
        );
        return val;
      },
      fieldKeyMap: const {
        'devCompilerLevel': 'dev_compiler_level',
        'prodCompilerLevel': 'prod_compiler_level',
        'exitWatchOnFailure': 'exit_watch_on_failure',
        'additionalCompilerArgs': 'additional_compiler_args'
      },
    );

Map<String, dynamic> _$$_GlobalConfigToJson(_$_GlobalConfig instance) =>
    <String, dynamic>{
      'dev_compiler_level': _$CompilerLevelEnumMap[instance.devCompilerLevel],
      'prod_compiler_level': _$CompilerLevelEnumMap[instance.prodCompilerLevel],
      'exit_watch_on_failure': instance.exitWatchOnFailure,
      'isolates': instance.isolates,
      'additional_compiler_args': instance.additionalCompilerArgs,
    };
