// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SnAttachmentImpl _$$SnAttachmentImplFromJson(Map<String, dynamic> json) =>
    _$SnAttachmentImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'],
      rid: json['rid'] as String,
      uuid: json['uuid'] as String,
      size: (json['size'] as num).toInt(),
      name: json['name'] as String,
      alt: json['alt'] as String,
      mimetype: json['mimetype'] as String,
      hash: json['hash'] as String,
      destination: (json['destination'] as num).toInt(),
      refCount: (json['ref_count'] as num).toInt(),
      contentRating: (json['content_rating'] as num?)?.toInt() ?? 0,
      qualityRating: (json['quality_rating'] as num?)?.toInt() ?? 0,
      fileChunks: json['file_chunks'],
      cleanedAt: json['cleaned_at'],
      isAnalyzed: json['is_analyzed'] as bool,
      isUploaded: json['is_uploaded'] as bool,
      isSelfRef: json['is_self_ref'] as bool,
      ref: json['ref'],
      refId: json['ref_id'],
      pool: json['pool'] == null
          ? null
          : SnAttachmentPool.fromJson(json['pool'] as Map<String, dynamic>),
      poolId: (json['pool_id'] as num).toInt(),
      accountId: (json['account_id'] as num).toInt(),
      usermeta: json['usermeta'] as Map<String, dynamic>? ?? const {},
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$SnAttachmentImplToJson(_$SnAttachmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt,
      'rid': instance.rid,
      'uuid': instance.uuid,
      'size': instance.size,
      'name': instance.name,
      'alt': instance.alt,
      'mimetype': instance.mimetype,
      'hash': instance.hash,
      'destination': instance.destination,
      'ref_count': instance.refCount,
      'content_rating': instance.contentRating,
      'quality_rating': instance.qualityRating,
      'file_chunks': instance.fileChunks,
      'cleaned_at': instance.cleanedAt,
      'is_analyzed': instance.isAnalyzed,
      'is_uploaded': instance.isUploaded,
      'is_self_ref': instance.isSelfRef,
      'ref': instance.ref,
      'ref_id': instance.refId,
      'pool': instance.pool?.toJson(),
      'pool_id': instance.poolId,
      'account_id': instance.accountId,
      'usermeta': instance.usermeta,
      'metadata': instance.metadata,
    };

_$SnAttachmentPoolImpl _$$SnAttachmentPoolImplFromJson(
        Map<String, dynamic> json) =>
    _$SnAttachmentPoolImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      alias: json['alias'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      config: json['config'] as Map<String, dynamic>,
      accountId: (json['account_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SnAttachmentPoolImplToJson(
        _$SnAttachmentPoolImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'alias': instance.alias,
      'name': instance.name,
      'description': instance.description,
      'config': instance.config,
      'account_id': instance.accountId,
    };
