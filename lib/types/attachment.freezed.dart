// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attachment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SnAttachment _$SnAttachmentFromJson(Map<String, dynamic> json) {
  return _SnAttachment.fromJson(json);
}

/// @nodoc
mixin _$SnAttachment {
  int get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  dynamic get deletedAt => throw _privateConstructorUsedError;
  String get rid => throw _privateConstructorUsedError;
  String get uuid => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get alt => throw _privateConstructorUsedError;
  String get mimetype => throw _privateConstructorUsedError;
  String get hash => throw _privateConstructorUsedError;
  int get destination => throw _privateConstructorUsedError;
  int get refCount => throw _privateConstructorUsedError;
  dynamic get fileChunks => throw _privateConstructorUsedError;
  dynamic get cleanedAt => throw _privateConstructorUsedError;
  bool get isMature => throw _privateConstructorUsedError;
  bool get isAnalyzed => throw _privateConstructorUsedError;
  bool get isUploaded => throw _privateConstructorUsedError;
  bool get isSelfRef => throw _privateConstructorUsedError;
  dynamic get ref => throw _privateConstructorUsedError;
  dynamic get refId => throw _privateConstructorUsedError;
  SnAttachmentPool? get pool => throw _privateConstructorUsedError;
  int get poolId => throw _privateConstructorUsedError;
  int get accountId => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this SnAttachment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnAttachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnAttachmentCopyWith<SnAttachment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnAttachmentCopyWith<$Res> {
  factory $SnAttachmentCopyWith(
          SnAttachment value, $Res Function(SnAttachment) then) =
      _$SnAttachmentCopyWithImpl<$Res, SnAttachment>;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      dynamic deletedAt,
      String rid,
      String uuid,
      int size,
      String name,
      String alt,
      String mimetype,
      String hash,
      int destination,
      int refCount,
      dynamic fileChunks,
      dynamic cleanedAt,
      bool isMature,
      bool isAnalyzed,
      bool isUploaded,
      bool isSelfRef,
      dynamic ref,
      dynamic refId,
      SnAttachmentPool? pool,
      int poolId,
      int accountId,
      Map<String, dynamic> metadata});

  $SnAttachmentPoolCopyWith<$Res>? get pool;
}

