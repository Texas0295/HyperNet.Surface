// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SnAccount {
  int get id;
  DateTime get createdAt;
  DateTime get updatedAt;
  DateTime? get deletedAt;
  DateTime? get confirmedAt;
  List<SnAccountContact>? get contacts;
  String get avatar;
  String get banner;
  String get name;
  String get nick;
  Map<String, dynamic> get permNodes;
  String get language;
  SnAccountProfile? get profile;
  List<SnAccountBadge> get badges;
  List<SnPunishment> get punishments;
  DateTime? get suspendedAt;
  int? get affiliatedId;
  int? get affiliatedTo;
  int? get automatedBy;
  int? get automatedId;

  /// Create a copy of SnAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SnAccountCopyWith<SnAccount> get copyWith =>
      _$SnAccountCopyWithImpl<SnAccount>(this as SnAccount, _$identity);

  /// Serializes this SnAccount to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SnAccount &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.confirmedAt, confirmedAt) ||
                other.confirmedAt == confirmedAt) &&
            const DeepCollectionEquality().equals(other.contacts, contacts) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.banner, banner) || other.banner == banner) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nick, nick) || other.nick == nick) &&
            const DeepCollectionEquality().equals(other.permNodes, permNodes) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            const DeepCollectionEquality().equals(other.badges, badges) &&
            const DeepCollectionEquality()
                .equals(other.punishments, punishments) &&
            (identical(other.suspendedAt, suspendedAt) ||
                other.suspendedAt == suspendedAt) &&
            (identical(other.affiliatedId, affiliatedId) ||
                other.affiliatedId == affiliatedId) &&
            (identical(other.affiliatedTo, affiliatedTo) ||
                other.affiliatedTo == affiliatedTo) &&
            (identical(other.automatedBy, automatedBy) ||
                other.automatedBy == automatedBy) &&
            (identical(other.automatedId, automatedId) ||
                other.automatedId == automatedId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        createdAt,
        updatedAt,
        deletedAt,
        confirmedAt,
        const DeepCollectionEquality().hash(contacts),
        avatar,
        banner,
        name,
        nick,
        const DeepCollectionEquality().hash(permNodes),
        language,
        profile,
        const DeepCollectionEquality().hash(badges),
        const DeepCollectionEquality().hash(punishments),
        suspendedAt,
        affiliatedId,
        affiliatedTo,
        automatedBy,
        automatedId
      ]);

  @override
  String toString() {
    return 'SnAccount(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, confirmedAt: $confirmedAt, contacts: $contacts, avatar: $avatar, banner: $banner, name: $name, nick: $nick, permNodes: $permNodes, language: $language, profile: $profile, badges: $badges, punishments: $punishments, suspendedAt: $suspendedAt, affiliatedId: $affiliatedId, affiliatedTo: $affiliatedTo, automatedBy: $automatedBy, automatedId: $automatedId)';
  }
}

/// @nodoc
abstract mixin class $SnAccountCopyWith<$Res> {
  factory $SnAccountCopyWith(SnAccount value, $Res Function(SnAccount) _then) =
      _$SnAccountCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      DateTime? confirmedAt,
      List<SnAccountContact>? contacts,
      String avatar,
      String banner,
      String name,
      String nick,
      Map<String, dynamic> permNodes,
      String language,
      SnAccountProfile? profile,
      List<SnAccountBadge> badges,
      List<SnPunishment> punishments,
      DateTime? suspendedAt,
      int? affiliatedId,
      int? affiliatedTo,
      int? automatedBy,
      int? automatedId});

  $SnAccountProfileCopyWith<$Res>? get profile;
}

/// @nodoc
class _$SnAccountCopyWithImpl<$Res> implements $SnAccountCopyWith<$Res> {
  _$SnAccountCopyWithImpl(this._self, this._then);

  final SnAccount _self;
  final $Res Function(SnAccount) _then;

  /// Create a copy of SnAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? confirmedAt = freezed,
    Object? contacts = freezed,
    Object? avatar = null,
    Object? banner = null,
    Object? name = null,
    Object? nick = null,
    Object? permNodes = null,
    Object? language = null,
    Object? profile = freezed,
    Object? badges = null,
    Object? punishments = null,
    Object? suspendedAt = freezed,
    Object? affiliatedId = freezed,
    Object? affiliatedTo = freezed,
    Object? automatedBy = freezed,
    Object? automatedId = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      confirmedAt: freezed == confirmedAt
          ? _self.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      contacts: freezed == contacts
          ? _self.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<SnAccountContact>?,
      avatar: null == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      banner: null == banner
          ? _self.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nick: null == nick
          ? _self.nick
          : nick // ignore: cast_nullable_to_non_nullable
              as String,
      permNodes: null == permNodes
          ? _self.permNodes
          : permNodes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      profile: freezed == profile
          ? _self.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as SnAccountProfile?,
      badges: null == badges
          ? _self.badges
          : badges // ignore: cast_nullable_to_non_nullable
              as List<SnAccountBadge>,
      punishments: null == punishments
          ? _self.punishments
          : punishments // ignore: cast_nullable_to_non_nullable
              as List<SnPunishment>,
      suspendedAt: freezed == suspendedAt
          ? _self.suspendedAt
          : suspendedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      affiliatedId: freezed == affiliatedId
          ? _self.affiliatedId
          : affiliatedId // ignore: cast_nullable_to_non_nullable
              as int?,
      affiliatedTo: freezed == affiliatedTo
          ? _self.affiliatedTo
          : affiliatedTo // ignore: cast_nullable_to_non_nullable
              as int?,
      automatedBy: freezed == automatedBy
          ? _self.automatedBy
          : automatedBy // ignore: cast_nullable_to_non_nullable
              as int?,
      automatedId: freezed == automatedId
          ? _self.automatedId
          : automatedId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of SnAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnAccountProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
      return null;
    }

    return $SnAccountProfileCopyWith<$Res>(_self.profile!, (value) {
      return _then(_self.copyWith(profile: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _SnAccount extends SnAccount {
  const _SnAccount(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.confirmedAt,
      required final List<SnAccountContact>? contacts,
      this.avatar = "",
      this.banner = "",
      required this.name,
      required this.nick,
      final Map<String, dynamic> permNodes = const {},
      required this.language,
      required this.profile,
      final List<SnAccountBadge> badges = const [],
      final List<SnPunishment> punishments = const [],
      required this.suspendedAt,
      required this.affiliatedId,
      required this.affiliatedTo,
      required this.automatedBy,
      required this.automatedId})
      : _contacts = contacts,
        _permNodes = permNodes,
        _badges = badges,
        _punishments = punishments,
        super._();
  factory _SnAccount.fromJson(Map<String, dynamic> json) =>
      _$SnAccountFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final DateTime? confirmedAt;
  final List<SnAccountContact>? _contacts;
  @override
  List<SnAccountContact>? get contacts {
    final value = _contacts;
    if (value == null) return null;
    if (_contacts is EqualUnmodifiableListView) return _contacts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final String avatar;
  @override
  @JsonKey()
  final String banner;
  @override
  final String name;
  @override
  final String nick;
  final Map<String, dynamic> _permNodes;
  @override
  @JsonKey()
  Map<String, dynamic> get permNodes {
    if (_permNodes is EqualUnmodifiableMapView) return _permNodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_permNodes);
  }

  @override
  final String language;
  @override
  final SnAccountProfile? profile;
  final List<SnAccountBadge> _badges;
  @override
  @JsonKey()
  List<SnAccountBadge> get badges {
    if (_badges is EqualUnmodifiableListView) return _badges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_badges);
  }

  final List<SnPunishment> _punishments;
  @override
  @JsonKey()
  List<SnPunishment> get punishments {
    if (_punishments is EqualUnmodifiableListView) return _punishments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_punishments);
  }

  @override
  final DateTime? suspendedAt;
  @override
  final int? affiliatedId;
  @override
  final int? affiliatedTo;
  @override
  final int? automatedBy;
  @override
  final int? automatedId;

  /// Create a copy of SnAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SnAccountCopyWith<_SnAccount> get copyWith =>
      __$SnAccountCopyWithImpl<_SnAccount>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SnAccountToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SnAccount &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.confirmedAt, confirmedAt) ||
                other.confirmedAt == confirmedAt) &&
            const DeepCollectionEquality().equals(other._contacts, _contacts) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.banner, banner) || other.banner == banner) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nick, nick) || other.nick == nick) &&
            const DeepCollectionEquality()
                .equals(other._permNodes, _permNodes) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            const DeepCollectionEquality().equals(other._badges, _badges) &&
            const DeepCollectionEquality()
                .equals(other._punishments, _punishments) &&
            (identical(other.suspendedAt, suspendedAt) ||
                other.suspendedAt == suspendedAt) &&
            (identical(other.affiliatedId, affiliatedId) ||
                other.affiliatedId == affiliatedId) &&
            (identical(other.affiliatedTo, affiliatedTo) ||
                other.affiliatedTo == affiliatedTo) &&
            (identical(other.automatedBy, automatedBy) ||
                other.automatedBy == automatedBy) &&
            (identical(other.automatedId, automatedId) ||
                other.automatedId == automatedId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        createdAt,
        updatedAt,
        deletedAt,
        confirmedAt,
        const DeepCollectionEquality().hash(_contacts),
        avatar,
        banner,
        name,
        nick,
        const DeepCollectionEquality().hash(_permNodes),
        language,
        profile,
        const DeepCollectionEquality().hash(_badges),
        const DeepCollectionEquality().hash(_punishments),
        suspendedAt,
        affiliatedId,
        affiliatedTo,
        automatedBy,
        automatedId
      ]);

  @override
  String toString() {
    return 'SnAccount(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, confirmedAt: $confirmedAt, contacts: $contacts, avatar: $avatar, banner: $banner, name: $name, nick: $nick, permNodes: $permNodes, language: $language, profile: $profile, badges: $badges, punishments: $punishments, suspendedAt: $suspendedAt, affiliatedId: $affiliatedId, affiliatedTo: $affiliatedTo, automatedBy: $automatedBy, automatedId: $automatedId)';
  }
}

