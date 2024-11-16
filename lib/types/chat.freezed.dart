// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SnChannel _$SnChannelFromJson(Map<String, dynamic> json) {
  return _SnChannel.fromJson(json);
}

/// @nodoc
mixin _$SnChannel {
  @HiveField(0)
  int get id => throw _privateConstructorUsedError;
  @HiveField(1)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @HiveField(3)
  dynamic get deletedAt => throw _privateConstructorUsedError;
  @HiveField(4)
  String get alias => throw _privateConstructorUsedError;
  @HiveField(5)
  String get name => throw _privateConstructorUsedError;
  @HiveField(6)
  String get description => throw _privateConstructorUsedError;
  @HiveField(7)
  List<dynamic> get members => throw _privateConstructorUsedError;
  dynamic get messages => throw _privateConstructorUsedError;
  dynamic get calls => throw _privateConstructorUsedError;
  @HiveField(8)
  int get type => throw _privateConstructorUsedError;
  @HiveField(9)
  int get accountId => throw _privateConstructorUsedError;
  @HiveField(10)
  SnRealm? get realm => throw _privateConstructorUsedError;
  @HiveField(11)
  int? get realmId => throw _privateConstructorUsedError;
  @HiveField(12)
  bool get isPublic => throw _privateConstructorUsedError;
  @HiveField(13)
  bool get isCommunity => throw _privateConstructorUsedError;

  /// Serializes this SnChannel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnChannel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnChannelCopyWith<SnChannel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnChannelCopyWith<$Res> {
  factory $SnChannelCopyWith(SnChannel value, $Res Function(SnChannel) then) =
      _$SnChannelCopyWithImpl<$Res, SnChannel>;
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) DateTime createdAt,
      @HiveField(2) DateTime updatedAt,
      @HiveField(3) dynamic deletedAt,
      @HiveField(4) String alias,
      @HiveField(5) String name,
      @HiveField(6) String description,
      @HiveField(7) List<dynamic> members,
      dynamic messages,
      dynamic calls,
      @HiveField(8) int type,
      @HiveField(9) int accountId,
      @HiveField(10) SnRealm? realm,
      @HiveField(11) int? realmId,
      @HiveField(12) bool isPublic,
      @HiveField(13) bool isCommunity});

  $SnRealmCopyWith<$Res>? get realm;
}