/// @nodoc
class _$SnAttachmentCopyWithImpl<$Res, $Val extends SnAttachment>
    implements $SnAttachmentCopyWith<$Res> {
  _$SnAttachmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnAttachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? rid = null,
    Object? uuid = null,
    Object? size = null,
    Object? name = null,
    Object? alt = null,
    Object? mimetype = null,
    Object? hash = null,
    Object? destination = null,
    Object? refCount = null,
    Object? fileChunks = freezed,
    Object? cleanedAt = freezed,
    Object? isMature = null,
    Object? isAnalyzed = null,
    Object? isUploaded = null,
    Object? isSelfRef = null,
    Object? ref = freezed,
    Object? refId = freezed,
    Object? pool = freezed,
    Object? poolId = null,
    Object? accountId = null,
    Object? metadata = null,
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
      rid: null == rid
          ? _value.rid
          : rid // ignore: cast_nullable_to_non_nullable
              as String,
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      alt: null == alt
          ? _value.alt
          : alt // ignore: cast_nullable_to_non_nullable
              as String,
      mimetype: null == mimetype
          ? _value.mimetype
          : mimetype // ignore: cast_nullable_to_non_nullable
              as String,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as int,
      refCount: null == refCount
          ? _value.refCount
          : refCount // ignore: cast_nullable_to_non_nullable
              as int,
      fileChunks: freezed == fileChunks
          ? _value.fileChunks
          : fileChunks // ignore: cast_nullable_to_non_nullable
              as dynamic,
      cleanedAt: freezed == cleanedAt
          ? _value.cleanedAt
          : cleanedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isMature: null == isMature
          ? _value.isMature
          : isMature // ignore: cast_nullable_to_non_nullable
              as bool,
      isAnalyzed: null == isAnalyzed
          ? _value.isAnalyzed
          : isAnalyzed // ignore: cast_nullable_to_non_nullable
              as bool,
      isUploaded: null == isUploaded
          ? _value.isUploaded
          : isUploaded // ignore: cast_nullable_to_non_nullable
              as bool,
      isSelfRef: null == isSelfRef
          ? _value.isSelfRef
          : isSelfRef // ignore: cast_nullable_to_non_nullable
              as bool,
      ref: freezed == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as dynamic,
      refId: freezed == refId
          ? _value.refId
          : refId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      pool: freezed == pool
          ? _value.pool
          : pool // ignore: cast_nullable_to_non_nullable
              as SnAttachmentPool?,
      poolId: null == poolId
          ? _value.poolId
          : poolId // ignore: cast_nullable_to_non_nullable
              as int,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  /// Create a copy of SnAttachment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnAttachmentPoolCopyWith<$Res>? get pool {
    if (_value.pool == null) {
      return null;
    }

    return $SnAttachmentPoolCopyWith<$Res>(_value.pool!, (value) {
      return _then(_value.copyWith(pool: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SnAttachmentImplCopyWith<$Res>
    implements $SnAttachmentCopyWith<$Res> {
  factory _$$SnAttachmentImplCopyWith(
          _$SnAttachmentImpl value, $Res Function(_$SnAttachmentImpl) then) =
      __$$SnAttachmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      dynamic deletedAt,
      String rid,
      String uuid,
      int size,
      String name,
      String alt,
      String mimetype,
      String hash,
      int destination,
      int refCount,
      dynamic fileChunks,
      dynamic cleanedAt,
      bool isMature,
      bool isAnalyzed,
      bool isUploaded,
      bool isSelfRef,
      dynamic ref,
      dynamic refId,
      SnAttachmentPool? pool,
      int poolId,
      int accountId,
      Map<String, dynamic> metadata});

  @override
  $SnAttachmentPoolCopyWith<$Res>? get pool;
}

/// @nodoc
class __$$SnAttachmentImplCopyWithImpl<$Res>
    extends _$SnAttachmentCopyWithImpl<$Res, _$SnAttachmentImpl>
    implements _$$SnAttachmentImplCopyWith<$Res> {
  __$$SnAttachmentImplCopyWithImpl(
      _$SnAttachmentImpl _value, $Res Function(_$SnAttachmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnAttachment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? rid = null,
    Object? uuid = null,
    Object? size = null,
    Object? name = null,
    Object? alt = null,
    Object? mimetype = null,
    Object? hash = null,
    Object? destination = null,
    Object? refCount = null,
    Object? fileChunks = freezed,
    Object? cleanedAt = freezed,
    Object? isMature = null,
    Object? isAnalyzed = null,
    Object? isUploaded = null,
    Object? isSelfRef = null,
    Object? ref = freezed,
    Object? refId = freezed,
    Object? pool = freezed,
    Object? poolId = null,
    Object? accountId = null,
    Object? metadata = null,
  }) {
    return _then(_$SnAttachmentImpl(
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
      rid: null == rid
          ? _value.rid
          : rid // ignore: cast_nullable_to_non_nullable
              as String,
      uuid: null == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      alt: null == alt
          ? _value.alt
          : alt // ignore: cast_nullable_to_non_nullable
              as String,
      mimetype: null == mimetype
          ? _value.mimetype
          : mimetype // ignore: cast_nullable_to_non_nullable
              as String,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as int,
      refCount: null == refCount
          ? _value.refCount
          : refCount // ignore: cast_nullable_to_non_nullable
              as int,
      fileChunks: freezed == fileChunks
          ? _value.fileChunks
          : fileChunks // ignore: cast_nullable_to_non_nullable
              as dynamic,
      cleanedAt: freezed == cleanedAt
          ? _value.cleanedAt
          : cleanedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isMature: null == isMature
          ? _value.isMature
          : isMature // ignore: cast_nullable_to_non_nullable
              as bool,
      isAnalyzed: null == isAnalyzed
          ? _value.isAnalyzed
          : isAnalyzed // ignore: cast_nullable_to_non_nullable
              as bool,
      isUploaded: null == isUploaded
          ? _value.isUploaded
          : isUploaded // ignore: cast_nullable_to_non_nullable
              as bool,
      isSelfRef: null == isSelfRef
          ? _value.isSelfRef
          : isSelfRef // ignore: cast_nullable_to_non_nullable
              as bool,
      ref: freezed == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as dynamic,
      refId: freezed == refId
          ? _value.refId
          : refId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      pool: freezed == pool
          ? _value.pool
          : pool // ignore: cast_nullable_to_non_nullable
              as SnAttachmentPool?,
      poolId: null == poolId
          ? _value.poolId
          : poolId // ignore: cast_nullable_to_non_nullable
              as int,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnAttachmentImpl implements _SnAttachment {
  const _$SnAttachmentImpl(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.rid,
      required this.uuid,
      required this.size,
      required this.name,
      required this.alt,
      required this.mimetype,
      required this.hash,
      required this.destination,
      required this.refCount,
      required this.fileChunks,
      required this.cleanedAt,
      required this.isMature,
      required this.isAnalyzed,
      required this.isUploaded,
      required this.isSelfRef,
      required this.ref,
      required this.refId,
      required this.pool,
      required this.poolId,
      required this.accountId,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata;

  factory _$SnAttachmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnAttachmentImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final dynamic deletedAt;
  @override
  final String rid;
  @override
  final String uuid;
  @override
  final int size;
  @override
  final String name;
  @override
  final String alt;
  @override
  final String mimetype;
  @override
  final String hash;
  @override
  final int destination;
  @override
  final int refCount;
  @override
  final dynamic fileChunks;
  @override
  final dynamic cleanedAt;
  @override
  final bool isMature;
  @override
  final bool isAnalyzed;
  @override
  final bool isUploaded;
  @override
  final bool isSelfRef;
  @override
  final dynamic ref;
  @override
  final dynamic refId;
  @override
  final SnAttachmentPool? pool;
  @override
  final int poolId;
  @override
  final int accountId;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'SnAttachment(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, rid: $rid, uuid: $uuid, size: $size, name: $name, alt: $alt, mimetype: $mimetype, hash: $hash, destination: $destination, refCount: $refCount, fileChunks: $fileChunks, cleanedAt: $cleanedAt, isMature: $isMature, isAnalyzed: $isAnalyzed, isUploaded: $isUploaded, isSelfRef: $isSelfRef, ref: $ref, refId: $refId, pool: $pool, poolId: $poolId, accountId: $accountId, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnAttachmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other.deletedAt, deletedAt) &&
            (identical(other.rid, rid) || other.rid == rid) &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.alt, alt) || other.alt == alt) &&
            (identical(other.mimetype, mimetype) ||
                other.mimetype == mimetype) &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.refCount, refCount) ||
                other.refCount == refCount) &&
            const DeepCollectionEquality()
                .equals(other.fileChunks, fileChunks) &&
            const DeepCollectionEquality().equals(other.cleanedAt, cleanedAt) &&
            (identical(other.isMature, isMature) ||
                other.isMature == isMature) &&
            (identical(other.isAnalyzed, isAnalyzed) ||
                other.isAnalyzed == isAnalyzed) &&
            (identical(other.isUploaded, isUploaded) ||
                other.isUploaded == isUploaded) &&
            (identical(other.isSelfRef, isSelfRef) ||
                other.isSelfRef == isSelfRef) &&
            const DeepCollectionEquality().equals(other.ref, ref) &&
            const DeepCollectionEquality().equals(other.refId, refId) &&
            (identical(other.pool, pool) || other.pool == pool) &&
            (identical(other.poolId, poolId) || other.poolId == poolId) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        createdAt,
        updatedAt,
        const DeepCollectionEquality().hash(deletedAt),
        rid,
        uuid,
        size,
        name,
        alt,
        mimetype,
        hash,
        destination,
        refCount,
        const DeepCollectionEquality().hash(fileChunks),
        const DeepCollectionEquality().hash(cleanedAt),
        isMature,
        isAnalyzed,
        isUploaded,
        isSelfRef,
        const DeepCollectionEquality().hash(ref),
        const DeepCollectionEquality().hash(refId),
        pool,
        poolId,
        accountId,
        const DeepCollectionEquality().hash(_metadata)
      ]);

  /// Create a copy of SnAttachment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnAttachmentImplCopyWith<_$SnAttachmentImpl> get copyWith =>
      __$$SnAttachmentImplCopyWithImpl<_$SnAttachmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnAttachmentImplToJson(
      this,
    );
  }
}

abstract class _SnAttachment implements SnAttachment {
  const factory _SnAttachment(
      {required final int id,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final dynamic deletedAt,
      required final String rid,
      required final String uuid,
      required final int size,
      required final String name,
      required final String alt,
      required final String mimetype,
      required final String hash,
      required final int destination,
      required final int refCount,
      required final dynamic fileChunks,
      required final dynamic cleanedAt,
      required final bool isMature,
      required final bool isAnalyzed,
      required final bool isUploaded,
      required final bool isSelfRef,
      required final dynamic ref,
      required final dynamic refId,
      required final SnAttachmentPool? pool,
      required final int poolId,
      required final int accountId,
      final Map<String, dynamic> metadata}) = _$SnAttachmentImpl;

  factory _SnAttachment.fromJson(Map<String, dynamic> json) =
      _$SnAttachmentImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  dynamic get deletedAt;
  @override
  String get rid;
  @override
  String get uuid;
  @override
  int get size;
  @override
  String get name;
  @override
  String get alt;
  @override
  String get mimetype;
  @override
  String get hash;
  @override
  int get destination;
  @override
  int get refCount;
  @override
  dynamic get fileChunks;
  @override
  dynamic get cleanedAt;
  @override
  bool get isMature;
  @override
  bool get isAnalyzed;
  @override
  bool get isUploaded;
  @override
  bool get isSelfRef;
  @override
  dynamic get ref;
  @override
  dynamic get refId;
  @override
  SnAttachmentPool? get pool;
  @override
  int get poolId;
  @override
  int get accountId;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of SnAttachment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnAttachmentImplCopyWith<_$SnAttachmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SnAttachmentPool _$SnAttachmentPoolFromJson(Map<String, dynamic> json) {
  return _SnAttachmentPool.fromJson(json);
}

/// @nodoc
mixin _$SnAttachmentPool {
  int get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  String get alias => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Map<String, dynamic> get config => throw _privateConstructorUsedError;
  int? get accountId => throw _privateConstructorUsedError;

  /// Serializes this SnAttachmentPool to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnAttachmentPool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnAttachmentPoolCopyWith<SnAttachmentPool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnAttachmentPoolCopyWith<$Res> {
  factory $SnAttachmentPoolCopyWith(
          SnAttachmentPool value, $Res Function(SnAttachmentPool) then) =
      _$SnAttachmentPoolCopyWithImpl<$Res, SnAttachmentPool>;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String alias,
      String name,
      String description,
      Map<String, dynamic> config,
      int? accountId});
}