/// @nodoc
abstract mixin class _$SnAccountCopyWith<$Res>
    implements $SnAccountCopyWith<$Res> {
  factory _$SnAccountCopyWith(
          _SnAccount value, $Res Function(_SnAccount) _then) =
      __$SnAccountCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      DateTime? confirmedAt,
      List<SnAccountContact>? contacts,
      String avatar,
      String banner,
      String name,
      String nick,
      Map<String, dynamic> permNodes,
      String language,
      SnAccountProfile? profile,
      List<SnAccountBadge> badges,
      List<SnPunishment> punishments,
      DateTime? suspendedAt,
      int? affiliatedId,
      int? affiliatedTo,
      int? automatedBy,
      int? automatedId});

  @override
  $SnAccountProfileCopyWith<$Res>? get profile;
}

/// @nodoc
class __$SnAccountCopyWithImpl<$Res> implements _$SnAccountCopyWith<$Res> {
  __$SnAccountCopyWithImpl(this._self, this._then);

  final _SnAccount _self;
  final $Res Function(_SnAccount) _then;

  /// Create a copy of SnAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? confirmedAt = freezed,
    Object? contacts = freezed,
    Object? avatar = null,
    Object? banner = null,
    Object? name = null,
    Object? nick = null,
    Object? permNodes = null,
    Object? language = null,
    Object? profile = freezed,
    Object? badges = null,
    Object? punishments = null,
    Object? suspendedAt = freezed,
    Object? affiliatedId = freezed,
    Object? affiliatedTo = freezed,
    Object? automatedBy = freezed,
    Object? automatedId = freezed,
  }) {
    return _then(_SnAccount(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      confirmedAt: freezed == confirmedAt
          ? _self.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      contacts: freezed == contacts
          ? _self._contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<SnAccountContact>?,
      avatar: null == avatar
          ? _self.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      banner: null == banner
          ? _self.banner
          : banner // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nick: null == nick
          ? _self.nick
          : nick // ignore: cast_nullable_to_non_nullable
              as String,
      permNodes: null == permNodes
          ? _self._permNodes
          : permNodes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      profile: freezed == profile
          ? _self.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as SnAccountProfile?,
      badges: null == badges
          ? _self._badges
          : badges // ignore: cast_nullable_to_non_nullable
              as List<SnAccountBadge>,
      punishments: null == punishments
          ? _self._punishments
          : punishments // ignore: cast_nullable_to_non_nullable
              as List<SnPunishment>,
      suspendedAt: freezed == suspendedAt
          ? _self.suspendedAt
          : suspendedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      affiliatedId: freezed == affiliatedId
          ? _self.affiliatedId
          : affiliatedId // ignore: cast_nullable_to_non_nullable
              as int?,
      affiliatedTo: freezed == affiliatedTo
          ? _self.affiliatedTo
          : affiliatedTo // ignore: cast_nullable_to_non_nullable
              as int?,
      automatedBy: freezed == automatedBy
          ? _self.automatedBy
          : automatedBy // ignore: cast_nullable_to_non_nullable
              as int?,
      automatedId: freezed == automatedId
          ? _self.automatedId
          : automatedId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of SnAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnAccountProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
      return null;
    }

    return $SnAccountProfileCopyWith<$Res>(_self.profile!, (value) {
      return _then(_self.copyWith(profile: value));
    });
  }
}

/// @nodoc
mixin _$SnAccountContact {
  int get accountId;
  String get content;
  DateTime get createdAt;
  DateTime? get deletedAt;
  int get id;
  bool get isPrimary;
  bool get isPublic;
  int get type;
  DateTime get updatedAt;
  DateTime? get verifiedAt;

  /// Create a copy of SnAccountContact
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SnAccountContactCopyWith<SnAccountContact> get copyWith =>
      _$SnAccountContactCopyWithImpl<SnAccountContact>(
          this as SnAccountContact, _$identity);

  /// Serializes this SnAccountContact to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SnAccountContact &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isPrimary, isPrimary) ||
                other.isPrimary == isPrimary) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.verifiedAt, verifiedAt) ||
                other.verifiedAt == verifiedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accountId, content, createdAt,
      deletedAt, id, isPrimary, isPublic, type, updatedAt, verifiedAt);

  @override
  String toString() {
    return 'SnAccountContact(accountId: $accountId, content: $content, createdAt: $createdAt, deletedAt: $deletedAt, id: $id, isPrimary: $isPrimary, isPublic: $isPublic, type: $type, updatedAt: $updatedAt, verifiedAt: $verifiedAt)';
  }
}

/// @nodoc
abstract mixin class $SnAccountContactCopyWith<$Res> {
  factory $SnAccountContactCopyWith(
          SnAccountContact value, $Res Function(SnAccountContact) _then) =
      _$SnAccountContactCopyWithImpl;
  @useResult
  $Res call(
      {int accountId,
      String content,
      DateTime createdAt,
      DateTime? deletedAt,
      int id,
      bool isPrimary,
      bool isPublic,
      int type,
      DateTime updatedAt,
      DateTime? verifiedAt});
}

/// @nodoc
class _$SnAccountContactCopyWithImpl<$Res>
    implements $SnAccountContactCopyWith<$Res> {
  _$SnAccountContactCopyWithImpl(this._self, this._then);

  final SnAccountContact _self;
  final $Res Function(SnAccountContact) _then;

  /// Create a copy of SnAccountContact
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accountId = null,
    Object? content = null,
    Object? createdAt = null,
    Object? deletedAt = freezed,
    Object? id = null,
    Object? isPrimary = null,
    Object? isPublic = null,
    Object? type = null,
    Object? updatedAt = null,
    Object? verifiedAt = freezed,
  }) {
    return _then(_self.copyWith(
      accountId: null == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      isPrimary: null == isPrimary
          ? _self.isPrimary
          : isPrimary // ignore: cast_nullable_to_non_nullable
              as bool,
      isPublic: null == isPublic
          ? _self.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      verifiedAt: freezed == verifiedAt
          ? _self.verifiedAt
          : verifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SnAccountContact implements SnAccountContact {
  const _SnAccountContact(
      {required this.accountId,
      required this.content,
      required this.createdAt,
      required this.deletedAt,
      required this.id,
      required this.isPrimary,
      required this.isPublic,
      required this.type,
      required this.updatedAt,
      required this.verifiedAt});
  factory _SnAccountContact.fromJson(Map<String, dynamic> json) =>
      _$SnAccountContactFromJson(json);

  @override
  final int accountId;
  @override
  final String content;
  @override
  final DateTime createdAt;
  @override
  final DateTime? deletedAt;
  @override
  final int id;
  @override
  final bool isPrimary;
  @override
  final bool isPublic;
  @override
  final int type;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? verifiedAt;

  /// Create a copy of SnAccountContact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SnAccountContactCopyWith<_SnAccountContact> get copyWith =>
      __$SnAccountContactCopyWithImpl<_SnAccountContact>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SnAccountContactToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SnAccountContact &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isPrimary, isPrimary) ||
                other.isPrimary == isPrimary) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.verifiedAt, verifiedAt) ||
                other.verifiedAt == verifiedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accountId, content, createdAt,
      deletedAt, id, isPrimary, isPublic, type, updatedAt, verifiedAt);

  @override
  String toString() {
    return 'SnAccountContact(accountId: $accountId, content: $content, createdAt: $createdAt, deletedAt: $deletedAt, id: $id, isPrimary: $isPrimary, isPublic: $isPublic, type: $type, updatedAt: $updatedAt, verifiedAt: $verifiedAt)';
  }
}

/// @nodoc
abstract mixin class _$SnAccountContactCopyWith<$Res>
    implements $SnAccountContactCopyWith<$Res> {
  factory _$SnAccountContactCopyWith(
          _SnAccountContact value, $Res Function(_SnAccountContact) _then) =
      __$SnAccountContactCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int accountId,
      String content,
      DateTime createdAt,
      DateTime? deletedAt,
      int id,
      bool isPrimary,
      bool isPublic,
      int type,
      DateTime updatedAt,
      DateTime? verifiedAt});
}

