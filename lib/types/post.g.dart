// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SnPostImpl _$$SnPostImplFromJson(Map<String, dynamic> json) => _$SnPostImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      type: json['type'] as String,
      body: json['body'],
      language: json['language'] as String,
      alias: json['alias'] as String?,
      aliasPrefix: json['aliasPrefix'] as String,
      tags: json['tags'] as List<dynamic>,
      categories: json['categories'] as List<dynamic>,
      reactions: json['reactions'],
      replies: json['replies'],
      replyId: json['replyId'],
      repostId: json['repostId'],
      replyTo: json['replyTo'],
      repostTo: json['repostTo'],
      visibleUsersList: json['visibleUsersList'],
      invisibleUsersList: json['invisibleUsersList'],
      visibility: (json['visibility'] as num).toInt(),
      editedAt: json['editedAt'] == null
          ? null
          : DateTime.parse(json['editedAt'] as String),
      pinnedAt: json['pinnedAt'] == null
          ? null
          : DateTime.parse(json['pinnedAt'] as String),
      lockedAt: json['lockedAt'] == null
          ? null
          : DateTime.parse(json['lockedAt'] as String),
      isDraft: json['isDraft'] as bool,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      publishedUntil: json['publishedUntil'],
      totalUpvote: (json['totalUpvote'] as num).toInt(),
      totalDownvote: (json['totalDownvote'] as num).toInt(),
      realmId: (json['realmId'] as num?)?.toInt(),
      realm: json['realm'],
      publisherId: (json['publisherId'] as num).toInt(),
      publisher:
          SnPublisher.fromJson(json['publisher'] as Map<String, dynamic>),
      metric: SnMetric.fromJson(json['metric'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SnPostImplToJson(_$SnPostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'type': instance.type,
      'body': instance.body,
      'language': instance.language,
      'alias': instance.alias,
      'aliasPrefix': instance.aliasPrefix,
      'tags': instance.tags,
      'categories': instance.categories,
      'reactions': instance.reactions,
      'replies': instance.replies,
      'replyId': instance.replyId,
      'repostId': instance.repostId,
      'replyTo': instance.replyTo,
      'repostTo': instance.repostTo,
      'visibleUsersList': instance.visibleUsersList,
      'invisibleUsersList': instance.invisibleUsersList,
      'visibility': instance.visibility,
      'editedAt': instance.editedAt?.toIso8601String(),
      'pinnedAt': instance.pinnedAt?.toIso8601String(),
      'lockedAt': instance.lockedAt?.toIso8601String(),
      'isDraft': instance.isDraft,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'publishedUntil': instance.publishedUntil,
      'totalUpvote': instance.totalUpvote,
      'totalDownvote': instance.totalDownvote,
      'realmId': instance.realmId,
      'realm': instance.realm,
      'publisherId': instance.publisherId,
      'publisher': instance.publisher,
      'metric': instance.metric,
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
      replyCount: (json['replyCount'] as num).toInt(),
      reactionCount: (json['reactionCount'] as num).toInt(),
    );

Map<String, dynamic> _$$SnMetricImplToJson(_$SnMetricImpl instance) =>
    <String, dynamic>{
      'replyCount': instance.replyCount,
      'reactionCount': instance.reactionCount,
    };

_$SnPublisherImpl _$$SnPublisherImplFromJson(Map<String, dynamic> json) =>
    _$SnPublisherImpl(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      type: (json['type'] as num).toInt(),
      name: json['name'] as String,
      nick: json['nick'] as String,
      description: json['description'] as String,
      avatar: json['avatar'] as String,
      banner: json['banner'] as String,
      totalUpvote: (json['totalUpvote'] as num).toInt(),
      totalDownvote: (json['totalDownvote'] as num).toInt(),
      realmId: (json['realmId'] as num?)?.toInt(),
      accountId: (json['accountId'] as num).toInt(),
    );

Map<String, dynamic> _$$SnPublisherImplToJson(_$SnPublisherImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'type': instance.type,
      'name': instance.name,
      'nick': instance.nick,
      'description': instance.description,
      'avatar': instance.avatar,
      'banner': instance.banner,
      'totalUpvote': instance.totalUpvote,
      'totalDownvote': instance.totalDownvote,
      'realmId': instance.realmId,
      'accountId': instance.accountId,
    };
