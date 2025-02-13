// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poll.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SnPoll _$SnPollFromJson(Map<String, dynamic> json) {
  return _SnPoll.fromJson(json);
}

/// @nodoc
mixin _$SnPoll {
  int get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  dynamic get deletedAt => throw _privateConstructorUsedError;
  dynamic get expiredAt => throw _privateConstructorUsedError;
  List<SnPollOption> get options => throw _privateConstructorUsedError;
  int get accountId => throw _privateConstructorUsedError;
  SnPollMetric get metric => throw _privateConstructorUsedError;

  /// Serializes this SnPoll to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnPoll
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnPollCopyWith<SnPoll> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnPollCopyWith<$Res> {
  factory $SnPollCopyWith(SnPoll value, $Res Function(SnPoll) then) =
      _$SnPollCopyWithImpl<$Res, SnPoll>;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      dynamic deletedAt,
      dynamic expiredAt,
      List<SnPollOption> options,
      int accountId,
      SnPollMetric metric});

  $SnPollMetricCopyWith<$Res> get metric;
}

/// @nodoc
class _$SnPollCopyWithImpl<$Res, $Val extends SnPoll>
    implements $SnPollCopyWith<$Res> {
  _$SnPollCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnPoll
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? expiredAt = freezed,
    Object? options = null,
    Object? accountId = null,
    Object? metric = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      expiredAt: freezed == expiredAt
          ? _value.expiredAt
          : expiredAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<SnPollOption>,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      metric: null == metric
          ? _value.metric
          : metric // ignore: cast_nullable_to_non_nullable
              as SnPollMetric,
    ) as $Val);
  }

  /// Create a copy of SnPoll
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnPollMetricCopyWith<$Res> get metric {
    return $SnPollMetricCopyWith<$Res>(_value.metric, (value) {
      return _then(_value.copyWith(metric: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SnPollImplCopyWith<$Res> implements $SnPollCopyWith<$Res> {
  factory _$$SnPollImplCopyWith(
          _$SnPollImpl value, $Res Function(_$SnPollImpl) then) =
      __$$SnPollImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      dynamic deletedAt,
      dynamic expiredAt,
      List<SnPollOption> options,
      int accountId,
      SnPollMetric metric});

  @override
  $SnPollMetricCopyWith<$Res> get metric;
}

/// @nodoc
class __$$SnPollImplCopyWithImpl<$Res>
    extends _$SnPollCopyWithImpl<$Res, _$SnPollImpl>
    implements _$$SnPollImplCopyWith<$Res> {
  __$$SnPollImplCopyWithImpl(
      _$SnPollImpl _value, $Res Function(_$SnPollImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnPoll
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? expiredAt = freezed,
    Object? options = null,
    Object? accountId = null,
    Object? metric = null,
  }) {
    return _then(_$SnPollImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      expiredAt: freezed == expiredAt
          ? _value.expiredAt
          : expiredAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<SnPollOption>,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      metric: null == metric
          ? _value.metric
          : metric // ignore: cast_nullable_to_non_nullable
              as SnPollMetric,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnPollImpl implements _SnPoll {
  const _$SnPollImpl(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.expiredAt,
      required final List<SnPollOption> options,
      required this.accountId,
      required this.metric})
      : _options = options;

  factory _$SnPollImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnPollImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final dynamic deletedAt;
  @override
  final dynamic expiredAt;
  final List<SnPollOption> _options;
  @override
  List<SnPollOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final int accountId;
  @override
  final SnPollMetric metric;

  @override
  String toString() {
    return 'SnPoll(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, expiredAt: $expiredAt, options: $options, accountId: $accountId, metric: $metric)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnPollImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other.deletedAt, deletedAt) &&
            const DeepCollectionEquality().equals(other.expiredAt, expiredAt) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.metric, metric) || other.metric == metric));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(deletedAt),
      const DeepCollectionEquality().hash(expiredAt),
      const DeepCollectionEquality().hash(_options),
      accountId,
      metric);

  /// Create a copy of SnPoll
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnPollImplCopyWith<_$SnPollImpl> get copyWith =>
      __$$SnPollImplCopyWithImpl<_$SnPollImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnPollImplToJson(
      this,
    );
  }
}

abstract class _SnPoll implements SnPoll {
  const factory _SnPoll(
      {required final int id,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final dynamic deletedAt,
      required final dynamic expiredAt,
      required final List<SnPollOption> options,
      required final int accountId,
      required final SnPollMetric metric}) = _$SnPollImpl;

  factory _SnPoll.fromJson(Map<String, dynamic> json) = _$SnPollImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  dynamic get deletedAt;
  @override
  dynamic get expiredAt;
  @override
  List<SnPollOption> get options;
  @override
  int get accountId;
  @override
  SnPollMetric get metric;

  /// Create a copy of SnPoll
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnPollImplCopyWith<_$SnPollImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SnPollMetric _$SnPollMetricFromJson(Map<String, dynamic> json) {
  return _SnPollMetric.fromJson(json);
}

/// @nodoc
mixin _$SnPollMetric {
  int get totalAnswer => throw _privateConstructorUsedError;
  Map<String, int> get byOptions => throw _privateConstructorUsedError;
  Map<String, int> get byOptionsPercentage =>
      throw _privateConstructorUsedError;

  /// Serializes this SnPollMetric to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnPollMetric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnPollMetricCopyWith<SnPollMetric> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnPollMetricCopyWith<$Res> {
  factory $SnPollMetricCopyWith(
          SnPollMetric value, $Res Function(SnPollMetric) then) =
      _$SnPollMetricCopyWithImpl<$Res, SnPollMetric>;
  @useResult
  $Res call(
      {int totalAnswer,
      Map<String, int> byOptions,
      Map<String, int> byOptionsPercentage});
}

/// @nodoc
class _$SnPollMetricCopyWithImpl<$Res, $Val extends SnPollMetric>
    implements $SnPollMetricCopyWith<$Res> {
  _$SnPollMetricCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnPollMetric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalAnswer = null,
    Object? byOptions = null,
    Object? byOptionsPercentage = null,
  }) {
    return _then(_value.copyWith(
      totalAnswer: null == totalAnswer
          ? _value.totalAnswer
          : totalAnswer // ignore: cast_nullable_to_non_nullable
              as int,
      byOptions: null == byOptions
          ? _value.byOptions
          : byOptions // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      byOptionsPercentage: null == byOptionsPercentage
          ? _value.byOptionsPercentage
          : byOptionsPercentage // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SnPollMetricImplCopyWith<$Res>
    implements $SnPollMetricCopyWith<$Res> {
  factory _$$SnPollMetricImplCopyWith(
          _$SnPollMetricImpl value, $Res Function(_$SnPollMetricImpl) then) =
      __$$SnPollMetricImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalAnswer,
      Map<String, int> byOptions,
      Map<String, int> byOptionsPercentage});
}

/// @nodoc
class __$$SnPollMetricImplCopyWithImpl<$Res>
    extends _$SnPollMetricCopyWithImpl<$Res, _$SnPollMetricImpl>
    implements _$$SnPollMetricImplCopyWith<$Res> {
  __$$SnPollMetricImplCopyWithImpl(
      _$SnPollMetricImpl _value, $Res Function(_$SnPollMetricImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnPollMetric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalAnswer = null,
    Object? byOptions = null,
    Object? byOptionsPercentage = null,
  }) {
    return _then(_$SnPollMetricImpl(
      totalAnswer: null == totalAnswer
          ? _value.totalAnswer
          : totalAnswer // ignore: cast_nullable_to_non_nullable
              as int,
      byOptions: null == byOptions
          ? _value._byOptions
          : byOptions // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      byOptionsPercentage: null == byOptionsPercentage
          ? _value._byOptionsPercentage
          : byOptionsPercentage // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnPollMetricImpl implements _SnPollMetric {
  const _$SnPollMetricImpl(
      {required this.totalAnswer,
      final Map<String, int> byOptions = const {},
      final Map<String, int> byOptionsPercentage = const {}})
      : _byOptions = byOptions,
        _byOptionsPercentage = byOptionsPercentage;

  factory _$SnPollMetricImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnPollMetricImplFromJson(json);

  @override
  final int totalAnswer;
  final Map<String, int> _byOptions;
  @override
  @JsonKey()
  Map<String, int> get byOptions {
    if (_byOptions is EqualUnmodifiableMapView) return _byOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_byOptions);
  }

  final Map<String, int> _byOptionsPercentage;
  @override
  @JsonKey()
  Map<String, int> get byOptionsPercentage {
    if (_byOptionsPercentage is EqualUnmodifiableMapView)
      return _byOptionsPercentage;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_byOptionsPercentage);
  }

  @override
  String toString() {
    return 'SnPollMetric(totalAnswer: $totalAnswer, byOptions: $byOptions, byOptionsPercentage: $byOptionsPercentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnPollMetricImpl &&
            (identical(other.totalAnswer, totalAnswer) ||
                other.totalAnswer == totalAnswer) &&
            const DeepCollectionEquality()
                .equals(other._byOptions, _byOptions) &&
            const DeepCollectionEquality()
                .equals(other._byOptionsPercentage, _byOptionsPercentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalAnswer,
      const DeepCollectionEquality().hash(_byOptions),
      const DeepCollectionEquality().hash(_byOptionsPercentage));

  /// Create a copy of SnPollMetric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnPollMetricImplCopyWith<_$SnPollMetricImpl> get copyWith =>
      __$$SnPollMetricImplCopyWithImpl<_$SnPollMetricImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnPollMetricImplToJson(
      this,
    );
  }
}

abstract class _SnPollMetric implements SnPollMetric {
  const factory _SnPollMetric(
      {required final int totalAnswer,
      final Map<String, int> byOptions,
      final Map<String, int> byOptionsPercentage}) = _$SnPollMetricImpl;

  factory _SnPollMetric.fromJson(Map<String, dynamic> json) =
      _$SnPollMetricImpl.fromJson;

  @override
  int get totalAnswer;
  @override
  Map<String, int> get byOptions;
  @override
  Map<String, int> get byOptionsPercentage;

  /// Create a copy of SnPollMetric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnPollMetricImplCopyWith<_$SnPollMetricImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SnPollOption _$SnPollOptionFromJson(Map<String, dynamic> json) {
  return _SnPollOption.fromJson(json);
}

/// @nodoc
mixin _$SnPollOption {
  String get id => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this SnPollOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnPollOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnPollOptionCopyWith<SnPollOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnPollOptionCopyWith<$Res> {
  factory $SnPollOptionCopyWith(
          SnPollOption value, $Res Function(SnPollOption) then) =
      _$SnPollOptionCopyWithImpl<$Res, SnPollOption>;
  @useResult
  $Res call({String id, String icon, String name, String description});
}

/// @nodoc
class _$SnPollOptionCopyWithImpl<$Res, $Val extends SnPollOption>
    implements $SnPollOptionCopyWith<$Res> {
  _$SnPollOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnPollOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? icon = null,
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SnPollOptionImplCopyWith<$Res>
    implements $SnPollOptionCopyWith<$Res> {
  factory _$$SnPollOptionImplCopyWith(
          _$SnPollOptionImpl value, $Res Function(_$SnPollOptionImpl) then) =
      __$$SnPollOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String icon, String name, String description});
}

/// @nodoc
class __$$SnPollOptionImplCopyWithImpl<$Res>
    extends _$SnPollOptionCopyWithImpl<$Res, _$SnPollOptionImpl>
    implements _$$SnPollOptionImplCopyWith<$Res> {
  __$$SnPollOptionImplCopyWithImpl(
      _$SnPollOptionImpl _value, $Res Function(_$SnPollOptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnPollOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? icon = null,
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_$SnPollOptionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnPollOptionImpl implements _SnPollOption {
  const _$SnPollOptionImpl(
      {required this.id,
      required this.icon,
      required this.name,
      required this.description});

  factory _$SnPollOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnPollOptionImplFromJson(json);

  @override
  final String id;
  @override
  final String icon;
  @override
  final String name;
  @override
  final String description;

  @override
  String toString() {
    return 'SnPollOption(id: $id, icon: $icon, name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnPollOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, icon, name, description);

  /// Create a copy of SnPollOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnPollOptionImplCopyWith<_$SnPollOptionImpl> get copyWith =>
      __$$SnPollOptionImplCopyWithImpl<_$SnPollOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnPollOptionImplToJson(
      this,
    );
  }
}

abstract class _SnPollOption implements SnPollOption {
  const factory _SnPollOption(
      {required final String id,
      required final String icon,
      required final String name,
      required final String description}) = _$SnPollOptionImpl;

  factory _SnPollOption.fromJson(Map<String, dynamic> json) =
      _$SnPollOptionImpl.fromJson;

  @override
  String get id;
  @override
  String get icon;
  @override
  String get name;
  @override
  String get description;

  /// Create a copy of SnPollOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnPollOptionImplCopyWith<_$SnPollOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
