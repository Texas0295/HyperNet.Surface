// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SnPost _$SnPostFromJson(Map<String, dynamic> json) {
  return _SnPost.fromJson(json);
}

/// @nodoc
mixin _$SnPost {
  int get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  Map<String, dynamic> get body => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  String? get alias => throw _privateConstructorUsedError;
  String? get aliasPrefix => throw _privateConstructorUsedError;
  List<dynamic> get tags => throw _privateConstructorUsedError;
  List<dynamic> get categories => throw _privateConstructorUsedError;
  dynamic get reactions => throw _privateConstructorUsedError;
  dynamic get replies => throw _privateConstructorUsedError;
  dynamic get replyId => throw _privateConstructorUsedError;
  dynamic get repostId => throw _privateConstructorUsedError;
  dynamic get replyTo => throw _privateConstructorUsedError;
  dynamic get repostTo => throw _privateConstructorUsedError;
  dynamic get visibleUsersList => throw _privateConstructorUsedError;
  dynamic get invisibleUsersList => throw _privateConstructorUsedError;
  int get visibility => throw _privateConstructorUsedError;
  DateTime? get editedAt => throw _privateConstructorUsedError;
  DateTime? get pinnedAt => throw _privateConstructorUsedError;
  DateTime? get lockedAt => throw _privateConstructorUsedError;
  bool get isDraft => throw _privateConstructorUsedError;
  DateTime get publishedAt => throw _privateConstructorUsedError;
  dynamic get publishedUntil => throw _privateConstructorUsedError;
  int get totalUpvote => throw _privateConstructorUsedError;
  int get totalDownvote => throw _privateConstructorUsedError;
  int? get realmId => throw _privateConstructorUsedError;
  dynamic get realm => throw _privateConstructorUsedError;
  int get publisherId => throw _privateConstructorUsedError;
  SnPublisher get publisher => throw _privateConstructorUsedError;
  SnMetric get metric => throw _privateConstructorUsedError;
  SnPostPreload? get preload => throw _privateConstructorUsedError;

  /// Serializes this SnPost to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnPostCopyWith<SnPost> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnPostCopyWith<$Res> {
  factory $SnPostCopyWith(SnPost value, $Res Function(SnPost) then) =
      _$SnPostCopyWithImpl<$Res, SnPost>;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String type,
      Map<String, dynamic> body,
      String language,
      String? alias,
      String? aliasPrefix,
      List<dynamic> tags,
      List<dynamic> categories,
      dynamic reactions,
      dynamic replies,
      dynamic replyId,
      dynamic repostId,
      dynamic replyTo,
      dynamic repostTo,
      dynamic visibleUsersList,
      dynamic invisibleUsersList,
      int visibility,
      DateTime? editedAt,
      DateTime? pinnedAt,
      DateTime? lockedAt,
      bool isDraft,
      DateTime publishedAt,
      dynamic publishedUntil,
      int totalUpvote,
      int totalDownvote,
      int? realmId,
      dynamic realm,
      int publisherId,
      SnPublisher publisher,
      SnMetric metric,
      SnPostPreload? preload});

  $SnPublisherCopyWith<$Res> get publisher;
  $SnMetricCopyWith<$Res> get metric;
  $SnPostPreloadCopyWith<$Res>? get preload;
}

