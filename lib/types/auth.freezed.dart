// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SnAuthResult _$SnAuthResultFromJson(Map<String, dynamic> json) {
  return _SnAuthResult.fromJson(json);
}

/// @nodoc
mixin _$SnAuthResult {
  bool get isFinished => throw _privateConstructorUsedError;
  SnAuthTicket? get ticket => throw _privateConstructorUsedError;

  /// Serializes this SnAuthResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnAuthResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnAuthResultCopyWith<SnAuthResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnAuthResultCopyWith<$Res> {
  factory $SnAuthResultCopyWith(
          SnAuthResult value, $Res Function(SnAuthResult) then) =
      _$SnAuthResultCopyWithImpl<$Res, SnAuthResult>;
  @useResult
  $Res call({bool isFinished, SnAuthTicket? ticket});

  $SnAuthTicketCopyWith<$Res>? get ticket;
}

/// @nodoc
class _$SnAuthResultCopyWithImpl<$Res, $Val extends SnAuthResult>
    implements $SnAuthResultCopyWith<$Res> {
  _$SnAuthResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnAuthResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFinished = null,
    Object? ticket = freezed,
  }) {
    return _then(_value.copyWith(
      isFinished: null == isFinished
          ? _value.isFinished
          : isFinished // ignore: cast_nullable_to_non_nullable
              as bool,
      ticket: freezed == ticket
          ? _value.ticket
          : ticket // ignore: cast_nullable_to_non_nullable
              as SnAuthTicket?,
    ) as $Val);
  }

  /// Create a copy of SnAuthResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnAuthTicketCopyWith<$Res>? get ticket {
    if (_value.ticket == null) {
      return null;
    }

    return $SnAuthTicketCopyWith<$Res>(_value.ticket!, (value) {
      return _then(_value.copyWith(ticket: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SnAuthResultImplCopyWith<$Res>
    implements $SnAuthResultCopyWith<$Res> {
  factory _$$SnAuthResultImplCopyWith(
          _$SnAuthResultImpl value, $Res Function(_$SnAuthResultImpl) then) =
      __$$SnAuthResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isFinished, SnAuthTicket? ticket});

  @override
  $SnAuthTicketCopyWith<$Res>? get ticket;
}

/// @nodoc
class __$$SnAuthResultImplCopyWithImpl<$Res>
    extends _$SnAuthResultCopyWithImpl<$Res, _$SnAuthResultImpl>
    implements _$$SnAuthResultImplCopyWith<$Res> {
  __$$SnAuthResultImplCopyWithImpl(
      _$SnAuthResultImpl _value, $Res Function(_$SnAuthResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnAuthResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isFinished = null,
    Object? ticket = freezed,
  }) {
    return _then(_$SnAuthResultImpl(
      isFinished: null == isFinished
          ? _value.isFinished
          : isFinished // ignore: cast_nullable_to_non_nullable
              as bool,
      ticket: freezed == ticket
          ? _value.ticket
          : ticket // ignore: cast_nullable_to_non_nullable
              as SnAuthTicket?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnAuthResultImpl implements _SnAuthResult {
  const _$SnAuthResultImpl({required this.isFinished, required this.ticket});

  factory _$SnAuthResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnAuthResultImplFromJson(json);

  @override
  final bool isFinished;
  @override
  final SnAuthTicket? ticket;

  @override
  String toString() {
    return 'SnAuthResult(isFinished: $isFinished, ticket: $ticket)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnAuthResultImpl &&
            (identical(other.isFinished, isFinished) ||
                other.isFinished == isFinished) &&
            (identical(other.ticket, ticket) || other.ticket == ticket));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isFinished, ticket);

  /// Create a copy of SnAuthResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnAuthResultImplCopyWith<_$SnAuthResultImpl> get copyWith =>
      __$$SnAuthResultImplCopyWithImpl<_$SnAuthResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnAuthResultImplToJson(
      this,
    );
  }
}

abstract class _SnAuthResult implements SnAuthResult {
  const factory _SnAuthResult(
      {required final bool isFinished,
      required final SnAuthTicket? ticket}) = _$SnAuthResultImpl;

  factory _SnAuthResult.fromJson(Map<String, dynamic> json) =
      _$SnAuthResultImpl.fromJson;

  @override
  bool get isFinished;
  @override
  SnAuthTicket? get ticket;

  /// Create a copy of SnAuthResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnAuthResultImplCopyWith<_$SnAuthResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SnAuthTicket _$SnAuthTicketFromJson(Map<String, dynamic> json) {
  return _SnAuthTicket.fromJson(json);
}

/// @nodoc
mixin _$SnAuthTicket {
  int get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  int get stepRemain => throw _privateConstructorUsedError;
  String? get grantToken => throw _privateConstructorUsedError;
  String? get accessToken => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;
  String get ipAddress => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get userAgent => throw _privateConstructorUsedError;
  DateTime? get expiredAt => throw _privateConstructorUsedError;
  DateTime? get lastGrantAt => throw _privateConstructorUsedError;
  DateTime? get availableAt => throw _privateConstructorUsedError;
  String? get nonce => throw _privateConstructorUsedError;
  int? get accountId => throw _privateConstructorUsedError;
  List<int> get factorTrail => throw _privateConstructorUsedError;

  /// Serializes this SnAuthTicket to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnAuthTicket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnAuthTicketCopyWith<SnAuthTicket> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnAuthTicketCopyWith<$Res> {
  factory $SnAuthTicketCopyWith(
          SnAuthTicket value, $Res Function(SnAuthTicket) then) =
      _$SnAuthTicketCopyWithImpl<$Res, SnAuthTicket>;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      int stepRemain,
      String? grantToken,
      String? accessToken,
      String? refreshToken,
      String ipAddress,
      String location,
      String userAgent,
      DateTime? expiredAt,
      DateTime? lastGrantAt,
      DateTime? availableAt,
      String? nonce,
      int? accountId,
      List<int> factorTrail});
}

/// @nodoc
class _$SnAuthTicketCopyWithImpl<$Res, $Val extends SnAuthTicket>
    implements $SnAuthTicketCopyWith<$Res> {
  _$SnAuthTicketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnAuthTicket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? stepRemain = null,
    Object? grantToken = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? ipAddress = null,
    Object? location = null,
    Object? userAgent = null,
    Object? expiredAt = freezed,
    Object? lastGrantAt = freezed,
    Object? availableAt = freezed,
    Object? nonce = freezed,
    Object? accountId = freezed,
    Object? factorTrail = null,
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
              as DateTime?,
      stepRemain: null == stepRemain
          ? _value.stepRemain
          : stepRemain // ignore: cast_nullable_to_non_nullable
              as int,
      grantToken: freezed == grantToken
          ? _value.grantToken
          : grantToken // ignore: cast_nullable_to_non_nullable
              as String?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      ipAddress: null == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      userAgent: null == userAgent
          ? _value.userAgent
          : userAgent // ignore: cast_nullable_to_non_nullable
              as String,
      expiredAt: freezed == expiredAt
          ? _value.expiredAt
          : expiredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastGrantAt: freezed == lastGrantAt
          ? _value.lastGrantAt
          : lastGrantAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      availableAt: freezed == availableAt
          ? _value.availableAt
          : availableAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nonce: freezed == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String?,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int?,
      factorTrail: null == factorTrail
          ? _value.factorTrail
          : factorTrail // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SnAuthTicketImplCopyWith<$Res>
    implements $SnAuthTicketCopyWith<$Res> {
  factory _$$SnAuthTicketImplCopyWith(
          _$SnAuthTicketImpl value, $Res Function(_$SnAuthTicketImpl) then) =
      __$$SnAuthTicketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      int stepRemain,
      String? grantToken,
      String? accessToken,
      String? refreshToken,
      String ipAddress,
      String location,
      String userAgent,
      DateTime? expiredAt,
      DateTime? lastGrantAt,
      DateTime? availableAt,
      String? nonce,
      int? accountId,
      List<int> factorTrail});
}

/// @nodoc
class __$$SnAuthTicketImplCopyWithImpl<$Res>
    extends _$SnAuthTicketCopyWithImpl<$Res, _$SnAuthTicketImpl>
    implements _$$SnAuthTicketImplCopyWith<$Res> {
  __$$SnAuthTicketImplCopyWithImpl(
      _$SnAuthTicketImpl _value, $Res Function(_$SnAuthTicketImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnAuthTicket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? stepRemain = null,
    Object? grantToken = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? ipAddress = null,
    Object? location = null,
    Object? userAgent = null,
    Object? expiredAt = freezed,
    Object? lastGrantAt = freezed,
    Object? availableAt = freezed,
    Object? nonce = freezed,
    Object? accountId = freezed,
    Object? factorTrail = null,
  }) {
    return _then(_$SnAuthTicketImpl(
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
              as DateTime?,
      stepRemain: null == stepRemain
          ? _value.stepRemain
          : stepRemain // ignore: cast_nullable_to_non_nullable
              as int,
      grantToken: freezed == grantToken
          ? _value.grantToken
          : grantToken // ignore: cast_nullable_to_non_nullable
              as String?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      ipAddress: null == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      userAgent: null == userAgent
          ? _value.userAgent
          : userAgent // ignore: cast_nullable_to_non_nullable
              as String,
      expiredAt: freezed == expiredAt
          ? _value.expiredAt
          : expiredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastGrantAt: freezed == lastGrantAt
          ? _value.lastGrantAt
          : lastGrantAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      availableAt: freezed == availableAt
          ? _value.availableAt
          : availableAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nonce: freezed == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String?,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int?,
      factorTrail: null == factorTrail
          ? _value._factorTrail
          : factorTrail // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnAuthTicketImpl implements _SnAuthTicket {
  const _$SnAuthTicketImpl(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.stepRemain,
      required this.grantToken,
      required this.accessToken,
      required this.refreshToken,
      required this.ipAddress,
      required this.location,
      required this.userAgent,
      required this.expiredAt,
      required this.lastGrantAt,
      required this.availableAt,
      required this.nonce,
      required this.accountId,
      final List<int> factorTrail = const []})
      : _factorTrail = factorTrail;

  factory _$SnAuthTicketImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnAuthTicketImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final int stepRemain;
  @override
  final String? grantToken;
  @override
  final String? accessToken;
  @override
  final String? refreshToken;
  @override
  final String ipAddress;
  @override
  final String location;
  @override
  final String userAgent;
  @override
  final DateTime? expiredAt;
  @override
  final DateTime? lastGrantAt;
  @override
  final DateTime? availableAt;
  @override
  final String? nonce;
  @override
  final int? accountId;
  final List<int> _factorTrail;
  @override
  @JsonKey()
  List<int> get factorTrail {
    if (_factorTrail is EqualUnmodifiableListView) return _factorTrail;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_factorTrail);
  }

  @override
  String toString() {
    return 'SnAuthTicket(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, stepRemain: $stepRemain, grantToken: $grantToken, accessToken: $accessToken, refreshToken: $refreshToken, ipAddress: $ipAddress, location: $location, userAgent: $userAgent, expiredAt: $expiredAt, lastGrantAt: $lastGrantAt, availableAt: $availableAt, nonce: $nonce, accountId: $accountId, factorTrail: $factorTrail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnAuthTicketImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.stepRemain, stepRemain) ||
                other.stepRemain == stepRemain) &&
            (identical(other.grantToken, grantToken) ||
                other.grantToken == grantToken) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.userAgent, userAgent) ||
                other.userAgent == userAgent) &&
            (identical(other.expiredAt, expiredAt) ||
                other.expiredAt == expiredAt) &&
            (identical(other.lastGrantAt, lastGrantAt) ||
                other.lastGrantAt == lastGrantAt) &&
            (identical(other.availableAt, availableAt) ||
                other.availableAt == availableAt) &&
            (identical(other.nonce, nonce) || other.nonce == nonce) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            const DeepCollectionEquality()
                .equals(other._factorTrail, _factorTrail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      deletedAt,
      stepRemain,
      grantToken,
      accessToken,
      refreshToken,
      ipAddress,
      location,
      userAgent,
      expiredAt,
      lastGrantAt,
      availableAt,
      nonce,
      accountId,
      const DeepCollectionEquality().hash(_factorTrail));

  /// Create a copy of SnAuthTicket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnAuthTicketImplCopyWith<_$SnAuthTicketImpl> get copyWith =>
      __$$SnAuthTicketImplCopyWithImpl<_$SnAuthTicketImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnAuthTicketImplToJson(
      this,
    );
  }
}