/// @nodoc
class __$SnAccountContactCopyWithImpl<$Res>
    implements _$SnAccountContactCopyWith<$Res> {
  __$SnAccountContactCopyWithImpl(this._self, this._then);

  final _SnAccountContact _self;
  final $Res Function(_SnAccountContact) _then;

  /// Create a copy of SnAccountContact
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? accountId = null,
    Object? content = null,
    Object? createdAt = null,
    Object? deletedAt = freezed,
    Object? id = null,
    Object? isPrimary = null,
    Object? isPublic = null,
    Object? type = null,
    Object? updatedAt = null,
    Object? verifiedAt = freezed,
  }) {
    return _then(_SnAccountContact(
      accountId: null == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      isPrimary: null == isPrimary
          ? _self.isPrimary
          : isPrimary // ignore: cast_nullable_to_non_nullable
              as bool,
      isPublic: null == isPublic
          ? _self.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      verifiedAt: freezed == verifiedAt
          ? _self.verifiedAt
          : verifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$SnAccountProfile {
  int get id;
  DateTime get createdAt;
  DateTime get updatedAt;
  DateTime? get deletedAt;
  String get firstName;
  String get lastName;
  String get description;
  String get timeZone;
  String get location;
  String get pronouns;
  String get gender;
  Map<String, String> get links;
  int get experience;
  DateTime? get lastSeenAt;
  DateTime? get birthday;
  int get accountId;

  /// Create a copy of SnAccountProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SnAccountProfileCopyWith<SnAccountProfile> get copyWith =>
      _$SnAccountProfileCopyWithImpl<SnAccountProfile>(
          this as SnAccountProfile, _$identity);

  /// Serializes this SnAccountProfile to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SnAccountProfile &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.timeZone, timeZone) ||
                other.timeZone == timeZone) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.pronouns, pronouns) ||
                other.pronouns == pronouns) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            const DeepCollectionEquality().equals(other.links, links) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                other.lastSeenAt == lastSeenAt) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
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
      firstName,
      lastName,
      description,
      timeZone,
      location,
      pronouns,
      gender,
      const DeepCollectionEquality().hash(links),
      experience,
      lastSeenAt,
      birthday,
      accountId);

  @override
  String toString() {
    return 'SnAccountProfile(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, firstName: $firstName, lastName: $lastName, description: $description, timeZone: $timeZone, location: $location, pronouns: $pronouns, gender: $gender, links: $links, experience: $experience, lastSeenAt: $lastSeenAt, birthday: $birthday, accountId: $accountId)';
  }
}

/// @nodoc
abstract mixin class $SnAccountProfileCopyWith<$Res> {
  factory $SnAccountProfileCopyWith(
          SnAccountProfile value, $Res Function(SnAccountProfile) _then) =
      _$SnAccountProfileCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String firstName,
      String lastName,
      String description,
      String timeZone,
      String location,
      String pronouns,
      String gender,
      Map<String, String> links,
      int experience,
      DateTime? lastSeenAt,
      DateTime? birthday,
      int accountId});
}

/// @nodoc
class _$SnAccountProfileCopyWithImpl<$Res>
    implements $SnAccountProfileCopyWith<$Res> {
  _$SnAccountProfileCopyWithImpl(this._self, this._then);

  final SnAccountProfile _self;
  final $Res Function(SnAccountProfile) _then;

  /// Create a copy of SnAccountProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? firstName = null,
    Object? lastName = null,
    Object? description = null,
    Object? timeZone = null,
    Object? location = null,
    Object? pronouns = null,
    Object? gender = null,
    Object? links = null,
    Object? experience = null,
    Object? lastSeenAt = freezed,
    Object? birthday = freezed,
    Object? accountId = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      firstName: null == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      timeZone: null == timeZone
          ? _self.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      pronouns: null == pronouns
          ? _self.pronouns
          : pronouns // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      links: null == links
          ? _self.links
          : links // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      experience: null == experience
          ? _self.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int,
      lastSeenAt: freezed == lastSeenAt
          ? _self.lastSeenAt
          : lastSeenAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      birthday: freezed == birthday
          ? _self.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      accountId: null == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SnAccountProfile implements SnAccountProfile {
  const _SnAccountProfile(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.firstName,
      required this.lastName,
      required this.description,
      required this.timeZone,
      required this.location,
      required this.pronouns,
      required this.gender,
      final Map<String, String> links = const {},
      required this.experience,
      required this.lastSeenAt,
      required this.birthday,
      required this.accountId})
      : _links = links;
  factory _SnAccountProfile.fromJson(Map<String, dynamic> json) =>
      _$SnAccountProfileFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String description;
  @override
  final String timeZone;
  @override
  final String location;
  @override
  final String pronouns;
  @override
  final String gender;
  final Map<String, String> _links;
  @override
  @JsonKey()
  Map<String, String> get links {
    if (_links is EqualUnmodifiableMapView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_links);
  }

  @override
  final int experience;
  @override
  final DateTime? lastSeenAt;
  @override
  final DateTime? birthday;
  @override
  final int accountId;

  /// Create a copy of SnAccountProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SnAccountProfileCopyWith<_SnAccountProfile> get copyWith =>
      __$SnAccountProfileCopyWithImpl<_SnAccountProfile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SnAccountProfileToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SnAccountProfile &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.timeZone, timeZone) ||
                other.timeZone == timeZone) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.pronouns, pronouns) ||
                other.pronouns == pronouns) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                other.lastSeenAt == lastSeenAt) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
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
      firstName,
      lastName,
      description,
      timeZone,
      location,
      pronouns,
      gender,
      const DeepCollectionEquality().hash(_links),
      experience,
      lastSeenAt,
      birthday,
      accountId);

  @override
  String toString() {
    return 'SnAccountProfile(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, firstName: $firstName, lastName: $lastName, description: $description, timeZone: $timeZone, location: $location, pronouns: $pronouns, gender: $gender, links: $links, experience: $experience, lastSeenAt: $lastSeenAt, birthday: $birthday, accountId: $accountId)';
  }
}

/// @nodoc
abstract mixin class _$SnAccountProfileCopyWith<$Res>
    implements $SnAccountProfileCopyWith<$Res> {
  factory _$SnAccountProfileCopyWith(
          _SnAccountProfile value, $Res Function(_SnAccountProfile) _then) =
      __$SnAccountProfileCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String firstName,
      String lastName,
      String description,
      String timeZone,
      String location,
      String pronouns,
      String gender,
      Map<String, String> links,
      int experience,
      DateTime? lastSeenAt,
      DateTime? birthday,
      int accountId});
}

/// @nodoc
class __$SnAccountProfileCopyWithImpl<$Res>
    implements _$SnAccountProfileCopyWith<$Res> {
  __$SnAccountProfileCopyWithImpl(this._self, this._then);

  final _SnAccountProfile _self;
  final $Res Function(_SnAccountProfile) _then;

  /// Create a copy of SnAccountProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? firstName = null,
    Object? lastName = null,
    Object? description = null,
    Object? timeZone = null,
    Object? location = null,
    Object? pronouns = null,
    Object? gender = null,
    Object? links = null,
    Object? experience = null,
    Object? lastSeenAt = freezed,
    Object? birthday = freezed,
    Object? accountId = null,
  }) {
    return _then(_SnAccountProfile(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      firstName: null == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      timeZone: null == timeZone
          ? _self.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      pronouns: null == pronouns
          ? _self.pronouns
          : pronouns // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      links: null == links
          ? _self._links
          : links // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      experience: null == experience
          ? _self.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as int,
      lastSeenAt: freezed == lastSeenAt
          ? _self.lastSeenAt
          : lastSeenAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      birthday: freezed == birthday
          ? _self.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      accountId: null == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$SnRelationship {
  int get id;
  DateTime get createdAt;
  DateTime get updatedAt;
  DateTime? get deletedAt;
  int get accountId;
  int get relatedId;
  SnAccount? get account;
  SnAccount? get related;
  int get status;
  Map<String, dynamic> get permNodes;

  /// Create a copy of SnRelationship
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SnRelationshipCopyWith<SnRelationship> get copyWith =>
      _$SnRelationshipCopyWithImpl<SnRelationship>(
          this as SnRelationship, _$identity);

  /// Serializes this SnRelationship to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SnRelationship &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.relatedId, relatedId) ||
                other.relatedId == relatedId) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.related, related) || other.related == related) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.permNodes, permNodes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      deletedAt,
      accountId,
      relatedId,
      account,
      related,
      status,
      const DeepCollectionEquality().hash(permNodes));

  @override
  String toString() {
    return 'SnRelationship(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, accountId: $accountId, relatedId: $relatedId, account: $account, related: $related, status: $status, permNodes: $permNodes)';
  }
}

/// @nodoc
abstract mixin class $SnRelationshipCopyWith<$Res> {
  factory $SnRelationshipCopyWith(
          SnRelationship value, $Res Function(SnRelationship) _then) =
      _$SnRelationshipCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      int accountId,
      int relatedId,
      SnAccount? account,
      SnAccount? related,
      int status,
      Map<String, dynamic> permNodes});

  $SnAccountCopyWith<$Res>? get account;
  $SnAccountCopyWith<$Res>? get related;
}

/// @nodoc
class _$SnRelationshipCopyWithImpl<$Res>
    implements $SnRelationshipCopyWith<$Res> {
  _$SnRelationshipCopyWithImpl(this._self, this._then);

  final SnRelationship _self;
  final $Res Function(SnRelationship) _then;

  /// Create a copy of SnRelationship
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? accountId = null,
    Object? relatedId = null,
    Object? account = freezed,
    Object? related = freezed,
    Object? status = null,
    Object? permNodes = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      accountId: null == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      relatedId: null == relatedId
          ? _self.relatedId
          : relatedId // ignore: cast_nullable_to_non_nullable
              as int,
      account: freezed == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as SnAccount?,
      related: freezed == related
          ? _self.related
          : related // ignore: cast_nullable_to_non_nullable
              as SnAccount?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      permNodes: null == permNodes
          ? _self.permNodes
          : permNodes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }

  /// Create a copy of SnRelationship
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnAccountCopyWith<$Res>? get account {
    if (_self.account == null) {
      return null;
    }

    return $SnAccountCopyWith<$Res>(_self.account!, (value) {
      return _then(_self.copyWith(account: value));
    });
  }

  /// Create a copy of SnRelationship
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnAccountCopyWith<$Res>? get related {
    if (_self.related == null) {
      return null;
    }

    return $SnAccountCopyWith<$Res>(_self.related!, (value) {
      return _then(_self.copyWith(related: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _SnRelationship implements SnRelationship {
  const _SnRelationship(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.accountId,
      required this.relatedId,
      required this.account,
      required this.related,
      required this.status,
      final Map<String, dynamic> permNodes = const {}})
      : _permNodes = permNodes;
  factory _SnRelationship.fromJson(Map<String, dynamic> json) =>
      _$SnRelationshipFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final int accountId;
  @override
  final int relatedId;
  @override
  final SnAccount? account;
  @override
  final SnAccount? related;
  @override
  final int status;
  final Map<String, dynamic> _permNodes;
  @override
  @JsonKey()
  Map<String, dynamic> get permNodes {
    if (_permNodes is EqualUnmodifiableMapView) return _permNodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_permNodes);
  }

  /// Create a copy of SnRelationship
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SnRelationshipCopyWith<_SnRelationship> get copyWith =>
      __$SnRelationshipCopyWithImpl<_SnRelationship>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SnRelationshipToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SnRelationship &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.relatedId, relatedId) ||
                other.relatedId == relatedId) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.related, related) || other.related == related) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._permNodes, _permNodes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      deletedAt,
      accountId,
      relatedId,
      account,
      related,
      status,
      const DeepCollectionEquality().hash(_permNodes));

  @override
  String toString() {
    return 'SnRelationship(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, accountId: $accountId, relatedId: $relatedId, account: $account, related: $related, status: $status, permNodes: $permNodes)';
  }
}

