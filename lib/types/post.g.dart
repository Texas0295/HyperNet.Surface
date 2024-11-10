// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SnPostImpl _$$SnPostImplFromJson(Map<String, dynamic> json) => _$SnPostImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      type: json['type'] as String,
      body: json['body'] as Map<String, dynamic>,
      language: json['language'] as String,
      alias: json['alias'] as String?,
      aliasPrefix: json['alias_prefix'] as String?,
      tags: json['tags'] as List<dynamic>,
      categories: json['categories'] as List<dynamic>,
      reactions: json['reactions'],
      replies: json['replies'],
      replyId: json['reply_id'],
      repostId: json['repost_id'],
      replyTo: json['reply_to'],
      repostTo: json['repost_to'],
      visibleUsersList: json['visible_users_list'],
      invisibleUsersList: json['invisible_users_list'],
      visibility: (json['visibility'] as num).toInt(),
      editedAt: json['edited_at'] == null
          ? null
          : DateTime.parse(json['edited_at'] as String),
      pinnedAt: json['pinned_at'] == null
          ? null
          : DateTime.parse(json['pinned_at'] as String),
      lockedAt: json['locked_at'] == null
          ? null
          : DateTime.parse(json['locked_at'] as String),
      isDraft: json['is_draft'] as bool,
      publishedAt: json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at'] as String),
      publishedUntil: json['published_until'],
      totalUpvote: (json['total_upvote'] as num).toInt(),
      totalDownvote: (json['total_downvote'] as num).toInt(),
      realmId: (json['realm_id'] as num?)?.toInt(),
      realm: json['realm'],
      publisherId: (json['publisher_id'] as num).toInt(),
      publisher:
          SnPublisher.fromJson(json['publisher'] as Map<String, dynamic>),
      metric: SnMetric.fromJson(json['metric'] as Map<String, dynamic>),
      preload: json['preload'] == null
          ? null
          : SnPostPreload.fromJson(json['preload'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SnPostImplToJson(_$SnPostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'type': instance.type,
      'body': instance.body,
      'language': instance.language,
      'alias': instance.alias,
      'alias_prefix': instance.aliasPrefix,
      'tags': instance.tags,
      'categories': instance.categories,
      'reactions': instance.reactions,
      'replies': instance.replies,
      'reply_id': instance.replyId,
      'repost_id': instance.repostId,
      'reply_to': instance.replyTo,
      'repost_to': instance.repostTo,
      'visible_users_list': instance.visibleUsersList,
      'invisible_users_list': instance.invisibleUsersList,
      'visibility': instance.visibility,
      'edited_at': instance.editedAt?.toIso8601String(),
      'pinned_at': instance.pinnedAt?.toIso8601String(),
      'locked_at': instance.lockedAt?.toIso8601String(),
      'is_draft': instance.isDraft,
      'published_at': instance.publishedAt?.toIso8601String(),
      'published_until': instance.publishedUntil,
      'total_upvote': instance.totalUpvote,
      'total_downvote': instance.totalDownvote,
      'realm_id': instance.realmId,
      'realm': instance.realm,
      'publisher_id': instance.publisherId,
      'publisher': instance.publisher.toJson(),
      'metric': instance.metric.toJson(),
      'preload': instance.preload?.toJson(),
    };

_$SnPostPreloadImpl _$$SnPostPreloadImplFromJson(Map<String, dynamic> json) =>
    _$SnPostPreloadImpl(
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => SnAttachment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SnPostPreloadImplToJson(_$SnPostPreloadImpl instance) =>
    <String, dynamic>{
      'attachments': instance.attachments?.map((e) => e.toJson()).toList(),
    };

_$SnBodyImpl _$$SnBodyImplFromJson(Map<String, dynamic> json) => _$SnBodyImpl(
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      content: json['content'] as String,
      location: json['location'],
      thumbnail: json['thumbnail'],
      title: json['title'],
    );

Map<String, dynamic> _$$SnBodyImplToJson(_$SnBodyImpl instance) =>
    <String, dynamic>{
      'attachments': instance.attachments,
      'content': instance.content,
      'location': instance.location,
      'thumbnail': instance.thumbnail,
      'title': instance.title,
    };

_$SnMetricImpl _$$SnMetricImplFromJson(Map<String, dynamic> json) =>
    _$SnMetricImpl(
      replyCount: (json['reply_count'] as num).toInt(),
      reactionCount: (json['reaction_count'] as num).toInt(),
    );

Map<String, dynamic> _$$SnMetricImplToJson(_$SnMetricImpl instance) =>
    <String, dynamic>{
      'reply_count': instance.replyCount,
      'reaction_count': instance.reactionCount,
    };

_$SnPublisherImpl _$$SnPublisherImplFromJson(Map<String, dynamic> json) =>
    _$SnPublisherImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      type: (json['type'] as num).toInt(),
      name: json['name'] as String,
      nick: json['nick'] as String,
      description: json['description'] as String,
      avatar: json['avatar'] as String,
      banner: json['banner'] as String,
      totalUpvote: (json['total_upvote'] as num).toInt(),
      totalDownvote: (json['total_downvote'] as num).toInt(),
      realmId: (json['realm_id'] as num?)?.toInt(),
      accountId: (json['account_id'] as num).toInt(),
    );

Map<String, dynamic> _$$SnPublisherImplToJson(_$SnPublisherImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'type': instance.type,
      'name': instance.name,
      'nick': instance.nick,
      'description': instance.description,
      'avatar': instance.avatar,
      'banner': instance.banner,
      'total_upvote': instance.totalUpvote,
      'total_downvote': instance.totalDownvote,
      'realm_id': instance.realmId,
      'account_id': instance.accountId,
    };
