// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SnNewsSource _$SnNewsSourceFromJson(Map<String, dynamic> json) {
  return _SnNewsSource.fromJson(json);
}

/// @nodoc
mixin _$SnNewsSource {
  String get id => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  int get depth => throw _privateConstructorUsedError;
  bool get enabled => throw _privateConstructorUsedError;

  /// Serializes this SnNewsSource to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnNewsSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnNewsSourceCopyWith<SnNewsSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnNewsSourceCopyWith<$Res> {
  factory $SnNewsSourceCopyWith(
          SnNewsSource value, $Res Function(SnNewsSource) then) =
      _$SnNewsSourceCopyWithImpl<$Res, SnNewsSource>;
  @useResult
  $Res call(
      {String id,
      String label,
      String type,
      String source,
      int depth,
      bool enabled});
}

/// @nodoc
class _$SnNewsSourceCopyWithImpl<$Res, $Val extends SnNewsSource>
    implements $SnNewsSourceCopyWith<$Res> {
  _$SnNewsSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnNewsSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? type = null,
    Object? source = null,
    Object? depth = null,
    Object? enabled = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      depth: null == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SnNewsSourceImplCopyWith<$Res>
    implements $SnNewsSourceCopyWith<$Res> {
  factory _$$SnNewsSourceImplCopyWith(
          _$SnNewsSourceImpl value, $Res Function(_$SnNewsSourceImpl) then) =
      __$$SnNewsSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String label,
      String type,
      String source,
      int depth,
      bool enabled});
}

/// @nodoc
class __$$SnNewsSourceImplCopyWithImpl<$Res>
    extends _$SnNewsSourceCopyWithImpl<$Res, _$SnNewsSourceImpl>
    implements _$$SnNewsSourceImplCopyWith<$Res> {
  __$$SnNewsSourceImplCopyWithImpl(
      _$SnNewsSourceImpl _value, $Res Function(_$SnNewsSourceImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnNewsSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? type = null,
    Object? source = null,
    Object? depth = null,
    Object? enabled = null,
  }) {
    return _then(_$SnNewsSourceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      depth: null == depth
          ? _value.depth
          : depth // ignore: cast_nullable_to_non_nullable
              as int,
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnNewsSourceImpl implements _SnNewsSource {
  const _$SnNewsSourceImpl(
      {required this.id,
      required this.label,
      required this.type,
      required this.source,
      required this.depth,
      required this.enabled});

  factory _$SnNewsSourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnNewsSourceImplFromJson(json);

  @override
  final String id;
  @override
  final String label;
  @override
  final String type;
  @override
  final String source;
  @override
  final int depth;
  @override
  final bool enabled;

  @override
  String toString() {
    return 'SnNewsSource(id: $id, label: $label, type: $type, source: $source, depth: $depth, enabled: $enabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnNewsSourceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.depth, depth) || other.depth == depth) &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, label, type, source, depth, enabled);

  /// Create a copy of SnNewsSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnNewsSourceImplCopyWith<_$SnNewsSourceImpl> get copyWith =>
      __$$SnNewsSourceImplCopyWithImpl<_$SnNewsSourceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnNewsSourceImplToJson(
      this,
    );
  }
}

abstract class _SnNewsSource implements SnNewsSource {
  const factory _SnNewsSource(
      {required final String id,
      required final String label,
      required final String type,
      required final String source,
      required final int depth,
      required final bool enabled}) = _$SnNewsSourceImpl;

  factory _SnNewsSource.fromJson(Map<String, dynamic> json) =
      _$SnNewsSourceImpl.fromJson;

  @override
  String get id;
  @override
  String get label;
  @override
  String get type;
  @override
  String get source;
  @override
  int get depth;
  @override
  bool get enabled;

  /// Create a copy of SnNewsSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnNewsSourceImplCopyWith<_$SnNewsSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SnNewsArticle _$SnNewsArticleFromJson(Map<String, dynamic> json) {
  return _SnNewsArticle.fromJson(json);
}

/// @nodoc
mixin _$SnNewsArticle {
  int get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  dynamic get deletedAt => throw _privateConstructorUsedError;
  String get thumbnail => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get hash => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  dynamic get publishedAt => throw _privateConstructorUsedError;

  /// Serializes this SnNewsArticle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnNewsArticle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnNewsArticleCopyWith<SnNewsArticle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnNewsArticleCopyWith<$Res> {
  factory $SnNewsArticleCopyWith(
          SnNewsArticle value, $Res Function(SnNewsArticle) then) =
      _$SnNewsArticleCopyWithImpl<$Res, SnNewsArticle>;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      dynamic deletedAt,
      String thumbnail,
      String title,
      String description,
      String content,
      String url,
      String hash,
      String source,
      dynamic publishedAt});
}

/// @nodoc
class _$SnNewsArticleCopyWithImpl<$Res, $Val extends SnNewsArticle>
    implements $SnNewsArticleCopyWith<$Res> {
  _$SnNewsArticleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnNewsArticle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? thumbnail = null,
    Object? title = null,
    Object? description = null,
    Object? content = null,
    Object? url = null,
    Object? hash = null,
    Object? source = null,
    Object? publishedAt = freezed,
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
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      publishedAt: freezed == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SnNewsArticleImplCopyWith<$Res>
    implements $SnNewsArticleCopyWith<$Res> {
  factory _$$SnNewsArticleImplCopyWith(
          _$SnNewsArticleImpl value, $Res Function(_$SnNewsArticleImpl) then) =
      __$$SnNewsArticleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      dynamic deletedAt,
      String thumbnail,
      String title,
      String description,
      String content,
      String url,
      String hash,
      String source,
      dynamic publishedAt});
}