/// @nodoc
abstract mixin class _$SnRelationshipCopyWith<$Res>
    implements $SnRelationshipCopyWith<$Res> {
  factory _$SnRelationshipCopyWith(
          _SnRelationship value, $Res Function(_SnRelationship) _then) =
      __$SnRelationshipCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      int accountId,
      int relatedId,
      SnAccount? account,
      SnAccount? related,
      int status,
      Map<String, dynamic> permNodes});

  @override
  $SnAccountCopyWith<$Res>? get account;
  @override
  $SnAccountCopyWith<$Res>? get related;
}

/// @nodoc
class __$SnRelationshipCopyWithImpl<$Res>
    implements _$SnRelationshipCopyWith<$Res> {
  __$SnRelationshipCopyWithImpl(this._self, this._then);

  final _SnRelationship _self;
  final $Res Function(_SnRelationship) _then;

  /// Create a copy of SnRelationship
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? accountId = null,
    Object? relatedId = null,
    Object? account = freezed,
    Object? related = freezed,
    Object? status = null,
    Object? permNodes = null,
  }) {
    return _then(_SnRelationship(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      accountId: null == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      relatedId: null == relatedId
          ? _self.relatedId
          : relatedId // ignore: cast_nullable_to_non_nullable
              as int,
      account: freezed == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as SnAccount?,
      related: freezed == related
          ? _self.related
          : related // ignore: cast_nullable_to_non_nullable
              as SnAccount?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      permNodes: null == permNodes
          ? _self._permNodes
          : permNodes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }

  /// Create a copy of SnRelationship
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnAccountCopyWith<$Res>? get account {
    if (_self.account == null) {
      return null;
    }

    return $SnAccountCopyWith<$Res>(_self.account!, (value) {
      return _then(_self.copyWith(account: value));
    });
  }

  /// Create a copy of SnRelationship
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnAccountCopyWith<$Res>? get related {
    if (_self.related == null) {
      return null;
    }

    return $SnAccountCopyWith<$Res>(_self.related!, (value) {
      return _then(_self.copyWith(related: value));
    });
  }
}

/// @nodoc
mixin _$SnAccountBadge {
  int get id;
  DateTime get createdAt;
  DateTime get updatedAt;
  dynamic get deletedAt;
  String get type;
  int get accountId;
  bool get isActive;
  Map<String, dynamic> get metadata;

  /// Create a copy of SnAccountBadge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SnAccountBadgeCopyWith<SnAccountBadge> get copyWith =>
      _$SnAccountBadgeCopyWithImpl<SnAccountBadge>(
          this as SnAccountBadge, _$identity);

  /// Serializes this SnAccountBadge to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SnAccountBadge &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other.deletedAt, deletedAt) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other.metadata, metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(deletedAt),
      type,
      accountId,
      isActive,
      const DeepCollectionEquality().hash(metadata));

  @override
  String toString() {
    return 'SnAccountBadge(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, type: $type, accountId: $accountId, isActive: $isActive, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class $SnAccountBadgeCopyWith<$Res> {
  factory $SnAccountBadgeCopyWith(
          SnAccountBadge value, $Res Function(SnAccountBadge) _then) =
      _$SnAccountBadgeCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      dynamic deletedAt,
      String type,
      int accountId,
      bool isActive,
      Map<String, dynamic> metadata});
}

/// @nodoc
class _$SnAccountBadgeCopyWithImpl<$Res>
    implements $SnAccountBadgeCopyWith<$Res> {
  _$SnAccountBadgeCopyWithImpl(this._self, this._then);

  final SnAccountBadge _self;
  final $Res Function(SnAccountBadge) _then;

  /// Create a copy of SnAccountBadge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? type = null,
    Object? accountId = null,
    Object? isActive = null,
    Object? metadata = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      accountId: null == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: null == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SnAccountBadge implements SnAccountBadge {
  const _SnAccountBadge(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.type,
      required this.accountId,
      this.isActive = false,
      final Map<String, dynamic> metadata = const {}})
      : _metadata = metadata;
  factory _SnAccountBadge.fromJson(Map<String, dynamic> json) =>
      _$SnAccountBadgeFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final dynamic deletedAt;
  @override
  final String type;
  @override
  final int accountId;
  @override
  @JsonKey()
  final bool isActive;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  /// Create a copy of SnAccountBadge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SnAccountBadgeCopyWith<_SnAccountBadge> get copyWith =>
      __$SnAccountBadgeCopyWithImpl<_SnAccountBadge>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SnAccountBadgeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SnAccountBadge &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other.deletedAt, deletedAt) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(deletedAt),
      type,
      accountId,
      isActive,
      const DeepCollectionEquality().hash(_metadata));

  @override
  String toString() {
    return 'SnAccountBadge(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, type: $type, accountId: $accountId, isActive: $isActive, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class _$SnAccountBadgeCopyWith<$Res>
    implements $SnAccountBadgeCopyWith<$Res> {
  factory _$SnAccountBadgeCopyWith(
          _SnAccountBadge value, $Res Function(_SnAccountBadge) _then) =
      __$SnAccountBadgeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      dynamic deletedAt,
      String type,
      int accountId,
      bool isActive,
      Map<String, dynamic> metadata});
}

/// @nodoc
class __$SnAccountBadgeCopyWithImpl<$Res>
    implements _$SnAccountBadgeCopyWith<$Res> {
  __$SnAccountBadgeCopyWithImpl(this._self, this._then);

  final _SnAccountBadge _self;
  final $Res Function(_SnAccountBadge) _then;

  /// Create a copy of SnAccountBadge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? type = null,
    Object? accountId = null,
    Object? isActive = null,
    Object? metadata = null,
  }) {
    return _then(_SnAccountBadge(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      accountId: null == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _self.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: null == metadata
          ? _self._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
mixin _$SnAccountStatusInfo {
  bool get isDisturbable;
  bool get isOnline;
  DateTime? get lastSeenAt;
  SnAccountStatus? get status;

  /// Create a copy of SnAccountStatusInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SnAccountStatusInfoCopyWith<SnAccountStatusInfo> get copyWith =>
      _$SnAccountStatusInfoCopyWithImpl<SnAccountStatusInfo>(
          this as SnAccountStatusInfo, _$identity);

  /// Serializes this SnAccountStatusInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SnAccountStatusInfo &&
            (identical(other.isDisturbable, isDisturbable) ||
                other.isDisturbable == isDisturbable) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                other.lastSeenAt == lastSeenAt) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isDisturbable, isOnline, lastSeenAt, status);

  @override
  String toString() {
    return 'SnAccountStatusInfo(isDisturbable: $isDisturbable, isOnline: $isOnline, lastSeenAt: $lastSeenAt, status: $status)';
  }
}

/// @nodoc
abstract mixin class $SnAccountStatusInfoCopyWith<$Res> {
  factory $SnAccountStatusInfoCopyWith(
          SnAccountStatusInfo value, $Res Function(SnAccountStatusInfo) _then) =
      _$SnAccountStatusInfoCopyWithImpl;
  @useResult
  $Res call(
      {bool isDisturbable,
      bool isOnline,
      DateTime? lastSeenAt,
      SnAccountStatus? status});

  $SnAccountStatusCopyWith<$Res>? get status;
}

/// @nodoc
class _$SnAccountStatusInfoCopyWithImpl<$Res>
    implements $SnAccountStatusInfoCopyWith<$Res> {
  _$SnAccountStatusInfoCopyWithImpl(this._self, this._then);

  final SnAccountStatusInfo _self;
  final $Res Function(SnAccountStatusInfo) _then;

  /// Create a copy of SnAccountStatusInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDisturbable = null,
    Object? isOnline = null,
    Object? lastSeenAt = freezed,
    Object? status = freezed,
  }) {
    return _then(_self.copyWith(
      isDisturbable: null == isDisturbable
          ? _self.isDisturbable
          : isDisturbable // ignore: cast_nullable_to_non_nullable
              as bool,
      isOnline: null == isOnline
          ? _self.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeenAt: freezed == lastSeenAt
          ? _self.lastSeenAt
          : lastSeenAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as SnAccountStatus?,
    ));
  }

  /// Create a copy of SnAccountStatusInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnAccountStatusCopyWith<$Res>? get status {
    if (_self.status == null) {
      return null;
    }

    return $SnAccountStatusCopyWith<$Res>(_self.status!, (value) {
      return _then(_self.copyWith(status: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _SnAccountStatusInfo implements SnAccountStatusInfo {
  const _SnAccountStatusInfo(
      {required this.isDisturbable,
      required this.isOnline,
      required this.lastSeenAt,
      required this.status});
  factory _SnAccountStatusInfo.fromJson(Map<String, dynamic> json) =>
      _$SnAccountStatusInfoFromJson(json);

  @override
  final bool isDisturbable;
  @override
  final bool isOnline;
  @override
  final DateTime? lastSeenAt;
  @override
  final SnAccountStatus? status;

  /// Create a copy of SnAccountStatusInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SnAccountStatusInfoCopyWith<_SnAccountStatusInfo> get copyWith =>
      __$SnAccountStatusInfoCopyWithImpl<_SnAccountStatusInfo>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SnAccountStatusInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SnAccountStatusInfo &&
            (identical(other.isDisturbable, isDisturbable) ||
                other.isDisturbable == isDisturbable) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                other.lastSeenAt == lastSeenAt) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, isDisturbable, isOnline, lastSeenAt, status);

  @override
  String toString() {
    return 'SnAccountStatusInfo(isDisturbable: $isDisturbable, isOnline: $isOnline, lastSeenAt: $lastSeenAt, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$SnAccountStatusInfoCopyWith<$Res>
    implements $SnAccountStatusInfoCopyWith<$Res> {
  factory _$SnAccountStatusInfoCopyWith(_SnAccountStatusInfo value,
          $Res Function(_SnAccountStatusInfo) _then) =
      __$SnAccountStatusInfoCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isDisturbable,
      bool isOnline,
      DateTime? lastSeenAt,
      SnAccountStatus? status});

  @override
  $SnAccountStatusCopyWith<$Res>? get status;
}

/// @nodoc
class __$SnAccountStatusInfoCopyWithImpl<$Res>
    implements _$SnAccountStatusInfoCopyWith<$Res> {
  __$SnAccountStatusInfoCopyWithImpl(this._self, this._then);

  final _SnAccountStatusInfo _self;
  final $Res Function(_SnAccountStatusInfo) _then;

  /// Create a copy of SnAccountStatusInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isDisturbable = null,
    Object? isOnline = null,
    Object? lastSeenAt = freezed,
    Object? status = freezed,
  }) {
    return _then(_SnAccountStatusInfo(
      isDisturbable: null == isDisturbable
          ? _self.isDisturbable
          : isDisturbable // ignore: cast_nullable_to_non_nullable
              as bool,
      isOnline: null == isOnline
          ? _self.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeenAt: freezed == lastSeenAt
          ? _self.lastSeenAt
          : lastSeenAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as SnAccountStatus?,
    ));
  }

  /// Create a copy of SnAccountStatusInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnAccountStatusCopyWith<$Res>? get status {
    if (_self.status == null) {
      return null;
    }

    return $SnAccountStatusCopyWith<$Res>(_self.status!, (value) {
      return _then(_self.copyWith(status: value));
    });
  }
}

