// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Config _$ConfigFromJson(Map<String, dynamic> json) {
  return _Config.fromJson(json);
}

/// @nodoc
mixin _$Config {
  SupabaseConfig get supabase => throw _privateConstructorUsedError;
  GlobalConfig get global => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigCopyWith<Config> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigCopyWith<$Res> {
  factory $ConfigCopyWith(Config value, $Res Function(Config) then) =
      _$ConfigCopyWithImpl<$Res, Config>;
  @useResult
  $Res call({SupabaseConfig supabase, GlobalConfig global});

  $SupabaseConfigCopyWith<$Res> get supabase;
  $GlobalConfigCopyWith<$Res> get global;
}

/// @nodoc
class _$ConfigCopyWithImpl<$Res, $Val extends Config>
    implements $ConfigCopyWith<$Res> {
  _$ConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supabase = null,
    Object? global = null,
  }) {
    return _then(_value.copyWith(
      supabase: null == supabase
          ? _value.supabase
          : supabase // ignore: cast_nullable_to_non_nullable
              as SupabaseConfig,
      global: null == global
          ? _value.global
          : global // ignore: cast_nullable_to_non_nullable
              as GlobalConfig,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SupabaseConfigCopyWith<$Res> get supabase {
    return $SupabaseConfigCopyWith<$Res>(_value.supabase, (value) {
      return _then(_value.copyWith(supabase: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GlobalConfigCopyWith<$Res> get global {
    return $GlobalConfigCopyWith<$Res>(_value.global, (value) {
      return _then(_value.copyWith(global: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ConfigCopyWith<$Res> implements $ConfigCopyWith<$Res> {
  factory _$$_ConfigCopyWith(_$_Config value, $Res Function(_$_Config) then) =
      __$$_ConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SupabaseConfig supabase, GlobalConfig global});

  @override
  $SupabaseConfigCopyWith<$Res> get supabase;
  @override
  $GlobalConfigCopyWith<$Res> get global;
}

/// @nodoc
class __$$_ConfigCopyWithImpl<$Res>
    extends _$ConfigCopyWithImpl<$Res, _$_Config>
    implements _$$_ConfigCopyWith<$Res> {
  __$$_ConfigCopyWithImpl(_$_Config _value, $Res Function(_$_Config) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? supabase = null,
    Object? global = null,
  }) {
    return _then(_$_Config(
      supabase: null == supabase
          ? _value.supabase
          : supabase // ignore: cast_nullable_to_non_nullable
              as SupabaseConfig,
      global: null == global
          ? _value.global
          : global // ignore: cast_nullable_to_non_nullable
              as GlobalConfig,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Config extends _Config {
  const _$_Config(
      {this.supabase = const SupabaseConfig(),
      this.global = const GlobalConfig()})
      : super._();

  factory _$_Config.fromJson(Map<String, dynamic> json) =>
      _$$_ConfigFromJson(json);

  @override
  @JsonKey()
  final SupabaseConfig supabase;
  @override
  @JsonKey()
  final GlobalConfig global;

  @override
  String toString() {
    return 'Config(supabase: $supabase, global: $global)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Config &&
            (identical(other.supabase, supabase) ||
                other.supabase == supabase) &&
            (identical(other.global, global) || other.global == global));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, supabase, global);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConfigCopyWith<_$_Config> get copyWith =>
      __$$_ConfigCopyWithImpl<_$_Config>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConfigToJson(
      this,
    );
  }
}

abstract class _Config extends Config {
  const factory _Config(
      {final SupabaseConfig supabase, final GlobalConfig global}) = _$_Config;
  const _Config._() : super._();

  factory _Config.fromJson(Map<String, dynamic> json) = _$_Config.fromJson;

  @override
  SupabaseConfig get supabase;
  @override
  GlobalConfig get global;
  @override
  @JsonKey(ignore: true)
  _$$_ConfigCopyWith<_$_Config> get copyWith =>
      throw _privateConstructorUsedError;
}

SupabaseConfig _$SupabaseConfigFromJson(Map<String, dynamic> json) {
  return _SupabaseConfig.fromJson(json);
}

/// @nodoc
mixin _$SupabaseConfig {
  String get projectPath => throw _privateConstructorUsedError;
  @EntryPointsConverter()
  List<EntryPoint> get functions => throw _privateConstructorUsedError;
  CompilerLevel? get devCompilerLevel => throw _privateConstructorUsedError;
  CompilerLevel? get prodCompilerLevel => throw _privateConstructorUsedError;
  bool? get exitWatchOnFailure => throw _privateConstructorUsedError;
  List<String>? get additionalCompilerArgs =>
      throw _privateConstructorUsedError;
  int? get isolates => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SupabaseConfigCopyWith<SupabaseConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupabaseConfigCopyWith<$Res> {
  factory $SupabaseConfigCopyWith(
          SupabaseConfig value, $Res Function(SupabaseConfig) then) =
      _$SupabaseConfigCopyWithImpl<$Res, SupabaseConfig>;
  @useResult
  $Res call(
      {String projectPath,
      @EntryPointsConverter() List<EntryPoint> functions,
      CompilerLevel? devCompilerLevel,
      CompilerLevel? prodCompilerLevel,
      bool? exitWatchOnFailure,
      List<String>? additionalCompilerArgs,
      int? isolates});
}

/// @nodoc
class _$SupabaseConfigCopyWithImpl<$Res, $Val extends SupabaseConfig>
    implements $SupabaseConfigCopyWith<$Res> {
  _$SupabaseConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectPath = null,
    Object? functions = null,
    Object? devCompilerLevel = freezed,
    Object? prodCompilerLevel = freezed,
    Object? exitWatchOnFailure = freezed,
    Object? additionalCompilerArgs = freezed,
    Object? isolates = freezed,
  }) {
    return _then(_value.copyWith(
      projectPath: null == projectPath
          ? _value.projectPath
          : projectPath // ignore: cast_nullable_to_non_nullable
              as String,
      functions: null == functions
          ? _value.functions
          : functions // ignore: cast_nullable_to_non_nullable
              as List<EntryPoint>,
      devCompilerLevel: freezed == devCompilerLevel
          ? _value.devCompilerLevel
          : devCompilerLevel // ignore: cast_nullable_to_non_nullable
              as CompilerLevel?,
      prodCompilerLevel: freezed == prodCompilerLevel
          ? _value.prodCompilerLevel
          : prodCompilerLevel // ignore: cast_nullable_to_non_nullable
              as CompilerLevel?,
      exitWatchOnFailure: freezed == exitWatchOnFailure
          ? _value.exitWatchOnFailure
          : exitWatchOnFailure // ignore: cast_nullable_to_non_nullable
              as bool?,
      additionalCompilerArgs: freezed == additionalCompilerArgs
          ? _value.additionalCompilerArgs
          : additionalCompilerArgs // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isolates: freezed == isolates
          ? _value.isolates
          : isolates // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SupabaseConfigCopyWith<$Res>
    implements $SupabaseConfigCopyWith<$Res> {
  factory _$$_SupabaseConfigCopyWith(
          _$_SupabaseConfig value, $Res Function(_$_SupabaseConfig) then) =
      __$$_SupabaseConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String projectPath,
      @EntryPointsConverter() List<EntryPoint> functions,
      CompilerLevel? devCompilerLevel,
      CompilerLevel? prodCompilerLevel,
      bool? exitWatchOnFailure,
      List<String>? additionalCompilerArgs,
      int? isolates});
}

/// @nodoc
class __$$_SupabaseConfigCopyWithImpl<$Res>
    extends _$SupabaseConfigCopyWithImpl<$Res, _$_SupabaseConfig>
    implements _$$_SupabaseConfigCopyWith<$Res> {
  __$$_SupabaseConfigCopyWithImpl(
      _$_SupabaseConfig _value, $Res Function(_$_SupabaseConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectPath = null,
    Object? functions = null,
    Object? devCompilerLevel = freezed,
    Object? prodCompilerLevel = freezed,
    Object? exitWatchOnFailure = freezed,
    Object? additionalCompilerArgs = freezed,
    Object? isolates = freezed,
  }) {
    return _then(_$_SupabaseConfig(
      projectPath: null == projectPath
          ? _value.projectPath
          : projectPath // ignore: cast_nullable_to_non_nullable
              as String,
      functions: null == functions
          ? _value._functions
          : functions // ignore: cast_nullable_to_non_nullable
              as List<EntryPoint>,
      devCompilerLevel: freezed == devCompilerLevel
          ? _value.devCompilerLevel
          : devCompilerLevel // ignore: cast_nullable_to_non_nullable
              as CompilerLevel?,
      prodCompilerLevel: freezed == prodCompilerLevel
          ? _value.prodCompilerLevel
          : prodCompilerLevel // ignore: cast_nullable_to_non_nullable
              as CompilerLevel?,
      exitWatchOnFailure: freezed == exitWatchOnFailure
          ? _value.exitWatchOnFailure
          : exitWatchOnFailure // ignore: cast_nullable_to_non_nullable
              as bool?,
      additionalCompilerArgs: freezed == additionalCompilerArgs
          ? _value._additionalCompilerArgs
          : additionalCompilerArgs // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isolates: freezed == isolates
          ? _value.isolates
          : isolates // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SupabaseConfig implements _SupabaseConfig {
  const _$_SupabaseConfig(
      {this.projectPath = '.',
      @EntryPointsConverter() final List<EntryPoint> functions = const [
        EntryPoint('lib/main.dart', name: 'dart_edge')
      ],
      this.devCompilerLevel,
      this.prodCompilerLevel,
      this.exitWatchOnFailure,
      final List<String>? additionalCompilerArgs,
      this.isolates})
      : _functions = functions,
        _additionalCompilerArgs = additionalCompilerArgs;

  factory _$_SupabaseConfig.fromJson(Map<String, dynamic> json) =>
      _$$_SupabaseConfigFromJson(json);

  @override
  @JsonKey()
  final String projectPath;
  final List<EntryPoint> _functions;
  @override
  @JsonKey()
  @EntryPointsConverter()
  List<EntryPoint> get functions {
    if (_functions is EqualUnmodifiableListView) return _functions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_functions);
  }

  @override
  final CompilerLevel? devCompilerLevel;
  @override
  final CompilerLevel? prodCompilerLevel;
  @override
  final bool? exitWatchOnFailure;
  final List<String>? _additionalCompilerArgs;
  @override
  List<String>? get additionalCompilerArgs {
    final value = _additionalCompilerArgs;
    if (value == null) return null;
    if (_additionalCompilerArgs is EqualUnmodifiableListView)
      return _additionalCompilerArgs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? isolates;

  @override
  String toString() {
    return 'SupabaseConfig(projectPath: $projectPath, functions: $functions, devCompilerLevel: $devCompilerLevel, prodCompilerLevel: $prodCompilerLevel, exitWatchOnFailure: $exitWatchOnFailure, additionalCompilerArgs: $additionalCompilerArgs, isolates: $isolates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SupabaseConfig &&
            (identical(other.projectPath, projectPath) ||
                other.projectPath == projectPath) &&
            const DeepCollectionEquality()
                .equals(other._functions, _functions) &&
            (identical(other.devCompilerLevel, devCompilerLevel) ||
                other.devCompilerLevel == devCompilerLevel) &&
            (identical(other.prodCompilerLevel, prodCompilerLevel) ||
                other.prodCompilerLevel == prodCompilerLevel) &&
            (identical(other.exitWatchOnFailure, exitWatchOnFailure) ||
                other.exitWatchOnFailure == exitWatchOnFailure) &&
            const DeepCollectionEquality().equals(
                other._additionalCompilerArgs, _additionalCompilerArgs) &&
            (identical(other.isolates, isolates) ||
                other.isolates == isolates));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      projectPath,
      const DeepCollectionEquality().hash(_functions),
      devCompilerLevel,
      prodCompilerLevel,
      exitWatchOnFailure,
      const DeepCollectionEquality().hash(_additionalCompilerArgs),
      isolates);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SupabaseConfigCopyWith<_$_SupabaseConfig> get copyWith =>
      __$$_SupabaseConfigCopyWithImpl<_$_SupabaseConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SupabaseConfigToJson(
      this,
    );
  }
}

abstract class _SupabaseConfig implements SupabaseConfig {
  const factory _SupabaseConfig(
      {final String projectPath,
      @EntryPointsConverter() final List<EntryPoint> functions,
      final CompilerLevel? devCompilerLevel,
      final CompilerLevel? prodCompilerLevel,
      final bool? exitWatchOnFailure,
      final List<String>? additionalCompilerArgs,
      final int? isolates}) = _$_SupabaseConfig;

  factory _SupabaseConfig.fromJson(Map<String, dynamic> json) =
      _$_SupabaseConfig.fromJson;

  @override
  String get projectPath;
  @override
  @EntryPointsConverter()
  List<EntryPoint> get functions;
  @override
  CompilerLevel? get devCompilerLevel;
  @override
  CompilerLevel? get prodCompilerLevel;
  @override
  bool? get exitWatchOnFailure;
  @override
  List<String>? get additionalCompilerArgs;
  @override
  int? get isolates;
  @override
  @JsonKey(ignore: true)
  _$$_SupabaseConfigCopyWith<_$_SupabaseConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

GlobalConfig _$GlobalConfigFromJson(Map<String, dynamic> json) {
  return _GlobalConfig.fromJson(json);
}

/// @nodoc
mixin _$GlobalConfig {
  CompilerLevel? get devCompilerLevel => throw _privateConstructorUsedError;
  CompilerLevel? get prodCompilerLevel => throw _privateConstructorUsedError;
  bool? get exitWatchOnFailure => throw _privateConstructorUsedError;
  int? get isolates => throw _privateConstructorUsedError;
  List<String>? get additionalCompilerArgs =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GlobalConfigCopyWith<GlobalConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GlobalConfigCopyWith<$Res> {
  factory $GlobalConfigCopyWith(
          GlobalConfig value, $Res Function(GlobalConfig) then) =
      _$GlobalConfigCopyWithImpl<$Res, GlobalConfig>;
  @useResult
  $Res call(
      {CompilerLevel? devCompilerLevel,
      CompilerLevel? prodCompilerLevel,
      bool? exitWatchOnFailure,
      int? isolates,
      List<String>? additionalCompilerArgs});
}

/// @nodoc
class _$GlobalConfigCopyWithImpl<$Res, $Val extends GlobalConfig>
    implements $GlobalConfigCopyWith<$Res> {
  _$GlobalConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? devCompilerLevel = freezed,
    Object? prodCompilerLevel = freezed,
    Object? exitWatchOnFailure = freezed,
    Object? isolates = freezed,
    Object? additionalCompilerArgs = freezed,
  }) {
    return _then(_value.copyWith(
      devCompilerLevel: freezed == devCompilerLevel
          ? _value.devCompilerLevel
          : devCompilerLevel // ignore: cast_nullable_to_non_nullable
              as CompilerLevel?,
      prodCompilerLevel: freezed == prodCompilerLevel
          ? _value.prodCompilerLevel
          : prodCompilerLevel // ignore: cast_nullable_to_non_nullable
              as CompilerLevel?,
      exitWatchOnFailure: freezed == exitWatchOnFailure
          ? _value.exitWatchOnFailure
          : exitWatchOnFailure // ignore: cast_nullable_to_non_nullable
              as bool?,
      isolates: freezed == isolates
          ? _value.isolates
          : isolates // ignore: cast_nullable_to_non_nullable
              as int?,
      additionalCompilerArgs: freezed == additionalCompilerArgs
          ? _value.additionalCompilerArgs
          : additionalCompilerArgs // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GlobalConfigCopyWith<$Res>
    implements $GlobalConfigCopyWith<$Res> {
  factory _$$_GlobalConfigCopyWith(
          _$_GlobalConfig value, $Res Function(_$_GlobalConfig) then) =
      __$$_GlobalConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CompilerLevel? devCompilerLevel,
      CompilerLevel? prodCompilerLevel,
      bool? exitWatchOnFailure,
      int? isolates,
      List<String>? additionalCompilerArgs});
}

/// @nodoc
class __$$_GlobalConfigCopyWithImpl<$Res>
    extends _$GlobalConfigCopyWithImpl<$Res, _$_GlobalConfig>
    implements _$$_GlobalConfigCopyWith<$Res> {
  __$$_GlobalConfigCopyWithImpl(
      _$_GlobalConfig _value, $Res Function(_$_GlobalConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? devCompilerLevel = freezed,
    Object? prodCompilerLevel = freezed,
    Object? exitWatchOnFailure = freezed,
    Object? isolates = freezed,
    Object? additionalCompilerArgs = freezed,
  }) {
    return _then(_$_GlobalConfig(
      devCompilerLevel: freezed == devCompilerLevel
          ? _value.devCompilerLevel
          : devCompilerLevel // ignore: cast_nullable_to_non_nullable
              as CompilerLevel?,
      prodCompilerLevel: freezed == prodCompilerLevel
          ? _value.prodCompilerLevel
          : prodCompilerLevel // ignore: cast_nullable_to_non_nullable
              as CompilerLevel?,
      exitWatchOnFailure: freezed == exitWatchOnFailure
          ? _value.exitWatchOnFailure
          : exitWatchOnFailure // ignore: cast_nullable_to_non_nullable
              as bool?,
      isolates: freezed == isolates
          ? _value.isolates
          : isolates // ignore: cast_nullable_to_non_nullable
              as int?,
      additionalCompilerArgs: freezed == additionalCompilerArgs
          ? _value._additionalCompilerArgs
          : additionalCompilerArgs // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GlobalConfig implements _GlobalConfig {
  const _$_GlobalConfig(
      {this.devCompilerLevel,
      this.prodCompilerLevel,
      this.exitWatchOnFailure,
      this.isolates,
      final List<String>? additionalCompilerArgs})
      : _additionalCompilerArgs = additionalCompilerArgs;

  factory _$_GlobalConfig.fromJson(Map<String, dynamic> json) =>
      _$$_GlobalConfigFromJson(json);

  @override
  final CompilerLevel? devCompilerLevel;
  @override
  final CompilerLevel? prodCompilerLevel;
  @override
  final bool? exitWatchOnFailure;
  @override
  final int? isolates;
  final List<String>? _additionalCompilerArgs;
  @override
  List<String>? get additionalCompilerArgs {
    final value = _additionalCompilerArgs;
    if (value == null) return null;
    if (_additionalCompilerArgs is EqualUnmodifiableListView)
      return _additionalCompilerArgs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GlobalConfig(devCompilerLevel: $devCompilerLevel, prodCompilerLevel: $prodCompilerLevel, exitWatchOnFailure: $exitWatchOnFailure, isolates: $isolates, additionalCompilerArgs: $additionalCompilerArgs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GlobalConfig &&
            (identical(other.devCompilerLevel, devCompilerLevel) ||
                other.devCompilerLevel == devCompilerLevel) &&
            (identical(other.prodCompilerLevel, prodCompilerLevel) ||
                other.prodCompilerLevel == prodCompilerLevel) &&
            (identical(other.exitWatchOnFailure, exitWatchOnFailure) ||
                other.exitWatchOnFailure == exitWatchOnFailure) &&
            (identical(other.isolates, isolates) ||
                other.isolates == isolates) &&
            const DeepCollectionEquality().equals(
                other._additionalCompilerArgs, _additionalCompilerArgs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      devCompilerLevel,
      prodCompilerLevel,
      exitWatchOnFailure,
      isolates,
      const DeepCollectionEquality().hash(_additionalCompilerArgs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GlobalConfigCopyWith<_$_GlobalConfig> get copyWith =>
      __$$_GlobalConfigCopyWithImpl<_$_GlobalConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GlobalConfigToJson(
      this,
    );
  }
}

abstract class _GlobalConfig implements GlobalConfig {
  const factory _GlobalConfig(
      {final CompilerLevel? devCompilerLevel,
      final CompilerLevel? prodCompilerLevel,
      final bool? exitWatchOnFailure,
      final int? isolates,
      final List<String>? additionalCompilerArgs}) = _$_GlobalConfig;

  factory _GlobalConfig.fromJson(Map<String, dynamic> json) =
      _$_GlobalConfig.fromJson;

  @override
  CompilerLevel? get devCompilerLevel;
  @override
  CompilerLevel? get prodCompilerLevel;
  @override
  bool? get exitWatchOnFailure;
  @override
  int? get isolates;
  @override
  List<String>? get additionalCompilerArgs;
  @override
  @JsonKey(ignore: true)
  _$$_GlobalConfigCopyWith<_$_GlobalConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