/// @nodoc
class __$$SnNewsArticleImplCopyWithImpl<$Res>
    extends _$SnNewsArticleCopyWithImpl<$Res, _$SnNewsArticleImpl>
    implements _$$SnNewsArticleImplCopyWith<$Res> {
  __$$SnNewsArticleImplCopyWithImpl(
      _$SnNewsArticleImpl _value, $Res Function(_$SnNewsArticleImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnNewsArticle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? thumbnail = null,
    Object? title = null,
    Object? description = null,
    Object? content = null,
    Object? url = null,
    Object? hash = null,
    Object? source = null,
    Object? publishedAt = freezed,
  }) {
    return _then(_$SnNewsArticleImpl(
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
      thumbnail: null == thumbnail
          ? _value.thumbnail
          : thumbnail // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      publishedAt: freezed == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnNewsArticleImpl implements _SnNewsArticle {
  const _$SnNewsArticleImpl(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.thumbnail,
      required this.title,
      required this.description,
      required this.content,
      required this.url,
      required this.hash,
      required this.source,
      required this.publishedAt});

  factory _$SnNewsArticleImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnNewsArticleImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final dynamic deletedAt;
  @override
  final String thumbnail;
  @override
  final String title;
  @override
  final String description;
  @override
  final String content;
  @override
  final String url;
  @override
  final String hash;
  @override
  final String source;
  @override
  final dynamic publishedAt;

  @override
  String toString() {
    return 'SnNewsArticle(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, thumbnail: $thumbnail, title: $title, description: $description, content: $content, url: $url, hash: $hash, source: $source, publishedAt: $publishedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnNewsArticleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other.deletedAt, deletedAt) &&
            (identical(other.thumbnail, thumbnail) ||
                other.thumbnail == thumbnail) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.source, source) || other.source == source) &&
            const DeepCollectionEquality()
                .equals(other.publishedAt, publishedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(deletedAt),
      thumbnail,
      title,
      description,
      content,
      url,
      hash,
      source,
      const DeepCollectionEquality().hash(publishedAt));

  /// Create a copy of SnNewsArticle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnNewsArticleImplCopyWith<_$SnNewsArticleImpl> get copyWith =>
      __$$SnNewsArticleImplCopyWithImpl<_$SnNewsArticleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnNewsArticleImplToJson(
      this,
    );
  }
}

abstract class _SnNewsArticle implements SnNewsArticle {
  const factory _SnNewsArticle(
      {required final int id,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final dynamic deletedAt,
      required final String thumbnail,
      required final String title,
      required final String description,
      required final String content,
      required final String url,
      required final String hash,
      required final String source,
      required final dynamic publishedAt}) = _$SnNewsArticleImpl;

  factory _SnNewsArticle.fromJson(Map<String, dynamic> json) =
      _$SnNewsArticleImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  dynamic get deletedAt;
  @override
  String get thumbnail;
  @override
  String get title;
  @override
  String get description;
  @override
  String get content;
  @override
  String get url;
  @override
  String get hash;
  @override
  String get source;
  @override
  dynamic get publishedAt;

  /// Create a copy of SnNewsArticle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnNewsArticleImplCopyWith<_$SnNewsArticleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
