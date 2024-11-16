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
  int get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  dynamic get deletedAt => throw _privateConstructorUsedError;
  String get alias => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<dynamic> get members => throw _privateConstructorUsedError;
  dynamic get messages => throw _privateConstructorUsedError;
  dynamic get calls => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;
  int get accountId => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  bool get isCommunity => throw _privateConstructorUsedError;
  SnRealm? get realm => throw _privateConstructorUsedError;
  int? get realmId => throw _privateConstructorUsedError;

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
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      dynamic deletedAt,
      String alias,
      String name,
      String description,
      List<dynamic> members,
      dynamic messages,
      dynamic calls,
      int type,
      int accountId,
      bool isPublic,
      bool isCommunity,
      SnRealm? realm,
      int? realmId});

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
    Object? isPublic = null,
    Object? isCommunity = null,
    Object? realm = freezed,
    Object? realmId = freezed,
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
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      isCommunity: null == isCommunity
          ? _value.isCommunity
          : isCommunity // ignore: cast_nullable_to_non_nullable
              as bool,
      realm: freezed == realm
          ? _value.realm
          : realm // ignore: cast_nullable_to_non_nullable
              as SnRealm?,
      realmId: freezed == realmId
          ? _value.realmId
          : realmId // ignore: cast_nullable_to_non_nullable
              as int?,
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
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      dynamic deletedAt,
      String alias,
      String name,
      String description,
      List<dynamic> members,
      dynamic messages,
      dynamic calls,
      int type,
      int accountId,
      bool isPublic,
      bool isCommunity,
      SnRealm? realm,
      int? realmId});

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
    Object? isPublic = null,
    Object? isCommunity = null,
    Object? realm = freezed,
    Object? realmId = freezed,
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
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      isCommunity: null == isCommunity
          ? _value.isCommunity
          : isCommunity // ignore: cast_nullable_to_non_nullable
              as bool,
      realm: freezed == realm
          ? _value.realm
          : realm // ignore: cast_nullable_to_non_nullable
              as SnRealm?,
      realmId: freezed == realmId
          ? _value.realmId
          : realmId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnChannelImpl implements _SnChannel {
  const _$SnChannelImpl(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.alias,
      required this.name,
      required this.description,
      required final List<dynamic> members,
      required this.messages,
      required this.calls,
      required this.type,
      required this.accountId,
      required this.isPublic,
      required this.isCommunity,
      required this.realm,
      required this.realmId})
      : _members = members;

  factory _$SnChannelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnChannelImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final dynamic deletedAt;
  @override
  final String alias;
  @override
  final String name;
  @override
  final String description;
  final List<dynamic> _members;
  @override
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
  final int type;
  @override
  final int accountId;
  @override
  final bool isPublic;
  @override
  final bool isCommunity;
  @override
  final SnRealm? realm;
  @override
  final int? realmId;

  @override
  String toString() {
    return 'SnChannel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, alias: $alias, name: $name, description: $description, members: $members, messages: $messages, calls: $calls, type: $type, accountId: $accountId, isPublic: $isPublic, isCommunity: $isCommunity, realm: $realm, realmId: $realmId)';
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
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.isCommunity, isCommunity) ||
                other.isCommunity == isCommunity) &&
            (identical(other.realm, realm) || other.realm == realm) &&
            (identical(other.realmId, realmId) || other.realmId == realmId));
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
      isPublic,
      isCommunity,
      realm,
      realmId);

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

abstract class _SnChannel implements SnChannel {
  const factory _SnChannel(
      {required final int id,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final dynamic deletedAt,
      required final String alias,
      required final String name,
      required final String description,
      required final List<dynamic> members,
      required final dynamic messages,
      required final dynamic calls,
      required final int type,
      required final int accountId,
      required final bool isPublic,
      required final bool isCommunity,
      required final SnRealm? realm,
      required final int? realmId}) = _$SnChannelImpl;

  factory _SnChannel.fromJson(Map<String, dynamic> json) =
      _$SnChannelImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  dynamic get deletedAt;
  @override
  String get alias;
  @override
  String get name;
  @override
  String get description;
  @override
  List<dynamic> get members;
  @override
  dynamic get messages;
  @override
  dynamic get calls;
  @override
  int get type;
  @override
  int get accountId;
  @override
  bool get isPublic;
  @override
  bool get isCommunity;
  @override
  SnRealm? get realm;
  @override
  int? get realmId;

  /// Create a copy of SnChannel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnChannelImplCopyWith<_$SnChannelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