/// @nodoc
class _$SnChannelCopyWithImpl<$Res, $Val extends SnChannel>
    implements $SnChannelCopyWith<$Res> {
  _$SnChannelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnChannel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? alias = null,
    Object? name = null,
    Object? description = null,
    Object? members = null,
    Object? messages = freezed,
    Object? calls = freezed,
    Object? type = null,
    Object? accountId = null,
    Object? realm = freezed,
    Object? realmId = freezed,
    Object? isPublic = null,
    Object? isCommunity = null,
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
      alias: null == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      messages: freezed == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as dynamic,
      calls: freezed == calls
          ? _value.calls
          : calls // ignore: cast_nullable_to_non_nullable
              as dynamic,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      realm: freezed == realm
          ? _value.realm
          : realm // ignore: cast_nullable_to_non_nullable
              as SnRealm?,
      realmId: freezed == realmId
          ? _value.realmId
          : realmId // ignore: cast_nullable_to_non_nullable
              as int?,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      isCommunity: null == isCommunity
          ? _value.isCommunity
          : isCommunity // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of SnChannel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnRealmCopyWith<$Res>? get realm {
    if (_value.realm == null) {
      return null;
    }

    return $SnRealmCopyWith<$Res>(_value.realm!, (value) {
      return _then(_value.copyWith(realm: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SnChannelImplCopyWith<$Res>
    implements $SnChannelCopyWith<$Res> {
  factory _$$SnChannelImplCopyWith(
          _$SnChannelImpl value, $Res Function(_$SnChannelImpl) then) =
      __$$SnChannelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) DateTime createdAt,
      @HiveField(2) DateTime updatedAt,
      @HiveField(3) dynamic deletedAt,
      @HiveField(4) String alias,
      @HiveField(5) String name,
      @HiveField(6) String description,
      @HiveField(7) List<dynamic> members,
      dynamic messages,
      dynamic calls,
      @HiveField(8) int type,
      @HiveField(9) int accountId,
      @HiveField(10) SnRealm? realm,
      @HiveField(11) int? realmId,
      @HiveField(12) bool isPublic,
      @HiveField(13) bool isCommunity});

  @override
  $SnRealmCopyWith<$Res>? get realm;
}

/// @nodoc
class __$$SnChannelImplCopyWithImpl<$Res>
    extends _$SnChannelCopyWithImpl<$Res, _$SnChannelImpl>
    implements _$$SnChannelImplCopyWith<$Res> {
  __$$SnChannelImplCopyWithImpl(
      _$SnChannelImpl _value, $Res Function(_$SnChannelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnChannel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? alias = null,
    Object? name = null,
    Object? description = null,
    Object? members = null,
    Object? messages = freezed,
    Object? calls = freezed,
    Object? type = null,
    Object? accountId = null,
    Object? realm = freezed,
    Object? realmId = freezed,
    Object? isPublic = null,
    Object? isCommunity = null,
  }) {
    return _then(_$SnChannelImpl(
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
      alias: null == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      messages: freezed == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as dynamic,
      calls: freezed == calls
          ? _value.calls
          : calls // ignore: cast_nullable_to_non_nullable
              as dynamic,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      realm: freezed == realm
          ? _value.realm
          : realm // ignore: cast_nullable_to_non_nullable
              as SnRealm?,
      realmId: freezed == realmId
          ? _value.realmId
          : realmId // ignore: cast_nullable_to_non_nullable
              as int?,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      isCommunity: null == isCommunity
          ? _value.isCommunity
          : isCommunity // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 2)
class _$SnChannelImpl extends _SnChannel {
  const _$SnChannelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.createdAt,
      @HiveField(2) required this.updatedAt,
      @HiveField(3) required this.deletedAt,
      @HiveField(4) required this.alias,
      @HiveField(5) required this.name,
      @HiveField(6) required this.description,
      @HiveField(7) required final List<dynamic> members,
      this.messages,
      this.calls,
      @HiveField(8) required this.type,
      @HiveField(9) required this.accountId,
      @HiveField(10) required this.realm,
      @HiveField(11) required this.realmId,
      @HiveField(12) required this.isPublic,
      @HiveField(13) required this.isCommunity})
      : _members = members,
        super._();

  factory _$SnChannelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnChannelImplFromJson(json);

  @override
  @HiveField(0)
  final int id;
  @override
  @HiveField(1)
  final DateTime createdAt;
  @override
  @HiveField(2)
  final DateTime updatedAt;
  @override
  @HiveField(3)
  final dynamic deletedAt;
  @override
  @HiveField(4)
  final String alias;
  @override
  @HiveField(5)
  final String name;
  @override
  @HiveField(6)
  final String description;
  final List<dynamic> _members;
  @override
  @HiveField(7)
  List<dynamic> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  final dynamic messages;
  @override
  final dynamic calls;
  @override
  @HiveField(8)
  final int type;
  @override
  @HiveField(9)
  final int accountId;
  @override
  @HiveField(10)
  final SnRealm? realm;
  @override
  @HiveField(11)
  final int? realmId;
  @override
  @HiveField(12)
  final bool isPublic;
  @override
  @HiveField(13)
  final bool isCommunity;

  @override
  String toString() {
    return 'SnChannel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, alias: $alias, name: $name, description: $description, members: $members, messages: $messages, calls: $calls, type: $type, accountId: $accountId, realm: $realm, realmId: $realmId, isPublic: $isPublic, isCommunity: $isCommunity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnChannelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other.deletedAt, deletedAt) &&
            (identical(other.alias, alias) || other.alias == alias) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            const DeepCollectionEquality().equals(other.messages, messages) &&
            const DeepCollectionEquality().equals(other.calls, calls) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.realm, realm) || other.realm == realm) &&
            (identical(other.realmId, realmId) || other.realmId == realmId) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.isCommunity, isCommunity) ||
                other.isCommunity == isCommunity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(deletedAt),
      alias,
      name,
      description,
      const DeepCollectionEquality().hash(_members),
      const DeepCollectionEquality().hash(messages),
      const DeepCollectionEquality().hash(calls),
      type,
      accountId,
      realm,
      realmId,
      isPublic,
      isCommunity);

  /// Create a copy of SnChannel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnChannelImplCopyWith<_$SnChannelImpl> get copyWith =>
      __$$SnChannelImplCopyWithImpl<_$SnChannelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnChannelImplToJson(
      this,
    );
  }
}

abstract class _SnChannel extends SnChannel {
  const factory _SnChannel(
      {@HiveField(0) required final int id,
      @HiveField(1) required final DateTime createdAt,
      @HiveField(2) required final DateTime updatedAt,
      @HiveField(3) required final dynamic deletedAt,
      @HiveField(4) required final String alias,
      @HiveField(5) required final String name,
      @HiveField(6) required final String description,
      @HiveField(7) required final List<dynamic> members,
      final dynamic messages,
      final dynamic calls,
      @HiveField(8) required final int type,
      @HiveField(9) required final int accountId,
      @HiveField(10) required final SnRealm? realm,
      @HiveField(11) required final int? realmId,
      @HiveField(12) required final bool isPublic,
      @HiveField(13) required final bool isCommunity}) = _$SnChannelImpl;
  const _SnChannel._() : super._();

  factory _SnChannel.fromJson(Map<String, dynamic> json) =
      _$SnChannelImpl.fromJson;

  @override
  @HiveField(0)
  int get id;
  @override
  @HiveField(1)
  DateTime get createdAt;
  @override
  @HiveField(2)
  DateTime get updatedAt;
  @override
  @HiveField(3)
  dynamic get deletedAt;
  @override
  @HiveField(4)
  String get alias;
  @override
  @HiveField(5)
  String get name;
  @override
  @HiveField(6)
  String get description;
  @override
  @HiveField(7)
  List<dynamic> get members;
  @override
  dynamic get messages;
  @override
  dynamic get calls;
  @override
  @HiveField(8)
  int get type;
  @override
  @HiveField(9)
  int get accountId;
  @override
  @HiveField(10)
  SnRealm? get realm;
  @override
  @HiveField(11)
  int? get realmId;
  @override
  @HiveField(12)
  bool get isPublic;
  @override
  @HiveField(13)
  bool get isCommunity;

  /// Create a copy of SnChannel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnChannelImplCopyWith<_$SnChannelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
