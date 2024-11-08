import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class SnPost with _$SnPost {
  const factory SnPost({
    required int id,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime? deletedAt,
    required String type,
    required dynamic body,
    required String language,
    required String? alias,
    required String aliasPrefix,
    required List<dynamic> tags,
    required List<dynamic> categories,
    required dynamic reactions,
    required dynamic replies,
    required dynamic replyId,
    required dynamic repostId,
    required dynamic replyTo,
    required dynamic repostTo,
    required dynamic visibleUsersList,
    required dynamic invisibleUsersList,
    required int visibility,
    required DateTime? editedAt,
    required DateTime? pinnedAt,
    required DateTime? lockedAt,
    required bool isDraft,
    required DateTime publishedAt,
    required dynamic publishedUntil,
    required int totalUpvote,
    required int totalDownvote,
    required int? realmId,
    required dynamic realm,
    required int publisherId,
    required SnPublisher publisher,
    required SnMetric metric,
  }) = _SnPost;

  factory SnPost.fromJson(Map<String, Object?> json) => _$SnPostFromJson(json);
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