/// @nodoc
mixin _$SnAccountStatus {
  int get id;
  DateTime get createdAt;
  DateTime get updatedAt;
  DateTime? get deletedAt;
  String get type;
  String get label;
  int get attitude;
  bool get isNoDisturb;
  bool get isInvisible;
  DateTime? get clearAt;
  int get accountId;

  /// Create a copy of SnAccountStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SnAccountStatusCopyWith<SnAccountStatus> get copyWith =>
      _$SnAccountStatusCopyWithImpl<SnAccountStatus>(
          this as SnAccountStatus, _$identity);

  /// Serializes this SnAccountStatus to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SnAccountStatus &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.attitude, attitude) ||
                other.attitude == attitude) &&
            (identical(other.isNoDisturb, isNoDisturb) ||
                other.isNoDisturb == isNoDisturb) &&
            (identical(other.isInvisible, isInvisible) ||
                other.isInvisible == isInvisible) &&
            (identical(other.clearAt, clearAt) || other.clearAt == clearAt) &&
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
      label,
      attitude,
      isNoDisturb,
      isInvisible,
      clearAt,
      accountId);

  @override
  String toString() {
    return 'SnAccountStatus(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, type: $type, label: $label, attitude: $attitude, isNoDisturb: $isNoDisturb, isInvisible: $isInvisible, clearAt: $clearAt, accountId: $accountId)';
  }
}

/// @nodoc
abstract mixin class $SnAccountStatusCopyWith<$Res> {
  factory $SnAccountStatusCopyWith(
          SnAccountStatus value, $Res Function(SnAccountStatus) _then) =
      _$SnAccountStatusCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String type,
      String label,
      int attitude,
      bool isNoDisturb,
      bool isInvisible,
      DateTime? clearAt,
      int accountId});
}

/// @nodoc
class _$SnAccountStatusCopyWithImpl<$Res>
    implements $SnAccountStatusCopyWith<$Res> {
  _$SnAccountStatusCopyWithImpl(this._self, this._then);

  final SnAccountStatus _self;
  final $Res Function(SnAccountStatus) _then;

  /// Create a copy of SnAccountStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? type = null,
    Object? label = null,
    Object? attitude = null,
    Object? isNoDisturb = null,
    Object? isInvisible = null,
    Object? clearAt = freezed,
    Object? accountId = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      attitude: null == attitude
          ? _self.attitude
          : attitude // ignore: cast_nullable_to_non_nullable
              as int,
      isNoDisturb: null == isNoDisturb
          ? _self.isNoDisturb
          : isNoDisturb // ignore: cast_nullable_to_non_nullable
              as bool,
      isInvisible: null == isInvisible
          ? _self.isInvisible
          : isInvisible // ignore: cast_nullable_to_non_nullable
              as bool,
      clearAt: freezed == clearAt
          ? _self.clearAt
          : clearAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      accountId: null == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SnAccountStatus implements SnAccountStatus {
  const _SnAccountStatus(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.type,
      required this.label,
      required this.attitude,
      required this.isNoDisturb,
      required this.isInvisible,
      required this.clearAt,
      required this.accountId});
  factory _SnAccountStatus.fromJson(Map<String, dynamic> json) =>
      _$SnAccountStatusFromJson(json);

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
  @override
  final String label;
  @override
  final int attitude;
  @override
  final bool isNoDisturb;
  @override
  final bool isInvisible;
  @override
  final DateTime? clearAt;
  @override
  final int accountId;

  /// Create a copy of SnAccountStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SnAccountStatusCopyWith<_SnAccountStatus> get copyWith =>
      __$SnAccountStatusCopyWithImpl<_SnAccountStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SnAccountStatusToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SnAccountStatus &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.attitude, attitude) ||
                other.attitude == attitude) &&
            (identical(other.isNoDisturb, isNoDisturb) ||
                other.isNoDisturb == isNoDisturb) &&
            (identical(other.isInvisible, isInvisible) ||
                other.isInvisible == isInvisible) &&
            (identical(other.clearAt, clearAt) || other.clearAt == clearAt) &&
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
      label,
      attitude,
      isNoDisturb,
      isInvisible,
      clearAt,
      accountId);

  @override
  String toString() {
    return 'SnAccountStatus(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, type: $type, label: $label, attitude: $attitude, isNoDisturb: $isNoDisturb, isInvisible: $isInvisible, clearAt: $clearAt, accountId: $accountId)';
  }
}

/// @nodoc
abstract mixin class _$SnAccountStatusCopyWith<$Res>
    implements $SnAccountStatusCopyWith<$Res> {
  factory _$SnAccountStatusCopyWith(
          _SnAccountStatus value, $Res Function(_SnAccountStatus) _then) =
      __$SnAccountStatusCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String type,
      String label,
      int attitude,
      bool isNoDisturb,
      bool isInvisible,
      DateTime? clearAt,
      int accountId});
}

/// @nodoc
class __$SnAccountStatusCopyWithImpl<$Res>
    implements _$SnAccountStatusCopyWith<$Res> {
  __$SnAccountStatusCopyWithImpl(this._self, this._then);

  final _SnAccountStatus _self;
  final $Res Function(_SnAccountStatus) _then;

  /// Create a copy of SnAccountStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? type = null,
    Object? label = null,
    Object? attitude = null,
    Object? isNoDisturb = null,
    Object? isInvisible = null,
    Object? clearAt = freezed,
    Object? accountId = null,
  }) {
    return _then(_SnAccountStatus(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      attitude: null == attitude
          ? _self.attitude
          : attitude // ignore: cast_nullable_to_non_nullable
              as int,
      isNoDisturb: null == isNoDisturb
          ? _self.isNoDisturb
          : isNoDisturb // ignore: cast_nullable_to_non_nullable
              as bool,
      isInvisible: null == isInvisible
          ? _self.isInvisible
          : isInvisible // ignore: cast_nullable_to_non_nullable
              as bool,
      clearAt: freezed == clearAt
          ? _self.clearAt
          : clearAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      accountId: null == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$SnAbuseReport {
  int get id;
  DateTime get createdAt;
  DateTime get updatedAt;
  DateTime? get deletedAt;
  String get resource;
  String get reason;
  String get status;
  int get accountId;

  /// Create a copy of SnAbuseReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SnAbuseReportCopyWith<SnAbuseReport> get copyWith =>
      _$SnAbuseReportCopyWithImpl<SnAbuseReport>(
          this as SnAbuseReport, _$identity);

  /// Serializes this SnAbuseReport to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SnAbuseReport &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.resource, resource) ||
                other.resource == resource) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, updatedAt,
      deletedAt, resource, reason, status, accountId);

  @override
  String toString() {
    return 'SnAbuseReport(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, resource: $resource, reason: $reason, status: $status, accountId: $accountId)';
  }
}

/// @nodoc
abstract mixin class $SnAbuseReportCopyWith<$Res> {
  factory $SnAbuseReportCopyWith(
          SnAbuseReport value, $Res Function(SnAbuseReport) _then) =
      _$SnAbuseReportCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String resource,
      String reason,
      String status,
      int accountId});
}