abstract class _SnAuthTicket implements SnAuthTicket {
  const factory _SnAuthTicket(
      {required final int id,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final DateTime? deletedAt,
      required final int stepRemain,
      required final String? grantToken,
      required final String? accessToken,
      required final String? refreshToken,
      required final String ipAddress,
      required final String location,
      required final String userAgent,
      required final DateTime? expiredAt,
      required final DateTime? lastGrantAt,
      required final DateTime? availableAt,
      required final String? nonce,
      required final int? accountId,
      final List<int> factorTrail}) = _$SnAuthTicketImpl;

  factory _SnAuthTicket.fromJson(Map<String, dynamic> json) =
      _$SnAuthTicketImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get deletedAt;
  @override
  int get stepRemain;
  @override
  String? get grantToken;
  @override
  String? get accessToken;
  @override
  String? get refreshToken;
  @override
  String get ipAddress;
  @override
  String get location;
  @override
  String get userAgent;
  @override
  DateTime? get expiredAt;
  @override
  DateTime? get lastGrantAt;
  @override
  DateTime? get availableAt;
  @override
  String? get nonce;
  @override
  int? get accountId;
  @override
  List<int> get factorTrail;

  /// Create a copy of SnAuthTicket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnAuthTicketImplCopyWith<_$SnAuthTicketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SnAuthFactor _$SnAuthFactorFromJson(Map<String, dynamic> json) {
  return _SnAuthFactor.fromJson(json);
}

