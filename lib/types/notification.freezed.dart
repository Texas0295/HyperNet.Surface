// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SnNotification _$SnNotificationFromJson(Map<String, dynamic> json) {
  return _SnNotification.fromJson(json);
}

/// @nodoc
mixin _$SnNotification {
  int get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  String get topic => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;
  int? get senderId => throw _privateConstructorUsedError;
  int get accountId => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError;

  /// Serializes this SnNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnNotificationCopyWith<SnNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnNotificationCopyWith<$Res> {
  factory $SnNotificationCopyWith(
          SnNotification value, $Res Function(SnNotification) then) =
      _$SnNotificationCopyWithImpl<$Res, SnNotification>;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String topic,
      String title,
      String? subtitle,
      String body,
      Map<String, dynamic> metadata,
      int priority,
      int? senderId,
      int accountId,
      DateTime? readAt});
}

/// @nodoc
class _$SnNotificationCopyWithImpl<$Res, $Val extends SnNotification>
    implements $SnNotificationCopyWith<$Res> {
  _$SnNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? topic = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? body = null,
    Object? metadata = null,
    Object? priority = null,
    Object? senderId = freezed,
    Object? accountId = null,
    Object? readAt = freezed,
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
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int?,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SnNotificationImplCopyWith<$Res>
    implements $SnNotificationCopyWith<$Res> {
  factory _$$SnNotificationImplCopyWith(_$SnNotificationImpl value,
          $Res Function(_$SnNotificationImpl) then) =
      __$$SnNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String topic,
      String title,
      String? subtitle,
      String body,
      Map<String, dynamic> metadata,
      int priority,
      int? senderId,
      int accountId,
      DateTime? readAt});
}

/// @nodoc
class __$$SnNotificationImplCopyWithImpl<$Res>
    extends _$SnNotificationCopyWithImpl<$Res, _$SnNotificationImpl>
    implements _$$SnNotificationImplCopyWith<$Res> {
  __$$SnNotificationImplCopyWithImpl(
      _$SnNotificationImpl _value, $Res Function(_$SnNotificationImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? topic = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? body = null,
    Object? metadata = null,
    Object? priority = null,
    Object? senderId = freezed,
    Object? accountId = null,
    Object? readAt = freezed,
  }) {
    return _then(_$SnNotificationImpl(
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
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      senderId: freezed == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as int?,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnNotificationImpl implements _SnNotification {
  const _$SnNotificationImpl(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.topic,
      required this.title,
      required this.subtitle,
      required this.body,
      final Map<String, dynamic> metadata = const {},
      required this.priority,
      required this.senderId,
      required this.accountId,
      required this.readAt})
      : _metadata = metadata;

  factory _$SnNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnNotificationImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final String topic;
  @override
  final String title;
  @override
  final String? subtitle;
  @override
  final String body;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  final int priority;
  @override
  final int? senderId;
  @override
  final int accountId;
  @override
  final DateTime? readAt;

  @override
  String toString() {
    return 'SnNotification(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, topic: $topic, title: $title, subtitle: $subtitle, body: $body, metadata: $metadata, priority: $priority, senderId: $senderId, accountId: $accountId, readAt: $readAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.body, body) || other.body == body) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      deletedAt,
      topic,
      title,
      subtitle,
      body,
      const DeepCollectionEquality().hash(_metadata),
      priority,
      senderId,
      accountId,
      readAt);

  /// Create a copy of SnNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnNotificationImplCopyWith<_$SnNotificationImpl> get copyWith =>
      __$$SnNotificationImplCopyWithImpl<_$SnNotificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnNotificationImplToJson(
      this,
    );
  }
}

abstract class _SnNotification implements SnNotification {
  const factory _SnNotification(
      {required final int id,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final DateTime? deletedAt,
      required final String topic,
      required final String title,
      required final String? subtitle,
      required final String body,
      final Map<String, dynamic> metadata,
      required final int priority,
      required final int? senderId,
      required final int accountId,
      required final DateTime? readAt}) = _$SnNotificationImpl;

  factory _SnNotification.fromJson(Map<String, dynamic> json) =
      _$SnNotificationImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get deletedAt;
  @override
  String get topic;
  @override
  String get title;
  @override
  String? get subtitle;
  @override
  String get body;
  @override
  Map<String, dynamic> get metadata;
  @override
  int get priority;
  @override
  int? get senderId;
  @override
  int get accountId;
  @override
  DateTime? get readAt;

  /// Create a copy of SnNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnNotificationImplCopyWith<_$SnNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