/// @nodoc
class _$SnAbuseReportCopyWithImpl<$Res>
    implements $SnAbuseReportCopyWith<$Res> {
  _$SnAbuseReportCopyWithImpl(this._self, this._then);

  final SnAbuseReport _self;
  final $Res Function(SnAbuseReport) _then;

  /// Create a copy of SnAbuseReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? resource = null,
    Object? reason = null,
    Object? status = null,
    Object? accountId = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resource: null == resource
          ? _self.resource
          : resource // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      accountId: null == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SnAbuseReport implements SnAbuseReport {
  const _SnAbuseReport(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.resource,
      required this.reason,
      required this.status,
      required this.accountId});
  factory _SnAbuseReport.fromJson(Map<String, dynamic> json) =>
      _$SnAbuseReportFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final String resource;
  @override
  final String reason;
  @override
  final String status;
  @override
  final int accountId;

  /// Create a copy of SnAbuseReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SnAbuseReportCopyWith<_SnAbuseReport> get copyWith =>
      __$SnAbuseReportCopyWithImpl<_SnAbuseReport>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SnAbuseReportToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SnAbuseReport &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.resource, resource) ||
                other.resource == resource) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, updatedAt,
      deletedAt, resource, reason, status, accountId);

  @override
  String toString() {
    return 'SnAbuseReport(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, resource: $resource, reason: $reason, status: $status, accountId: $accountId)';
  }
}

/// @nodoc
abstract mixin class _$SnAbuseReportCopyWith<$Res>
    implements $SnAbuseReportCopyWith<$Res> {
  factory _$SnAbuseReportCopyWith(
          _SnAbuseReport value, $Res Function(_SnAbuseReport) _then) =
      __$SnAbuseReportCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String resource,
      String reason,
      String status,
      int accountId});
}

/// @nodoc
class __$SnAbuseReportCopyWithImpl<$Res>
    implements _$SnAbuseReportCopyWith<$Res> {
  __$SnAbuseReportCopyWithImpl(this._self, this._then);

  final _SnAbuseReport _self;
  final $Res Function(_SnAbuseReport) _then;

  /// Create a copy of SnAbuseReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? resource = null,
    Object? reason = null,
    Object? status = null,
    Object? accountId = null,
  }) {
    return _then(_SnAbuseReport(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      resource: null == resource
          ? _self.resource
          : resource // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      accountId: null == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$SnActionEvent {
  int get id;
  DateTime get createdAt;
  DateTime get updatedAt;
  DateTime? get deletedAt;
  String get type;
  Map<String, dynamic>? get metadata;
  String? get location;
  double? get coordinateX;
  double? get coordinateY;
  String get ipAddress;
  String get userAgent;
  SnAccount get account;
  int get accountId;

  /// Create a copy of SnActionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SnActionEventCopyWith<SnActionEvent> get copyWith =>
      _$SnActionEventCopyWithImpl<SnActionEvent>(
          this as SnActionEvent, _$identity);

  /// Serializes this SnActionEvent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SnActionEvent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.metadata, metadata) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.coordinateX, coordinateX) ||
                other.coordinateX == coordinateX) &&
            (identical(other.coordinateY, coordinateY) ||
                other.coordinateY == coordinateY) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.userAgent, userAgent) ||
                other.userAgent == userAgent) &&
            (identical(other.account, account) || other.account == account) &&
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
      const DeepCollectionEquality().hash(metadata),
      location,
      coordinateX,
      coordinateY,
      ipAddress,
      userAgent,
      account,
      accountId);

  @override
  String toString() {
    return 'SnActionEvent(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, type: $type, metadata: $metadata, location: $location, coordinateX: $coordinateX, coordinateY: $coordinateY, ipAddress: $ipAddress, userAgent: $userAgent, account: $account, accountId: $accountId)';
  }
}

/// @nodoc
abstract mixin class $SnActionEventCopyWith<$Res> {
  factory $SnActionEventCopyWith(
          SnActionEvent value, $Res Function(SnActionEvent) _then) =
      _$SnActionEventCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String type,
      Map<String, dynamic>? metadata,
      String? location,
      double? coordinateX,
      double? coordinateY,
      String ipAddress,
      String userAgent,
      SnAccount account,
      int accountId});

  $SnAccountCopyWith<$Res> get account;
}

/// @nodoc
class _$SnActionEventCopyWithImpl<$Res>
    implements $SnActionEventCopyWith<$Res> {
  _$SnActionEventCopyWithImpl(this._self, this._then);

  final SnActionEvent _self;
  final $Res Function(SnActionEvent) _then;

  /// Create a copy of SnActionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? type = null,
    Object? metadata = freezed,
    Object? location = freezed,
    Object? coordinateX = freezed,
    Object? coordinateY = freezed,
    Object? ipAddress = null,
    Object? userAgent = null,
    Object? account = null,
    Object? accountId = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: freezed == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      coordinateX: freezed == coordinateX
          ? _self.coordinateX
          : coordinateX // ignore: cast_nullable_to_non_nullable
              as double?,
      coordinateY: freezed == coordinateY
          ? _self.coordinateY
          : coordinateY // ignore: cast_nullable_to_non_nullable
              as double?,
      ipAddress: null == ipAddress
          ? _self.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String,
      userAgent: null == userAgent
          ? _self.userAgent
          : userAgent // ignore: cast_nullable_to_non_nullable
              as String,
      account: null == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as SnAccount,
      accountId: null == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of SnActionEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnAccountCopyWith<$Res> get account {
    return $SnAccountCopyWith<$Res>(_self.account, (value) {
      return _then(_self.copyWith(account: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _SnActionEvent implements SnActionEvent {
  const _SnActionEvent(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.type,
      required final Map<String, dynamic>? metadata,
      required this.location,
      required this.coordinateX,
      required this.coordinateY,
      required this.ipAddress,
      required this.userAgent,
      required this.account,
      required this.accountId})
      : _metadata = metadata;
  factory _SnActionEvent.fromJson(Map<String, dynamic> json) =>
      _$SnActionEventFromJson(json);

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
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? location;
  @override
  final double? coordinateX;
  @override
  final double? coordinateY;
  @override
  final String ipAddress;
  @override
  final String userAgent;
  @override
  final SnAccount account;
  @override
  final int accountId;

  /// Create a copy of SnActionEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SnActionEventCopyWith<_SnActionEvent> get copyWith =>
      __$SnActionEventCopyWithImpl<_SnActionEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SnActionEventToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SnActionEvent &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.coordinateX, coordinateX) ||
                other.coordinateX == coordinateX) &&
            (identical(other.coordinateY, coordinateY) ||
                other.coordinateY == coordinateY) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.userAgent, userAgent) ||
                other.userAgent == userAgent) &&
            (identical(other.account, account) || other.account == account) &&
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
      const DeepCollectionEquality().hash(_metadata),
      location,
      coordinateX,
      coordinateY,
      ipAddress,
      userAgent,
      account,
      accountId);

  @override
  String toString() {
    return 'SnActionEvent(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, type: $type, metadata: $metadata, location: $location, coordinateX: $coordinateX, coordinateY: $coordinateY, ipAddress: $ipAddress, userAgent: $userAgent, account: $account, accountId: $accountId)';
  }
}

/// @nodoc
abstract mixin class _$SnActionEventCopyWith<$Res>
    implements $SnActionEventCopyWith<$Res> {
  factory _$SnActionEventCopyWith(
          _SnActionEvent value, $Res Function(_SnActionEvent) _then) =
      __$SnActionEventCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String type,
      Map<String, dynamic>? metadata,
      String? location,
      double? coordinateX,
      double? coordinateY,
      String ipAddress,
      String userAgent,
      SnAccount account,
      int accountId});

  @override
  $SnAccountCopyWith<$Res> get account;
}

/// @nodoc
class __$SnActionEventCopyWithImpl<$Res>
    implements _$SnActionEventCopyWith<$Res> {
  __$SnActionEventCopyWithImpl(this._self, this._then);

  final _SnActionEvent _self;
  final $Res Function(_SnActionEvent) _then;

  /// Create a copy of SnActionEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? type = null,
    Object? metadata = freezed,
    Object? location = freezed,
    Object? coordinateX = freezed,
    Object? coordinateY = freezed,
    Object? ipAddress = null,
    Object? userAgent = null,
    Object? account = null,
    Object? accountId = null,
  }) {
    return _then(_SnActionEvent(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: freezed == metadata
          ? _self._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      coordinateX: freezed == coordinateX
          ? _self.coordinateX
          : coordinateX // ignore: cast_nullable_to_non_nullable
              as double?,
      coordinateY: freezed == coordinateY
          ? _self.coordinateY
          : coordinateY // ignore: cast_nullable_to_non_nullable
              as double?,
      ipAddress: null == ipAddress
          ? _self.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String,
      userAgent: null == userAgent
          ? _self.userAgent
          : userAgent // ignore: cast_nullable_to_non_nullable
              as String,
      account: null == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as SnAccount,
      accountId: null == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of SnActionEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnAccountCopyWith<$Res> get account {
    return $SnAccountCopyWith<$Res>(_self.account, (value) {
      return _then(_self.copyWith(account: value));
    });
  }
}

/// @nodoc
mixin _$SnProgram {
  int get id;
  DateTime get createdAt;
  DateTime get updatedAt;
  DateTime? get deletedAt;
  String get name;
  String get description;
  String get alias;
  int get expRequirement;
  Map<String, dynamic> get price;
  Map<String, dynamic> get badge;
  Map<String, dynamic> get group;
  Map<String, dynamic> get appearance;

  /// Create a copy of SnProgram
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SnProgramCopyWith<SnProgram> get copyWith =>
      _$SnProgramCopyWithImpl<SnProgram>(this as SnProgram, _$identity);

  /// Serializes this SnProgram to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SnProgram &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.alias, alias) || other.alias == alias) &&
            (identical(other.expRequirement, expRequirement) ||
                other.expRequirement == expRequirement) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality().equals(other.badge, badge) &&
            const DeepCollectionEquality().equals(other.group, group) &&
            const DeepCollectionEquality()
                .equals(other.appearance, appearance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      deletedAt,
      name,
      description,
      alias,
      expRequirement,
      const DeepCollectionEquality().hash(price),
      const DeepCollectionEquality().hash(badge),
      const DeepCollectionEquality().hash(group),
      const DeepCollectionEquality().hash(appearance));

  @override
  String toString() {
    return 'SnProgram(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, name: $name, description: $description, alias: $alias, expRequirement: $expRequirement, price: $price, badge: $badge, group: $group, appearance: $appearance)';
  }
}

/// @nodoc
abstract mixin class $SnProgramCopyWith<$Res> {
  factory $SnProgramCopyWith(SnProgram value, $Res Function(SnProgram) _then) =
      _$SnProgramCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String name,
      String description,
      String alias,
      int expRequirement,
      Map<String, dynamic> price,
      Map<String, dynamic> badge,
      Map<String, dynamic> group,
      Map<String, dynamic> appearance});
}