/// @nodoc
class _$SnPostCopyWithImpl<$Res, $Val extends SnPost>
    implements $SnPostCopyWith<$Res> {
  _$SnPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? type = null,
    Object? body = null,
    Object? language = null,
    Object? alias = freezed,
    Object? aliasPrefix = freezed,
    Object? tags = null,
    Object? categories = null,
    Object? reactions = freezed,
    Object? replies = freezed,
    Object? replyId = freezed,
    Object? repostId = freezed,
    Object? replyTo = freezed,
    Object? repostTo = freezed,
    Object? visibleUsersList = freezed,
    Object? invisibleUsersList = freezed,
    Object? visibility = null,
    Object? editedAt = freezed,
    Object? pinnedAt = freezed,
    Object? lockedAt = freezed,
    Object? isDraft = null,
    Object? publishedAt = null,
    Object? publishedUntil = freezed,
    Object? totalUpvote = null,
    Object? totalDownvote = null,
    Object? realmId = freezed,
    Object? realm = freezed,
    Object? publisherId = null,
    Object? publisher = null,
    Object? metric = null,
    Object? preload = freezed,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      alias: freezed == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String?,
      aliasPrefix: freezed == aliasPrefix
          ? _value.aliasPrefix
          : aliasPrefix // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      reactions: freezed == reactions
          ? _value.reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as dynamic,
      replies: freezed == replies
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as dynamic,
      replyId: freezed == replyId
          ? _value.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      repostId: freezed == repostId
          ? _value.repostId
          : repostId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      replyTo: freezed == replyTo
          ? _value.replyTo
          : replyTo // ignore: cast_nullable_to_non_nullable
              as dynamic,
      repostTo: freezed == repostTo
          ? _value.repostTo
          : repostTo // ignore: cast_nullable_to_non_nullable
              as dynamic,
      visibleUsersList: freezed == visibleUsersList
          ? _value.visibleUsersList
          : visibleUsersList // ignore: cast_nullable_to_non_nullable
              as dynamic,
      invisibleUsersList: freezed == invisibleUsersList
          ? _value.invisibleUsersList
          : invisibleUsersList // ignore: cast_nullable_to_non_nullable
              as dynamic,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as int,
      editedAt: freezed == editedAt
          ? _value.editedAt
          : editedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pinnedAt: freezed == pinnedAt
          ? _value.pinnedAt
          : pinnedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lockedAt: freezed == lockedAt
          ? _value.lockedAt
          : lockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDraft: null == isDraft
          ? _value.isDraft
          : isDraft // ignore: cast_nullable_to_non_nullable
              as bool,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      publishedUntil: freezed == publishedUntil
          ? _value.publishedUntil
          : publishedUntil // ignore: cast_nullable_to_non_nullable
              as dynamic,
      totalUpvote: null == totalUpvote
          ? _value.totalUpvote
          : totalUpvote // ignore: cast_nullable_to_non_nullable
              as int,
      totalDownvote: null == totalDownvote
          ? _value.totalDownvote
          : totalDownvote // ignore: cast_nullable_to_non_nullable
              as int,
      realmId: freezed == realmId
          ? _value.realmId
          : realmId // ignore: cast_nullable_to_non_nullable
              as int?,
      realm: freezed == realm
          ? _value.realm
          : realm // ignore: cast_nullable_to_non_nullable
              as dynamic,
      publisherId: null == publisherId
          ? _value.publisherId
          : publisherId // ignore: cast_nullable_to_non_nullable
              as int,
      publisher: null == publisher
          ? _value.publisher
          : publisher // ignore: cast_nullable_to_non_nullable
              as SnPublisher,
      metric: null == metric
          ? _value.metric
          : metric // ignore: cast_nullable_to_non_nullable
              as SnMetric,
      preload: freezed == preload
          ? _value.preload
          : preload // ignore: cast_nullable_to_non_nullable
              as SnPostPreload?,
    ) as $Val);
  }

  /// Create a copy of SnPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnPublisherCopyWith<$Res> get publisher {
    return $SnPublisherCopyWith<$Res>(_value.publisher, (value) {
      return _then(_value.copyWith(publisher: value) as $Val);
    });
  }

  /// Create a copy of SnPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnMetricCopyWith<$Res> get metric {
    return $SnMetricCopyWith<$Res>(_value.metric, (value) {
      return _then(_value.copyWith(metric: value) as $Val);
    });
  }

  /// Create a copy of SnPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnPostPreloadCopyWith<$Res>? get preload {
    if (_value.preload == null) {
      return null;
    }

    return $SnPostPreloadCopyWith<$Res>(_value.preload!, (value) {
      return _then(_value.copyWith(preload: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SnPostImplCopyWith<$Res> implements $SnPostCopyWith<$Res> {
  factory _$$SnPostImplCopyWith(
          _$SnPostImpl value, $Res Function(_$SnPostImpl) then) =
      __$$SnPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String type,
      Map<String, dynamic> body,
      String language,
      String? alias,
      String? aliasPrefix,
      List<dynamic> tags,
      List<dynamic> categories,
      dynamic reactions,
      dynamic replies,
      dynamic replyId,
      dynamic repostId,
      dynamic replyTo,
      dynamic repostTo,
      dynamic visibleUsersList,
      dynamic invisibleUsersList,
      int visibility,
      DateTime? editedAt,
      DateTime? pinnedAt,
      DateTime? lockedAt,
      bool isDraft,
      DateTime publishedAt,
      dynamic publishedUntil,
      int totalUpvote,
      int totalDownvote,
      int? realmId,
      dynamic realm,
      int publisherId,
      SnPublisher publisher,
      SnMetric metric,
      SnPostPreload? preload});

  @override
  $SnPublisherCopyWith<$Res> get publisher;
  @override
  $SnMetricCopyWith<$Res> get metric;
  @override
  $SnPostPreloadCopyWith<$Res>? get preload;
}

/// @nodoc
class __$$SnPostImplCopyWithImpl<$Res>
    extends _$SnPostCopyWithImpl<$Res, _$SnPostImpl>
    implements _$$SnPostImplCopyWith<$Res> {
  __$$SnPostImplCopyWithImpl(
      _$SnPostImpl _value, $Res Function(_$SnPostImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? type = null,
    Object? body = null,
    Object? language = null,
    Object? alias = freezed,
    Object? aliasPrefix = freezed,
    Object? tags = null,
    Object? categories = null,
    Object? reactions = freezed,
    Object? replies = freezed,
    Object? replyId = freezed,
    Object? repostId = freezed,
    Object? replyTo = freezed,
    Object? repostTo = freezed,
    Object? visibleUsersList = freezed,
    Object? invisibleUsersList = freezed,
    Object? visibility = null,
    Object? editedAt = freezed,
    Object? pinnedAt = freezed,
    Object? lockedAt = freezed,
    Object? isDraft = null,
    Object? publishedAt = null,
    Object? publishedUntil = freezed,
    Object? totalUpvote = null,
    Object? totalDownvote = null,
    Object? realmId = freezed,
    Object? realm = freezed,
    Object? publisherId = null,
    Object? publisher = null,
    Object? metric = null,
    Object? preload = freezed,
  }) {
    return _then(_$SnPostImpl(
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value._body
          : body // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      alias: freezed == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String?,
      aliasPrefix: freezed == aliasPrefix
          ? _value.aliasPrefix
          : aliasPrefix // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      reactions: freezed == reactions
          ? _value.reactions
          : reactions // ignore: cast_nullable_to_non_nullable
              as dynamic,
      replies: freezed == replies
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as dynamic,
      replyId: freezed == replyId
          ? _value.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      repostId: freezed == repostId
          ? _value.repostId
          : repostId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      replyTo: freezed == replyTo
          ? _value.replyTo
          : replyTo // ignore: cast_nullable_to_non_nullable
              as dynamic,
      repostTo: freezed == repostTo
          ? _value.repostTo
          : repostTo // ignore: cast_nullable_to_non_nullable
              as dynamic,
      visibleUsersList: freezed == visibleUsersList
          ? _value.visibleUsersList
          : visibleUsersList // ignore: cast_nullable_to_non_nullable
              as dynamic,
      invisibleUsersList: freezed == invisibleUsersList
          ? _value.invisibleUsersList
          : invisibleUsersList // ignore: cast_nullable_to_non_nullable
              as dynamic,
      visibility: null == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as int,
      editedAt: freezed == editedAt
          ? _value.editedAt
          : editedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pinnedAt: freezed == pinnedAt
          ? _value.pinnedAt
          : pinnedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lockedAt: freezed == lockedAt
          ? _value.lockedAt
          : lockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDraft: null == isDraft
          ? _value.isDraft
          : isDraft // ignore: cast_nullable_to_non_nullable
              as bool,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      publishedUntil: freezed == publishedUntil
          ? _value.publishedUntil
          : publishedUntil // ignore: cast_nullable_to_non_nullable
              as dynamic,
      totalUpvote: null == totalUpvote
          ? _value.totalUpvote
          : totalUpvote // ignore: cast_nullable_to_non_nullable
              as int,
      totalDownvote: null == totalDownvote
          ? _value.totalDownvote
          : totalDownvote // ignore: cast_nullable_to_non_nullable
              as int,
      realmId: freezed == realmId
          ? _value.realmId
          : realmId // ignore: cast_nullable_to_non_nullable
              as int?,
      realm: freezed == realm
          ? _value.realm
          : realm // ignore: cast_nullable_to_non_nullable
              as dynamic,
      publisherId: null == publisherId
          ? _value.publisherId
          : publisherId // ignore: cast_nullable_to_non_nullable
              as int,
      publisher: null == publisher
          ? _value.publisher
          : publisher // ignore: cast_nullable_to_non_nullable
              as SnPublisher,
      metric: null == metric
          ? _value.metric
          : metric // ignore: cast_nullable_to_non_nullable
              as SnMetric,
      preload: freezed == preload
          ? _value.preload
          : preload // ignore: cast_nullable_to_non_nullable
              as SnPostPreload?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnPostImpl implements _SnPost {
  const _$SnPostImpl(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.type,
      required final Map<String, dynamic> body,
      required this.language,
      required this.alias,
      required this.aliasPrefix,
      required final List<dynamic> tags,
      required final List<dynamic> categories,
      required this.reactions,
      required this.replies,
      required this.replyId,
      required this.repostId,
      required this.replyTo,
      required this.repostTo,
      required this.visibleUsersList,
      required this.invisibleUsersList,
      required this.visibility,
      required this.editedAt,
      required this.pinnedAt,
      required this.lockedAt,
      required this.isDraft,
      required this.publishedAt,
      required this.publishedUntil,
      required this.totalUpvote,
      required this.totalDownvote,
      required this.realmId,
      required this.realm,
      required this.publisherId,
      required this.publisher,
      required this.metric,
      this.preload})
      : _body = body,
        _tags = tags,
        _categories = categories;

  factory _$SnPostImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnPostImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final String type;
  final Map<String, dynamic> _body;
  @override
  Map<String, dynamic> get body {
    if (_body is EqualUnmodifiableMapView) return _body;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_body);
  }

  @override
  final String language;
  @override
  final String? alias;
  @override
  final String? aliasPrefix;
  final List<dynamic> _tags;
  @override
  List<dynamic> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<dynamic> _categories;
  @override
  List<dynamic> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final dynamic reactions;
  @override
  final dynamic replies;
  @override
  final dynamic replyId;
  @override
  final dynamic repostId;
  @override
  final dynamic replyTo;
  @override
  final dynamic repostTo;
  @override
  final dynamic visibleUsersList;
  @override
  final dynamic invisibleUsersList;
  @override
  final int visibility;
  @override
  final DateTime? editedAt;
  @override
  final DateTime? pinnedAt;
  @override
  final DateTime? lockedAt;
  @override
  final bool isDraft;
  @override
  final DateTime publishedAt;
  @override
  final dynamic publishedUntil;
  @override
  final int totalUpvote;
  @override
  final int totalDownvote;
  @override
  final int? realmId;
  @override
  final dynamic realm;
  @override
  final int publisherId;
  @override
  final SnPublisher publisher;
  @override
  final SnMetric metric;
  @override
  final SnPostPreload? preload;

  @override
  String toString() {
    return 'SnPost(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, type: $type, body: $body, language: $language, alias: $alias, aliasPrefix: $aliasPrefix, tags: $tags, categories: $categories, reactions: $reactions, replies: $replies, replyId: $replyId, repostId: $repostId, replyTo: $replyTo, repostTo: $repostTo, visibleUsersList: $visibleUsersList, invisibleUsersList: $invisibleUsersList, visibility: $visibility, editedAt: $editedAt, pinnedAt: $pinnedAt, lockedAt: $lockedAt, isDraft: $isDraft, publishedAt: $publishedAt, publishedUntil: $publishedUntil, totalUpvote: $totalUpvote, totalDownvote: $totalDownvote, realmId: $realmId, realm: $realm, publisherId: $publisherId, publisher: $publisher, metric: $metric, preload: $preload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnPostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._body, _body) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.alias, alias) || other.alias == alias) &&
            (identical(other.aliasPrefix, aliasPrefix) ||
                other.aliasPrefix == aliasPrefix) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other.reactions, reactions) &&
            const DeepCollectionEquality().equals(other.replies, replies) &&
            const DeepCollectionEquality().equals(other.replyId, replyId) &&
            const DeepCollectionEquality().equals(other.repostId, repostId) &&
            const DeepCollectionEquality().equals(other.replyTo, replyTo) &&
            const DeepCollectionEquality().equals(other.repostTo, repostTo) &&
            const DeepCollectionEquality()
                .equals(other.visibleUsersList, visibleUsersList) &&
            const DeepCollectionEquality()
                .equals(other.invisibleUsersList, invisibleUsersList) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.editedAt, editedAt) ||
                other.editedAt == editedAt) &&
            (identical(other.pinnedAt, pinnedAt) ||
                other.pinnedAt == pinnedAt) &&
            (identical(other.lockedAt, lockedAt) ||
                other.lockedAt == lockedAt) &&
            (identical(other.isDraft, isDraft) || other.isDraft == isDraft) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            const DeepCollectionEquality()
                .equals(other.publishedUntil, publishedUntil) &&
            (identical(other.totalUpvote, totalUpvote) ||
                other.totalUpvote == totalUpvote) &&
            (identical(other.totalDownvote, totalDownvote) ||
                other.totalDownvote == totalDownvote) &&
            (identical(other.realmId, realmId) || other.realmId == realmId) &&
            const DeepCollectionEquality().equals(other.realm, realm) &&
            (identical(other.publisherId, publisherId) ||
                other.publisherId == publisherId) &&
            (identical(other.publisher, publisher) ||
                other.publisher == publisher) &&
            (identical(other.metric, metric) || other.metric == metric) &&
            (identical(other.preload, preload) || other.preload == preload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        createdAt,
        updatedAt,
        deletedAt,
        type,
        const DeepCollectionEquality().hash(_body),
        language,
        alias,
        aliasPrefix,
        const DeepCollectionEquality().hash(_tags),
        const DeepCollectionEquality().hash(_categories),
        const DeepCollectionEquality().hash(reactions),
        const DeepCollectionEquality().hash(replies),
        const DeepCollectionEquality().hash(replyId),
        const DeepCollectionEquality().hash(repostId),
        const DeepCollectionEquality().hash(replyTo),
        const DeepCollectionEquality().hash(repostTo),
        const DeepCollectionEquality().hash(visibleUsersList),
        const DeepCollectionEquality().hash(invisibleUsersList),
        visibility,
        editedAt,
        pinnedAt,
        lockedAt,
        isDraft,
        publishedAt,
        const DeepCollectionEquality().hash(publishedUntil),
        totalUpvote,
        totalDownvote,
        realmId,
        const DeepCollectionEquality().hash(realm),
        publisherId,
        publisher,
        metric,
        preload
      ]);

  /// Create a copy of SnPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnPostImplCopyWith<_$SnPostImpl> get copyWith =>
      __$$SnPostImplCopyWithImpl<_$SnPostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnPostImplToJson(
      this,
    );
  }
}