/// @nodoc
mixin _$SnAuthFactor {
  int get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;
  Map<String, dynamic>? get config => throw _privateConstructorUsedError;
  int? get accountId => throw _privateConstructorUsedError;

  /// Serializes this SnAuthFactor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnAuthFactor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnAuthFactorCopyWith<SnAuthFactor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnAuthFactorCopyWith<$Res> {
  factory $SnAuthFactorCopyWith(
          SnAuthFactor value, $Res Function(SnAuthFactor) then) =
      _$SnAuthFactorCopyWithImpl<$Res, SnAuthFactor>;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      int type,
      Map<String, dynamic>? config,
      int? accountId});
}

/// @nodoc
class _$SnAuthFactorCopyWithImpl<$Res, $Val extends SnAuthFactor>
    implements $SnAuthFactorCopyWith<$Res> {
  _$SnAuthFactorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnAuthFactor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? type = null,
    Object? config = freezed,
    Object? accountId = freezed,
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
              as DateTime?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      config: freezed == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SnAuthFactorImplCopyWith<$Res>
    implements $SnAuthFactorCopyWith<$Res> {
  factory _$$SnAuthFactorImplCopyWith(
          _$SnAuthFactorImpl value, $Res Function(_$SnAuthFactorImpl) then) =
      __$$SnAuthFactorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      int type,
      Map<String, dynamic>? config,
      int? accountId});
}

