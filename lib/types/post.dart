import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:surface/types/attachment.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class SnPost with _$SnPost {
  const SnPost._();

  const factory SnPost({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? deletedAt,
    required String type,
    required Map<String, dynamic> body,
    required String language,
    required String? alias,
    required String? aliasPrefix,
    @Default([]) List<dynamic> tags,
    @Default([]) List<dynamic> categories,
    required List<SnPost>? replies,
    required int? replyId,
    required int? repostId,
    required SnPost? replyTo,
    required SnPost? repostTo,
    required List<int>? visibleUsersList,
    required List<int>? invisibleUsersList,
    required int visibility,
    required DateTime? editedAt,
    required DateTime? pinnedAt,
    required DateTime? lockedAt,
    required bool isDraft,
    required DateTime? publishedAt,
    required DateTime? publishedUntil,
    required int totalUpvote,
    required int totalDownvote,
    required int publisherId,
    required SnPublisher publisher,
    required SnMetric metric,
    SnPostPreload? preload,
  }) = _SnPost;

  factory SnPost.fromJson(Map<String, Object?> json) => _$SnPostFromJson(json);

  String get typePlural => switch (type) {
        'story' => 'stories',
        _ => '${type}s',
      };
}

@freezed
class SnPostPreload with _$SnPostPreload {
  const factory SnPostPreload({
    required SnAttachment? thumbnail,
    required List<SnAttachment?>? attachments,
  }) = _SnPostPreload;

  factory SnPostPreload.fromJson(Map<String, Object?> json) =>
      _$SnPostPreloadFromJson(json);
}

@freezed
class SnBody with _$SnBody {
  const factory SnBody({
    required List<String> attachments,
    required String content,
    required dynamic location,
    required dynamic thumbnail,
    required dynamic title,
  }) = _SnBody;

  factory SnBody.fromJson(Map<String, Object?> json) => _$SnBodyFromJson(json);
}

@freezed
class SnMetric with _$SnMetric {
  const factory SnMetric({
    required int replyCount,
    required int reactionCount,
    @Default({}) Map<String, int> reactionList,
  }) = _SnMetric;

  factory SnMetric.fromJson(Map<String, Object?> json) =>
      _$SnMetricFromJson(json);
}

@freezed
class SnPublisher with _$SnPublisher {
  const factory SnPublisher({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? deletedAt,
    required int type,
    required String name,
    required String nick,
    required String description,
    required String avatar,
    required String banner,
    required int totalUpvote,
    required int totalDownvote,
    required int? realmId,
    required int accountId,
  }) = _SnPublisher;

  factory SnPublisher.fromJson(Map<String, Object?> json) =>
      _$SnPublisherFromJson(json);
}