/// @nodoc
class _$SnProgramCopyWithImpl<$Res> implements $SnProgramCopyWith<$Res> {
  _$SnProgramCopyWithImpl(this._self, this._then);

  final SnProgram _self;
  final $Res Function(SnProgram) _then;

  /// Create a copy of SnProgram
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? name = null,
    Object? description = null,
    Object? alias = null,
    Object? expRequirement = null,
    Object? price = null,
    Object? badge = null,
    Object? group = null,
    Object? appearance = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      alias: null == alias
          ? _self.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
      expRequirement: null == expRequirement
          ? _self.expRequirement
          : expRequirement // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _self.price
          : price // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      badge: null == badge
          ? _self.badge
          : badge // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      group: null == group
          ? _self.group
          : group // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      appearance: null == appearance
          ? _self.appearance
          : appearance // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SnProgram implements SnProgram {
  const _SnProgram(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.name,
      required this.description,
      required this.alias,
      required this.expRequirement,
      required final Map<String, dynamic> price,
      required final Map<String, dynamic> badge,
      required final Map<String, dynamic> group,
      required final Map<String, dynamic> appearance})
      : _price = price,
        _badge = badge,
        _group = group,
        _appearance = appearance;
  factory _SnProgram.fromJson(Map<String, dynamic> json) =>
      _$SnProgramFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final String name;
  @override
  final String description;
  @override
  final String alias;
  @override
  final int expRequirement;
  final Map<String, dynamic> _price;
  @override
  Map<String, dynamic> get price {
    if (_price is EqualUnmodifiableMapView) return _price;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_price);
  }

  final Map<String, dynamic> _badge;
  @override
  Map<String, dynamic> get badge {
    if (_badge is EqualUnmodifiableMapView) return _badge;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_badge);
  }

  final Map<String, dynamic> _group;
  @override
  Map<String, dynamic> get group {
    if (_group is EqualUnmodifiableMapView) return _group;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_group);
  }

  final Map<String, dynamic> _appearance;
  @override
  Map<String, dynamic> get appearance {
    if (_appearance is EqualUnmodifiableMapView) return _appearance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_appearance);
  }

  /// Create a copy of SnProgram
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SnProgramCopyWith<_SnProgram> get copyWith =>
      __$SnProgramCopyWithImpl<_SnProgram>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SnProgramToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SnProgram &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.alias, alias) || other.alias == alias) &&
            (identical(other.expRequirement, expRequirement) ||
                other.expRequirement == expRequirement) &&
            const DeepCollectionEquality().equals(other._price, _price) &&
            const DeepCollectionEquality().equals(other._badge, _badge) &&
            const DeepCollectionEquality().equals(other._group, _group) &&
            const DeepCollectionEquality()
                .equals(other._appearance, _appearance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      deletedAt,
      name,
      description,
      alias,
      expRequirement,
      const DeepCollectionEquality().hash(_price),
      const DeepCollectionEquality().hash(_badge),
      const DeepCollectionEquality().hash(_group),
      const DeepCollectionEquality().hash(_appearance));

  @override
  String toString() {
    return 'SnProgram(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, name: $name, description: $description, alias: $alias, expRequirement: $expRequirement, price: $price, badge: $badge, group: $group, appearance: $appearance)';
  }
}

/// @nodoc
abstract mixin class _$SnProgramCopyWith<$Res>
    implements $SnProgramCopyWith<$Res> {
  factory _$SnProgramCopyWith(
          _SnProgram value, $Res Function(_SnProgram) _then) =
      __$SnProgramCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String name,
      String description,
      String alias,
      int expRequirement,
      Map<String, dynamic> price,
      Map<String, dynamic> badge,
      Map<String, dynamic> group,
      Map<String, dynamic> appearance});
}

/// @nodoc
class __$SnProgramCopyWithImpl<$Res> implements _$SnProgramCopyWith<$Res> {
  __$SnProgramCopyWithImpl(this._self, this._then);

  final _SnProgram _self;
  final $Res Function(_SnProgram) _then;

  /// Create a copy of SnProgram
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? name = null,
    Object? description = null,
    Object? alias = null,
    Object? expRequirement = null,
    Object? price = null,
    Object? badge = null,
    Object? group = null,
    Object? appearance = null,
  }) {
    return _then(_SnProgram(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      alias: null == alias
          ? _self.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
      expRequirement: null == expRequirement
          ? _self.expRequirement
          : expRequirement // ignore: cast_nullable_to_non_nullable
              as int,
      price: null == price
          ? _self._price
          : price // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      badge: null == badge
          ? _self._badge
          : badge // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      group: null == group
          ? _self._group
          : group // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      appearance: null == appearance
          ? _self._appearance
          : appearance // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
mixin _$SnProgramMember {
  int get id;
  DateTime get createdAt;
  DateTime get updatedAt;
  DateTime? get deletedAt;
  DateTime get lastPaid;
  SnAccount get account;
  int get accountId;
  SnProgram get program;
  int get programId;

  /// Create a copy of SnProgramMember
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SnProgramMemberCopyWith<SnProgramMember> get copyWith =>
      _$SnProgramMemberCopyWithImpl<SnProgramMember>(
          this as SnProgramMember, _$identity);

  /// Serializes this SnProgramMember to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SnProgramMember &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.lastPaid, lastPaid) ||
                other.lastPaid == lastPaid) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.program, program) || other.program == program) &&
            (identical(other.programId, programId) ||
                other.programId == programId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, updatedAt,
      deletedAt, lastPaid, account, accountId, program, programId);

  @override
  String toString() {
    return 'SnProgramMember(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, lastPaid: $lastPaid, account: $account, accountId: $accountId, program: $program, programId: $programId)';
  }
}

/// @nodoc
abstract mixin class $SnProgramMemberCopyWith<$Res> {
  factory $SnProgramMemberCopyWith(
          SnProgramMember value, $Res Function(SnProgramMember) _then) =
      _$SnProgramMemberCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      DateTime lastPaid,
      SnAccount account,
      int accountId,
      SnProgram program,
      int programId});

  $SnAccountCopyWith<$Res> get account;
  $SnProgramCopyWith<$Res> get program;
}

/// @nodoc
class _$SnProgramMemberCopyWithImpl<$Res>
    implements $SnProgramMemberCopyWith<$Res> {
  _$SnProgramMemberCopyWithImpl(this._self, this._then);

  final SnProgramMember _self;
  final $Res Function(SnProgramMember) _then;

  /// Create a copy of SnProgramMember
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? lastPaid = null,
    Object? account = null,
    Object? accountId = null,
    Object? program = null,
    Object? programId = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastPaid: null == lastPaid
          ? _self.lastPaid
          : lastPaid // ignore: cast_nullable_to_non_nullable
              as DateTime,
      account: null == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as SnAccount,
      accountId: null == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      program: null == program
          ? _self.program
          : program // ignore: cast_nullable_to_non_nullable
              as SnProgram,
      programId: null == programId
          ? _self.programId
          : programId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of SnProgramMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnAccountCopyWith<$Res> get account {
    return $SnAccountCopyWith<$Res>(_self.account, (value) {
      return _then(_self.copyWith(account: value));
    });
  }

  /// Create a copy of SnProgramMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnProgramCopyWith<$Res> get program {
    return $SnProgramCopyWith<$Res>(_self.program, (value) {
      return _then(_self.copyWith(program: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _SnProgramMember implements SnProgramMember {
  const _SnProgramMember(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.lastPaid,
      required this.account,
      required this.accountId,
      required this.program,
      required this.programId});
  factory _SnProgramMember.fromJson(Map<String, dynamic> json) =>
      _$SnProgramMemberFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final DateTime lastPaid;
  @override
  final SnAccount account;
  @override
  final int accountId;
  @override
  final SnProgram program;
  @override
  final int programId;

  /// Create a copy of SnProgramMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SnProgramMemberCopyWith<_SnProgramMember> get copyWith =>
      __$SnProgramMemberCopyWithImpl<_SnProgramMember>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SnProgramMemberToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SnProgramMember &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.lastPaid, lastPaid) ||
                other.lastPaid == lastPaid) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.program, program) || other.program == program) &&
            (identical(other.programId, programId) ||
                other.programId == programId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, updatedAt,
      deletedAt, lastPaid, account, accountId, program, programId);

  @override
  String toString() {
    return 'SnProgramMember(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, lastPaid: $lastPaid, account: $account, accountId: $accountId, program: $program, programId: $programId)';
  }
}

