import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachment.freezed.dart';
part 'attachment.g.dart';

@freezed
class SnAttachment with _$SnAttachment {
  const factory SnAttachment({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required dynamic deletedAt,
    required String rid,
    required String uuid,
    required int size,
    required String name,
    required String alt,
    required String mimetype,
    required String hash,
    required int destination,
    required int refCount,
    required dynamic fileChunks,
    required dynamic cleanedAt,
    required bool isMature,
    required bool isAnalyzed,
    required bool isUploaded,
    required bool isSelfRef,
    required dynamic ref,
    required dynamic refId,
    required SnAttachmentPool? pool,
    required int poolId,
    required int accountId,
    @Default({}) Map<String, dynamic> metadata,
  }) = _SnAttachment;

  factory SnAttachment.fromJson(Map<String, Object?> json) =>
      _$SnAttachmentFromJson(json);
}

@freezed
class SnAttachmentPool with _$SnAttachmentPool {
  const factory SnAttachmentPool({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? deletedAt,
    required String alias,
    required String name,
    required String description,
    required Map<String, dynamic> config,
    required int? accountId,
  }) = _SnAttachmentPool;

  factory SnAttachmentPool.fromJson(Map<String, Object?> json) =>
      _$SnAttachmentPoolFromJson(json);
}
