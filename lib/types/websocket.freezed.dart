// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'websocket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WebSocketPackage _$WebSocketPackageFromJson(Map<String, dynamic> json) {
  return _WebSocketPackage.fromJson(json);
}

/// @nodoc
mixin _$WebSocketPackage {
  @JsonKey(name: 'w')
  String get method => throw _privateConstructorUsedError;
  @JsonKey(name: 'e')
  String? get endpoint => throw _privateConstructorUsedError;
  @JsonKey(name: 'm')
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'p')
  Map<String, dynamic>? get payload => throw _privateConstructorUsedError;

  /// Serializes this WebSocketPackage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WebSocketPackage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebSocketPackageCopyWith<WebSocketPackage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebSocketPackageCopyWith<$Res> {
  factory $WebSocketPackageCopyWith(
          WebSocketPackage value, $Res Function(WebSocketPackage) then) =
      _$WebSocketPackageCopyWithImpl<$Res, WebSocketPackage>;
  @useResult
  $Res call(
      {@JsonKey(name: 'w') String method,
      @JsonKey(name: 'e') String? endpoint,
      @JsonKey(name: 'm') String? message,
      @JsonKey(name: 'p') Map<String, dynamic>? payload});
}

/// @nodoc
class _$WebSocketPackageCopyWithImpl<$Res, $Val extends WebSocketPackage>
    implements $WebSocketPackageCopyWith<$Res> {
  _$WebSocketPackageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebSocketPackage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? endpoint = freezed,
    Object? message = freezed,
    Object? payload = freezed,
  }) {
    return _then(_value.copyWith(
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      endpoint: freezed == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      payload: freezed == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebSocketPackageImplCopyWith<$Res>
    implements $WebSocketPackageCopyWith<$Res> {
  factory _$$WebSocketPackageImplCopyWith(_$WebSocketPackageImpl value,
          $Res Function(_$WebSocketPackageImpl) then) =
      __$$WebSocketPackageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'w') String method,
      @JsonKey(name: 'e') String? endpoint,
      @JsonKey(name: 'm') String? message,
      @JsonKey(name: 'p') Map<String, dynamic>? payload});
}

/// @nodoc
class __$$WebSocketPackageImplCopyWithImpl<$Res>
    extends _$WebSocketPackageCopyWithImpl<$Res, _$WebSocketPackageImpl>
    implements _$$WebSocketPackageImplCopyWith<$Res> {
  __$$WebSocketPackageImplCopyWithImpl(_$WebSocketPackageImpl _value,
      $Res Function(_$WebSocketPackageImpl) _then)
      : super(_value, _then);

  /// Create a copy of WebSocketPackage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? endpoint = freezed,
    Object? message = freezed,
    Object? payload = freezed,
  }) {
    return _then(_$WebSocketPackageImpl(
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      endpoint: freezed == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      payload: freezed == payload
          ? _value._payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebSocketPackageImpl implements _WebSocketPackage {
  const _$WebSocketPackageImpl(
      {@JsonKey(name: 'w') this.method = 'unknown',
      @JsonKey(name: 'e') this.endpoint,
      @JsonKey(name: 'm') this.message,
      @JsonKey(name: 'p') final Map<String, dynamic>? payload = const {}})
      : _payload = payload;

  factory _$WebSocketPackageImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebSocketPackageImplFromJson(json);

  @override
  @JsonKey(name: 'w')
  final String method;
  @override
  @JsonKey(name: 'e')
  final String? endpoint;
  @override
  @JsonKey(name: 'm')
  final String? message;
  final Map<String, dynamic>? _payload;
  @override
  @JsonKey(name: 'p')
  Map<String, dynamic>? get payload {
    final value = _payload;
    if (value == null) return null;
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'WebSocketPackage(method: $method, endpoint: $endpoint, message: $message, payload: $payload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketPackageImpl &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.endpoint, endpoint) ||
                other.endpoint == endpoint) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._payload, _payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, method, endpoint, message,
      const DeepCollectionEquality().hash(_payload));

  /// Create a copy of WebSocketPackage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSocketPackageImplCopyWith<_$WebSocketPackageImpl> get copyWith =>
      __$$WebSocketPackageImplCopyWithImpl<_$WebSocketPackageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebSocketPackageImplToJson(
      this,
    );
  }
}

abstract class _WebSocketPackage implements WebSocketPackage {
  const factory _WebSocketPackage(
          {@JsonKey(name: 'w') final String method,
          @JsonKey(name: 'e') final String? endpoint,
          @JsonKey(name: 'm') final String? message,
          @JsonKey(name: 'p') final Map<String, dynamic>? payload}) =
      _$WebSocketPackageImpl;

  factory _WebSocketPackage.fromJson(Map<String, dynamic> json) =
      _$WebSocketPackageImpl.fromJson;

  @override
  @JsonKey(name: 'w')
  String get method;
  @override
  @JsonKey(name: 'e')
  String? get endpoint;
  @override
  @JsonKey(name: 'm')
  String? get message;
  @override
  @JsonKey(name: 'p')
  Map<String, dynamic>? get payload;

  /// Create a copy of WebSocketPackage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSocketPackageImplCopyWith<_$WebSocketPackageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