/// @nodoc
class __$$SnAuthFactorImplCopyWithImpl<$Res>
    extends _$SnAuthFactorCopyWithImpl<$Res, _$SnAuthFactorImpl>
    implements _$$SnAuthFactorImplCopyWith<$Res> {
  __$$SnAuthFactorImplCopyWithImpl(
      _$SnAuthFactorImpl _value, $Res Function(_$SnAuthFactorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnAuthFactor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? type = null,
    Object? config = freezed,
    Object? accountId = freezed,
  }) {
    return _then(_$SnAuthFactorImpl(
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
              as DateTime?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      config: freezed == config
          ? _value._config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnAuthFactorImpl implements _SnAuthFactor {
  const _$SnAuthFactorImpl(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.type,
      required final Map<String, dynamic>? config,
      required this.accountId})
      : _config = config;

  factory _$SnAuthFactorImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnAuthFactorImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final int type;
  final Map<String, dynamic>? _config;
  @override
  Map<String, dynamic>? get config {
    final value = _config;
    if (value == null) return null;
    if (_config is EqualUnmodifiableMapView) return _config;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final int? accountId;

  @override
  String toString() {
    return 'SnAuthFactor(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, type: $type, config: $config, accountId: $accountId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnAuthFactorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._config, _config) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, updatedAt,
      deletedAt, type, const DeepCollectionEquality().hash(_config), accountId);

  /// Create a copy of SnAuthFactor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnAuthFactorImplCopyWith<_$SnAuthFactorImpl> get copyWith =>
      __$$SnAuthFactorImplCopyWithImpl<_$SnAuthFactorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnAuthFactorImplToJson(
      this,
    );
  }
}

abstract class _SnAuthFactor implements SnAuthFactor {
  const factory _SnAuthFactor(
      {required final int id,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final DateTime? deletedAt,
      required final int type,
      required final Map<String, dynamic>? config,
      required final int? accountId}) = _$SnAuthFactorImpl;

  factory _SnAuthFactor.fromJson(Map<String, dynamic> json) =
      _$SnAuthFactorImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get deletedAt;
  @override
  int get type;
  @override
  Map<String, dynamic>? get config;
  @override
  int? get accountId;

  /// Create a copy of SnAuthFactor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnAuthFactorImplCopyWith<_$SnAuthFactorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