abstract class _SnPost implements SnPost {
  const factory _SnPost(
      {required final int id,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final DateTime? deletedAt,
      required final String type,
      required final Map<String, dynamic> body,
      required final String language,
      required final String? alias,
      required final String? aliasPrefix,
      required final List<dynamic> tags,
      required final List<dynamic> categories,
      required final dynamic reactions,
      required final dynamic replies,
      required final dynamic replyId,
      required final dynamic repostId,
      required final dynamic replyTo,
      required final dynamic repostTo,
      required final dynamic visibleUsersList,
      required final dynamic invisibleUsersList,
      required final int visibility,
      required final DateTime? editedAt,
      required final DateTime? pinnedAt,
      required final DateTime? lockedAt,
      required final bool isDraft,
      required final DateTime publishedAt,
      required final dynamic publishedUntil,
      required final int totalUpvote,
      required final int totalDownvote,
      required final int? realmId,
      required final dynamic realm,
      required final int publisherId,
      required final SnPublisher publisher,
      required final SnMetric metric,
      final SnPostPreload? preload}) = _$SnPostImpl;

  factory _SnPost.fromJson(Map<String, dynamic> json) = _$SnPostImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get deletedAt;
  @override
  String get type;
  @override
  Map<String, dynamic> get body;
  @override
  String get language;
  @override
  String? get alias;
  @override
  String? get aliasPrefix;
  @override
  List<dynamic> get tags;
  @override
  List<dynamic> get categories;
  @override
  dynamic get reactions;
  @override
  dynamic get replies;
  @override
  dynamic get replyId;
  @override
  dynamic get repostId;
  @override
  dynamic get replyTo;
  @override
  dynamic get repostTo;
  @override
  dynamic get visibleUsersList;
  @override
  dynamic get invisibleUsersList;
  @override
  int get visibility;
  @override
  DateTime? get editedAt;
  @override
  DateTime? get pinnedAt;
  @override
  DateTime? get lockedAt;
  @override
  bool get isDraft;
  @override
  DateTime get publishedAt;
  @override
  dynamic get publishedUntil;
  @override
  int get totalUpvote;
  @override
  int get totalDownvote;
  @override
  int? get realmId;
  @override
  dynamic get realm;
  @override
  int get publisherId;
  @override
  SnPublisher get publisher;
  @override
  SnMetric get metric;
  @override
  SnPostPreload? get preload;

