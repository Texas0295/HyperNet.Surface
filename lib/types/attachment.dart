import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachment.freezed.dart';

part 'attachment.g.dart';

enum SnMediaType {
  image,
  video,
  audio,
  file,
}

@freezed
class SnAttachment with _$SnAttachment {
  const SnAttachment._();

  const factory SnAttachment({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? deletedAt,
    required String rid,
    required String uuid,
    required int size,
    required String name,
    required String alt,
    required String mimetype,
    required String hash,
    required int destination,
    required int refCount,
    @Default(0) int contentRating,
    @Default(0) int qualityRating,
    required DateTime? cleanedAt,
    required bool isAnalyzed,
    required bool isSelfRef,
    required bool isIndexable,
    required SnAttachment? ref,
    required int? refId,
    required SnAttachmentPool? pool,
    required int poolId,
    required int accountId,
    int? thumbnailId,
    SnAttachment? thumbnail,
    int? compressedId,
    SnAttachment? compressed,
    @Default({}) Map<String, dynamic> usermeta,
    @Default({}) Map<String, dynamic> metadata,
  }) = _SnAttachment;

  factory SnAttachment.fromJson(Map<String, Object?> json) => _$SnAttachmentFromJson(json);

  Map<String, dynamic> get data => {
        ...metadata,
        ...usermeta,
      };

  SnMediaType get mediaType => switch (mimetype.split('/').firstOrNull) {
        'image' => SnMediaType.image,
        'video' => SnMediaType.video,
        'audio' => SnMediaType.audio,
        _ => SnMediaType.file,
      };
}

@freezed
class SnAttachmentFragment with _$SnAttachmentFragment {
  const SnAttachmentFragment._();

  const factory SnAttachmentFragment({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? deletedAt,
    required String rid,
    required String uuid,
    required int size,
    required String name,
    required String alt,
    required String mimetype,
    required String hash,
    String? fingerprint,
    @Default({}) Map<String, int> fileChunks,
    @Default([]) List<String> fileChunksMissing,
  }) = _SnAttachmentFragment;

  factory SnAttachmentFragment.fromJson(Map<String, Object?> json) => _$SnAttachmentFragmentFromJson(json);

  SnMediaType get mediaType => switch (mimetype.split('/').firstOrNull) {
        'image' => SnMediaType.image,
        'video' => SnMediaType.video,
        'audio' => SnMediaType.audio,
        _ => SnMediaType.file,
      };
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

  factory SnAttachmentPool.fromJson(Map<String, Object?> json) => _$SnAttachmentPoolFromJson(json);
}