/// @nodoc
abstract mixin class _$SnProgramMemberCopyWith<$Res>
    implements $SnProgramMemberCopyWith<$Res> {
  factory _$SnProgramMemberCopyWith(
          _SnProgramMember value, $Res Function(_SnProgramMember) _then) =
      __$SnProgramMemberCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      DateTime lastPaid,
      SnAccount account,
      int accountId,
      SnProgram program,
      int programId});

  @override
  $SnAccountCopyWith<$Res> get account;
  @override
  $SnProgramCopyWith<$Res> get program;
}

/// @nodoc
class __$SnProgramMemberCopyWithImpl<$Res>
    implements _$SnProgramMemberCopyWith<$Res> {
  __$SnProgramMemberCopyWithImpl(this._self, this._then);

  final _SnProgramMember _self;
  final $Res Function(_SnProgramMember) _then;

  /// Create a copy of SnProgramMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? lastPaid = null,
    Object? account = null,
    Object? accountId = null,
    Object? program = null,
    Object? programId = null,
  }) {
    return _then(_SnProgramMember(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastPaid: null == lastPaid
          ? _self.lastPaid
          : lastPaid // ignore: cast_nullable_to_non_nullable
              as DateTime,
      account: null == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as SnAccount,
      accountId: null == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
      program: null == program
          ? _self.program
          : program // ignore: cast_nullable_to_non_nullable
              as SnProgram,
      programId: null == programId
          ? _self.programId
          : programId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of SnProgramMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnAccountCopyWith<$Res> get account {
    return $SnAccountCopyWith<$Res>(_self.account, (value) {
      return _then(_self.copyWith(account: value));
    });
  }

  /// Create a copy of SnProgramMember
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnProgramCopyWith<$Res> get program {
    return $SnProgramCopyWith<$Res>(_self.program, (value) {
      return _then(_self.copyWith(program: value));
    });
  }
}

/// @nodoc
mixin _$SnPunishment {
  int get id;
  DateTime get createdAt;
  DateTime get updatedAt;
  DateTime? get deletedAt;
  String get reason;
  int get type;
  Map<String, dynamic> get permNodes;
  DateTime? get expiredAt;
  SnAccount? get account;
  int? get accountId;
  SnAccount? get moderator;
  int? get moderatorId;

  /// Create a copy of SnPunishment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SnPunishmentCopyWith<SnPunishment> get copyWith =>
      _$SnPunishmentCopyWithImpl<SnPunishment>(
          this as SnPunishment, _$identity);

  /// Serializes this SnPunishment to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SnPunishment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.permNodes, permNodes) &&
            (identical(other.expiredAt, expiredAt) ||
                other.expiredAt == expiredAt) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.moderator, moderator) ||
                other.moderator == moderator) &&
            (identical(other.moderatorId, moderatorId) ||
                other.moderatorId == moderatorId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      deletedAt,
      reason,
      type,
      const DeepCollectionEquality().hash(permNodes),
      expiredAt,
      account,
      accountId,
      moderator,
      moderatorId);

  @override
  String toString() {
    return 'SnPunishment(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, reason: $reason, type: $type, permNodes: $permNodes, expiredAt: $expiredAt, account: $account, accountId: $accountId, moderator: $moderator, moderatorId: $moderatorId)';
  }
}

/// @nodoc
abstract mixin class $SnPunishmentCopyWith<$Res> {
  factory $SnPunishmentCopyWith(
          SnPunishment value, $Res Function(SnPunishment) _then) =
      _$SnPunishmentCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String reason,
      int type,
      Map<String, dynamic> permNodes,
      DateTime? expiredAt,
      SnAccount? account,
      int? accountId,
      SnAccount? moderator,
      int? moderatorId});

  $SnAccountCopyWith<$Res>? get account;
  $SnAccountCopyWith<$Res>? get moderator;
}

/// @nodoc
class _$SnPunishmentCopyWithImpl<$Res> implements $SnPunishmentCopyWith<$Res> {
  _$SnPunishmentCopyWithImpl(this._self, this._then);

  final SnPunishment _self;
  final $Res Function(SnPunishment) _then;

  /// Create a copy of SnPunishment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? reason = null,
    Object? type = null,
    Object? permNodes = null,
    Object? expiredAt = freezed,
    Object? account = freezed,
    Object? accountId = freezed,
    Object? moderator = freezed,
    Object? moderatorId = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reason: null == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      permNodes: null == permNodes
          ? _self.permNodes
          : permNodes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      expiredAt: freezed == expiredAt
          ? _self.expiredAt
          : expiredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      account: freezed == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as SnAccount?,
      accountId: freezed == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int?,
      moderator: freezed == moderator
          ? _self.moderator
          : moderator // ignore: cast_nullable_to_non_nullable
              as SnAccount?,
      moderatorId: freezed == moderatorId
          ? _self.moderatorId
          : moderatorId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of SnPunishment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnAccountCopyWith<$Res>? get account {
    if (_self.account == null) {
      return null;
    }

    return $SnAccountCopyWith<$Res>(_self.account!, (value) {
      return _then(_self.copyWith(account: value));
    });
  }

  /// Create a copy of SnPunishment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnAccountCopyWith<$Res>? get moderator {
    if (_self.moderator == null) {
      return null;
    }

    return $SnAccountCopyWith<$Res>(_self.moderator!, (value) {
      return _then(_self.copyWith(moderator: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _SnPunishment implements SnPunishment {
  const _SnPunishment(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.reason,
      required this.type,
      final Map<String, dynamic> permNodes = const {},
      required this.expiredAt,
      required this.account,
      required this.accountId,
      required this.moderator,
      required this.moderatorId})
      : _permNodes = permNodes;
  factory _SnPunishment.fromJson(Map<String, dynamic> json) =>
      _$SnPunishmentFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final String reason;
  @override
  final int type;
  final Map<String, dynamic> _permNodes;
  @override
  @JsonKey()
  Map<String, dynamic> get permNodes {
    if (_permNodes is EqualUnmodifiableMapView) return _permNodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_permNodes);
  }

  @override
  final DateTime? expiredAt;
  @override
  final SnAccount? account;
  @override
  final int? accountId;
  @override
  final SnAccount? moderator;
  @override
  final int? moderatorId;

  /// Create a copy of SnPunishment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SnPunishmentCopyWith<_SnPunishment> get copyWith =>
      __$SnPunishmentCopyWithImpl<_SnPunishment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SnPunishmentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SnPunishment &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality()
                .equals(other._permNodes, _permNodes) &&
            (identical(other.expiredAt, expiredAt) ||
                other.expiredAt == expiredAt) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.moderator, moderator) ||
                other.moderator == moderator) &&
            (identical(other.moderatorId, moderatorId) ||
                other.moderatorId == moderatorId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      updatedAt,
      deletedAt,
      reason,
      type,
      const DeepCollectionEquality().hash(_permNodes),
      expiredAt,
      account,
      accountId,
      moderator,
      moderatorId);

  @override
  String toString() {
    return 'SnPunishment(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, reason: $reason, type: $type, permNodes: $permNodes, expiredAt: $expiredAt, account: $account, accountId: $accountId, moderator: $moderator, moderatorId: $moderatorId)';
  }
}

/// @nodoc
abstract mixin class _$SnPunishmentCopyWith<$Res>
    implements $SnPunishmentCopyWith<$Res> {
  factory _$SnPunishmentCopyWith(
          _SnPunishment value, $Res Function(_SnPunishment) _then) =
      __$SnPunishmentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String reason,
      int type,
      Map<String, dynamic> permNodes,
      DateTime? expiredAt,
      SnAccount? account,
      int? accountId,
      SnAccount? moderator,
      int? moderatorId});

  @override
  $SnAccountCopyWith<$Res>? get account;
  @override
  $SnAccountCopyWith<$Res>? get moderator;
}

/// @nodoc
class __$SnPunishmentCopyWithImpl<$Res>
    implements _$SnPunishmentCopyWith<$Res> {
  __$SnPunishmentCopyWithImpl(this._self, this._then);

  final _SnPunishment _self;
  final $Res Function(_SnPunishment) _then;

  /// Create a copy of SnPunishment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? reason = null,
    Object? type = null,
    Object? permNodes = null,
    Object? expiredAt = freezed,
    Object? account = freezed,
    Object? accountId = freezed,
    Object? moderator = freezed,
    Object? moderatorId = freezed,
  }) {
    return _then(_SnPunishment(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reason: null == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      permNodes: null == permNodes
          ? _self._permNodes
          : permNodes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      expiredAt: freezed == expiredAt
          ? _self.expiredAt
          : expiredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      account: freezed == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as SnAccount?,
      accountId: freezed == accountId
          ? _self.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int?,
      moderator: freezed == moderator
          ? _self.moderator
          : moderator // ignore: cast_nullable_to_non_nullable
              as SnAccount?,
      moderatorId: freezed == moderatorId
          ? _self.moderatorId
          : moderatorId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of SnPunishment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnAccountCopyWith<$Res>? get account {
    if (_self.account == null) {
      return null;
    }

    return $SnAccountCopyWith<$Res>(_self.account!, (value) {
      return _then(_self.copyWith(account: value));
    });
  }

  /// Create a copy of SnPunishment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnAccountCopyWith<$Res>? get moderator {
    if (_self.moderator == null) {
      return null;
    }

    return $SnAccountCopyWith<$Res>(_self.moderator!, (value) {
      return _then(_self.copyWith(moderator: value));
    });
  }
}

// dart format on