  /// Create a copy of SnPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnPostImplCopyWith<_$SnPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SnPostPreload _$SnPostPreloadFromJson(Map<String, dynamic> json) {
  return _SnPostPreload.fromJson(json);
}

/// @nodoc
mixin _$SnPostPreload {
  List<SnAttachment>? get attachments => throw _privateConstructorUsedError;

  /// Serializes this SnPostPreload to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnPostPreload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnPostPreloadCopyWith<SnPostPreload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnPostPreloadCopyWith<$Res> {
  factory $SnPostPreloadCopyWith(
          SnPostPreload value, $Res Function(SnPostPreload) then) =
      _$SnPostPreloadCopyWithImpl<$Res, SnPostPreload>;
  @useResult
  $Res call({List<SnAttachment>? attachments});
}

/// @nodoc
class _$SnPostPreloadCopyWithImpl<$Res, $Val extends SnPostPreload>
    implements $SnPostPreloadCopyWith<$Res> {
  _$SnPostPreloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnPostPreload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attachments = freezed,
  }) {
    return _then(_value.copyWith(
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<SnAttachment>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SnPostPreloadImplCopyWith<$Res>
    implements $SnPostPreloadCopyWith<$Res> {
  factory _$$SnPostPreloadImplCopyWith(
          _$SnPostPreloadImpl value, $Res Function(_$SnPostPreloadImpl) then) =
      __$$SnPostPreloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SnAttachment>? attachments});
}

/// @nodoc
class __$$SnPostPreloadImplCopyWithImpl<$Res>
    extends _$SnPostPreloadCopyWithImpl<$Res, _$SnPostPreloadImpl>
    implements _$$SnPostPreloadImplCopyWith<$Res> {
  __$$SnPostPreloadImplCopyWithImpl(
      _$SnPostPreloadImpl _value, $Res Function(_$SnPostPreloadImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnPostPreload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attachments = freezed,
  }) {
    return _then(_$SnPostPreloadImpl(
      attachments: freezed == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<SnAttachment>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnPostPreloadImpl implements _SnPostPreload {
  const _$SnPostPreloadImpl({required final List<SnAttachment>? attachments})
      : _attachments = attachments;

  factory _$SnPostPreloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnPostPreloadImplFromJson(json);

  final List<SnAttachment>? _attachments;
  @override
  List<SnAttachment>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SnPostPreload(attachments: $attachments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnPostPreloadImpl &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_attachments));

  /// Create a copy of SnPostPreload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnPostPreloadImplCopyWith<_$SnPostPreloadImpl> get copyWith =>
      __$$SnPostPreloadImplCopyWithImpl<_$SnPostPreloadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnPostPreloadImplToJson(
      this,
    );
  }
}

abstract class _SnPostPreload implements SnPostPreload {
  const factory _SnPostPreload(
      {required final List<SnAttachment>? attachments}) = _$SnPostPreloadImpl;

  factory _SnPostPreload.fromJson(Map<String, dynamic> json) =
      _$SnPostPreloadImpl.fromJson;

  @override
  List<SnAttachment>? get attachments;

  /// Create a copy of SnPostPreload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnPostPreloadImplCopyWith<_$SnPostPreloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SnBody _$SnBodyFromJson(Map<String, dynamic> json) {
  return _SnBody.fromJson(json);
}

/// @nodoc
mixin _$SnBody {
  List<String> get attachments => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  dynamic get location => throw _privateConstructorUsedError;
  dynamic get thumbnail => throw _privateConstructorUsedError;
  dynamic get title => throw _privateConstructorUsedError;

  /// Serializes this SnBody to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnBodyCopyWith<SnBody> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnBodyCopyWith<$Res> {
  factory $SnBodyCopyWith(SnBody value, $Res Function(SnBody) then) =
      _$SnBodyCopyWithImpl<$Res, SnBody>;
  @useResult
  $Res call(
      {List<String> attachments,
      String content,
      dynamic location,
      dynamic thumbnail,
      dynamic title});
}

/// @nodoc
class _$SnBodyCopyWithImpl<$Res, $Val extends SnBody>
    implements $SnBodyCopyWith<$Res> {
  _$SnBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attachments = null,
    Object? content = null,
    Object? location = freezed,
    Object? thumbnail = freezed,
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      attachments: null == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as dynamic,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as dynamic,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SnBodyImplCopyWith<$Res> implements $SnBodyCopyWith<$Res> {
  factory _$$SnBodyImplCopyWith(
          _$SnBodyImpl value, $Res Function(_$SnBodyImpl) then) =
      __$$SnBodyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> attachments,
      String content,
      dynamic location,
      dynamic thumbnail,
      dynamic title});
}

/// @nodoc
class __$$SnBodyImplCopyWithImpl<$Res>
    extends _$SnBodyCopyWithImpl<$Res, _$SnBodyImpl>
    implements _$$SnBodyImplCopyWith<$Res> {
  __$$SnBodyImplCopyWithImpl(
      _$SnBodyImpl _value, $Res Function(_$SnBodyImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attachments = null,
    Object? content = null,
    Object? location = freezed,
    Object? thumbnail = freezed,
    Object? title = freezed,
  }) {
    return _then(_$SnBodyImpl(
      attachments: null == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as dynamic,
      thumbnail: freezed == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as dynamic,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnBodyImpl implements _SnBody {
  const _$SnBodyImpl(
      {required final List<String> attachments,
      required this.content,
      required this.location,
      required this.thumbnail,
      required this.title})
      : _attachments = attachments;

  factory _$SnBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnBodyImplFromJson(json);

  final List<String> _attachments;
  @override
  List<String> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  final String content;
  @override
  final dynamic location;
  @override
  final dynamic thumbnail;
  @override
  final dynamic title;

  @override
  String toString() {
    return 'SnBody(attachments: $attachments, content: $content, location: $location, thumbnail: $thumbnail, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnBodyImpl &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other.location, location) &&
            const DeepCollectionEquality().equals(other.thumbnail, thumbnail) &&
            const DeepCollectionEquality().equals(other.title, title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_attachments),
      content,
      const DeepCollectionEquality().hash(location),
      const DeepCollectionEquality().hash(thumbnail),
      const DeepCollectionEquality().hash(title));

  /// Create a copy of SnBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnBodyImplCopyWith<_$SnBodyImpl> get copyWith =>
      __$$SnBodyImplCopyWithImpl<_$SnBodyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnBodyImplToJson(
      this,
    );
  }
}

abstract class _SnBody implements SnBody {
  const factory _SnBody(
      {required final List<String> attachments,
      required final String content,
      required final dynamic location,
      required final dynamic thumbnail,
      required final dynamic title}) = _$SnBodyImpl;

  factory _SnBody.fromJson(Map<String, dynamic> json) = _$SnBodyImpl.fromJson;

  @override
  List<String> get attachments;
  @override
  String get content;
  @override
  dynamic get location;
  @override
  dynamic get thumbnail;
  @override
  dynamic get title;

  /// Create a copy of SnBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnBodyImplCopyWith<_$SnBodyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SnMetric _$SnMetricFromJson(Map<String, dynamic> json) {
  return _SnMetric.fromJson(json);
}

/// @nodoc
mixin _$SnMetric {
  int get replyCount => throw _privateConstructorUsedError;
  int get reactionCount => throw _privateConstructorUsedError;

  /// Serializes this SnMetric to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnMetric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnMetricCopyWith<SnMetric> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnMetricCopyWith<$Res> {
  factory $SnMetricCopyWith(SnMetric value, $Res Function(SnMetric) then) =
      _$SnMetricCopyWithImpl<$Res, SnMetric>;
  @useResult
  $Res call({int replyCount, int reactionCount});
}

/// @nodoc
class _$SnMetricCopyWithImpl<$Res, $Val extends SnMetric>
    implements $SnMetricCopyWith<$Res> {
  _$SnMetricCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnMetric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? replyCount = null,
    Object? reactionCount = null,
  }) {
    return _then(_value.copyWith(
      replyCount: null == replyCount
          ? _value.replyCount
          : replyCount // ignore: cast_nullable_to_non_nullable
              as int,
      reactionCount: null == reactionCount
          ? _value.reactionCount
          : reactionCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SnMetricImplCopyWith<$Res>
    implements $SnMetricCopyWith<$Res> {
  factory _$$SnMetricImplCopyWith(
          _$SnMetricImpl value, $Res Function(_$SnMetricImpl) then) =
      __$$SnMetricImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int replyCount, int reactionCount});
}

/// @nodoc
class __$$SnMetricImplCopyWithImpl<$Res>
    extends _$SnMetricCopyWithImpl<$Res, _$SnMetricImpl>
    implements _$$SnMetricImplCopyWith<$Res> {
  __$$SnMetricImplCopyWithImpl(
      _$SnMetricImpl _value, $Res Function(_$SnMetricImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnMetric
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? replyCount = null,
    Object? reactionCount = null,
  }) {
    return _then(_$SnMetricImpl(
      replyCount: null == replyCount
          ? _value.replyCount
          : replyCount // ignore: cast_nullable_to_non_nullable
              as int,
      reactionCount: null == reactionCount
          ? _value.reactionCount
          : reactionCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnMetricImpl implements _SnMetric {
  const _$SnMetricImpl({required this.replyCount, required this.reactionCount});

  factory _$SnMetricImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnMetricImplFromJson(json);

  @override
  final int replyCount;
  @override
  final int reactionCount;

  @override
  String toString() {
    return 'SnMetric(replyCount: $replyCount, reactionCount: $reactionCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnMetricImpl &&
            (identical(other.replyCount, replyCount) ||
                other.replyCount == replyCount) &&
            (identical(other.reactionCount, reactionCount) ||
                other.reactionCount == reactionCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, replyCount, reactionCount);

  /// Create a copy of SnMetric
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnMetricImplCopyWith<_$SnMetricImpl> get copyWith =>
      __$$SnMetricImplCopyWithImpl<_$SnMetricImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnMetricImplToJson(
      this,
    );
  }
}

abstract class _SnMetric implements SnMetric {
  const factory _SnMetric(
      {required final int replyCount,
      required final int reactionCount}) = _$SnMetricImpl;

  factory _SnMetric.fromJson(Map<String, dynamic> json) =
      _$SnMetricImpl.fromJson;

  @override
  int get replyCount;
  @override
  int get reactionCount;

  /// Create a copy of SnMetric
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnMetricImplCopyWith<_$SnMetricImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SnPublisher _$SnPublisherFromJson(Map<String, dynamic> json) {
  return _SnPublisher.fromJson(json);
}

/// @nodoc
mixin _$SnPublisher {
  int get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get nick => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  String get banner => throw _privateConstructorUsedError;
  int get totalUpvote => throw _privateConstructorUsedError;
  int get totalDownvote => throw _privateConstructorUsedError;
  int? get realmId => throw _privateConstructorUsedError;
  int get accountId => throw _privateConstructorUsedError;

  /// Serializes this SnPublisher to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnPublisher
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnPublisherCopyWith<SnPublisher> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnPublisherCopyWith<$Res> {
  factory $SnPublisherCopyWith(
          SnPublisher value, $Res Function(SnPublisher) then) =
      _$SnPublisherCopyWithImpl<$Res, SnPublisher>;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      int type,
      String name,
      String nick,
      String description,
      String avatar,
      String banner,
      int totalUpvote,
      int totalDownvote,
      int? realmId,
      int accountId});
}

/// @nodoc
class _$SnPublisherCopyWithImpl<$Res, $Val extends SnPublisher>
    implements $SnPublisherCopyWith<$Res> {
  _$SnPublisherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnPublisher
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? type = null,
    Object? name = null,
    Object? nick = null,
    Object? description = null,
    Object? avatar = null,
    Object? banner = null,
    Object? totalUpvote = null,
    Object? totalDownvote = null,
    Object? realmId = freezed,
    Object? accountId = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nick: null == nick
          ? _value.nick
          : nick // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      banner: null == banner
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String,
      totalUpvote: null == totalUpvote
          ? _value.totalUpvote
          : totalUpvote // ignore: cast_nullable_to_non_nullable
              as int,
      totalDownvote: null == totalDownvote
          ? _value.totalDownvote
          : totalDownvote // ignore: cast_nullable_to_non_nullable
              as int,
      realmId: freezed == realmId
          ? _value.realmId
          : realmId // ignore: cast_nullable_to_non_nullable
              as int?,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SnPublisherImplCopyWith<$Res>
    implements $SnPublisherCopyWith<$Res> {
  factory _$$SnPublisherImplCopyWith(
          _$SnPublisherImpl value, $Res Function(_$SnPublisherImpl) then) =
      __$$SnPublisherImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      int type,
      String name,
      String nick,
      String description,
      String avatar,
      String banner,
      int totalUpvote,
      int totalDownvote,
      int? realmId,
      int accountId});
}

/// @nodoc
class __$$SnPublisherImplCopyWithImpl<$Res>
    extends _$SnPublisherCopyWithImpl<$Res, _$SnPublisherImpl>
    implements _$$SnPublisherImplCopyWith<$Res> {
  __$$SnPublisherImplCopyWithImpl(
      _$SnPublisherImpl _value, $Res Function(_$SnPublisherImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnPublisher
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? type = null,
    Object? name = null,
    Object? nick = null,
    Object? description = null,
    Object? avatar = null,
    Object? banner = null,
    Object? totalUpvote = null,
    Object? totalDownvote = null,
    Object? realmId = freezed,
    Object? accountId = null,
  }) {
    return _then(_$SnPublisherImpl(
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nick: null == nick
          ? _value.nick
          : nick // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      banner: null == banner
          ? _value.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String,
      totalUpvote: null == totalUpvote
          ? _value.totalUpvote
          : totalUpvote // ignore: cast_nullable_to_non_nullable
              as int,
      totalDownvote: null == totalDownvote
          ? _value.totalDownvote
          : totalDownvote // ignore: cast_nullable_to_non_nullable
              as int,
      realmId: freezed == realmId
          ? _value.realmId
          : realmId // ignore: cast_nullable_to_non_nullable
              as int?,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnPublisherImpl implements _SnPublisher {
  const _$SnPublisherImpl(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.type,
      required this.name,
      required this.nick,
      required this.description,
      required this.avatar,
      required this.banner,
      required this.totalUpvote,
      required this.totalDownvote,
      required this.realmId,
      required this.accountId});

  factory _$SnPublisherImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnPublisherImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final int type;
  @override
  final String name;
  @override
  final String nick;
  @override
  final String description;
  @override
  final String avatar;
  @override
  final String banner;
  @override
  final int totalUpvote;
  @override
  final int totalDownvote;
  @override
  final int? realmId;
  @override
  final int accountId;

  @override
  String toString() {
    return 'SnPublisher(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, type: $type, name: $name, nick: $nick, description: $description, avatar: $avatar, banner: $banner, totalUpvote: $totalUpvote, totalDownvote: $totalDownvote, realmId: $realmId, accountId: $accountId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnPublisherImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nick, nick) || other.nick == nick) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.banner, banner) || other.banner == banner) &&
            (identical(other.totalUpvote, totalUpvote) ||
                other.totalUpvote == totalUpvote) &&
            (identical(other.totalDownvote, totalDownvote) ||
                other.totalDownvote == totalDownvote) &&
            (identical(other.realmId, realmId) || other.realmId == realmId) &&
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
      type,
      name,
      nick,
      description,
      avatar,
      banner,
      totalUpvote,
      totalDownvote,
      realmId,
      accountId);

  /// Create a copy of SnPublisher
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnPublisherImplCopyWith<_$SnPublisherImpl> get copyWith =>
      __$$SnPublisherImplCopyWithImpl<_$SnPublisherImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnPublisherImplToJson(
      this,
    );
  }
}

abstract class _SnPublisher implements SnPublisher {
  const factory _SnPublisher(
      {required final int id,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final DateTime? deletedAt,
      required final int type,
      required final String name,
      required final String nick,
      required final String description,
      required final String avatar,
      required final String banner,
      required final int totalUpvote,
      required final int totalDownvote,
      required final int? realmId,
      required final int accountId}) = _$SnPublisherImpl;

  factory _SnPublisher.fromJson(Map<String, dynamic> json) =
      _$SnPublisherImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get deletedAt;
  @override
  int get type;
  @override
  String get name;
  @override
  String get nick;
  @override
  String get description;
  @override
  String get avatar;
  @override
  String get banner;
  @override
  int get totalUpvote;
  @override
  int get totalDownvote;
  @override
  int? get realmId;
  @override
  int get accountId;

  /// Create a copy of SnPublisher
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnPublisherImplCopyWith<_$SnPublisherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