/// @nodoc
class _$SnAttachmentPoolCopyWithImpl<$Res, $Val extends SnAttachmentPool>
    implements $SnAttachmentPoolCopyWith<$Res> {
  _$SnAttachmentPoolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnAttachmentPool
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
    Object? config = null,
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
      config: null == config
          ? _value.config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SnAttachmentPoolImplCopyWith<$Res>
    implements $SnAttachmentPoolCopyWith<$Res> {
  factory _$$SnAttachmentPoolImplCopyWith(_$SnAttachmentPoolImpl value,
          $Res Function(_$SnAttachmentPoolImpl) then) =
      __$$SnAttachmentPoolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String alias,
      String name,
      String description,
      Map<String, dynamic> config,
      int? accountId});
}

/// @nodoc
class __$$SnAttachmentPoolImplCopyWithImpl<$Res>
    extends _$SnAttachmentPoolCopyWithImpl<$Res, _$SnAttachmentPoolImpl>
    implements _$$SnAttachmentPoolImplCopyWith<$Res> {
  __$$SnAttachmentPoolImplCopyWithImpl(_$SnAttachmentPoolImpl _value,
      $Res Function(_$SnAttachmentPoolImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnAttachmentPool
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
    Object? config = null,
    Object? accountId = freezed,
  }) {
    return _then(_$SnAttachmentPoolImpl(
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
      config: null == config
          ? _value._config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnAttachmentPoolImpl implements _SnAttachmentPool {
  const _$SnAttachmentPoolImpl(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.alias,
      required this.name,
      required this.description,
      required final Map<String, dynamic> config,
      required this.accountId})
      : _config = config;

  factory _$SnAttachmentPoolImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnAttachmentPoolImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final String alias;
  @override
  final String name;
  @override
  final String description;
  final Map<String, dynamic> _config;
  @override
  Map<String, dynamic> get config {
    if (_config is EqualUnmodifiableMapView) return _config;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_config);
  }

  @override
  final int? accountId;

  @override
  String toString() {
    return 'SnAttachmentPool(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, alias: $alias, name: $name, description: $description, config: $config, accountId: $accountId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnAttachmentPoolImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.alias, alias) || other.alias == alias) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._config, _config) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      deletedAt,
      alias,
      name,
      description,
      const DeepCollectionEquality().hash(_config),
      accountId);

  /// Create a copy of SnAttachmentPool
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnAttachmentPoolImplCopyWith<_$SnAttachmentPoolImpl> get copyWith =>
      __$$SnAttachmentPoolImplCopyWithImpl<_$SnAttachmentPoolImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnAttachmentPoolImplToJson(
      this,
    );
  }
}

abstract class _SnAttachmentPool implements SnAttachmentPool {
  const factory _SnAttachmentPool(
      {required final int id,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final DateTime? deletedAt,
      required final String alias,
      required final String name,
      required final String description,
      required final Map<String, dynamic> config,
      required final int? accountId}) = _$SnAttachmentPoolImpl;

  factory _SnAttachmentPool.fromJson(Map<String, dynamic> json) =
      _$SnAttachmentPoolImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get deletedAt;
  @override
  String get alias;
  @override
  String get name;
  @override
  String get description;
  @override
  Map<String, dynamic> get config;
  @override
  int? get accountId;

  /// Create a copy of SnAttachmentPool
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnAttachmentPoolImplCopyWith<_$SnAttachmentPoolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
