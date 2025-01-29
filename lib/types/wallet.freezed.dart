// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SnWallet _$SnWalletFromJson(Map<String, dynamic> json) {
  return _SnWallet.fromJson(json);
}

/// @nodoc
mixin _$SnWallet {
  int get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  String get balance => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  int get accountId => throw _privateConstructorUsedError;

  /// Serializes this SnWallet to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnWallet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnWalletCopyWith<SnWallet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnWalletCopyWith<$Res> {
  factory $SnWalletCopyWith(SnWallet value, $Res Function(SnWallet) then) =
      _$SnWalletCopyWithImpl<$Res, SnWallet>;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String balance,
      String password,
      int accountId});
}

/// @nodoc
class _$SnWalletCopyWithImpl<$Res, $Val extends SnWallet>
    implements $SnWalletCopyWith<$Res> {
  _$SnWalletCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnWallet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? balance = null,
    Object? password = null,
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
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SnWalletImplCopyWith<$Res>
    implements $SnWalletCopyWith<$Res> {
  factory _$$SnWalletImplCopyWith(
          _$SnWalletImpl value, $Res Function(_$SnWalletImpl) then) =
      __$$SnWalletImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String balance,
      String password,
      int accountId});
}

/// @nodoc
class __$$SnWalletImplCopyWithImpl<$Res>
    extends _$SnWalletCopyWithImpl<$Res, _$SnWalletImpl>
    implements _$$SnWalletImplCopyWith<$Res> {
  __$$SnWalletImplCopyWithImpl(
      _$SnWalletImpl _value, $Res Function(_$SnWalletImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnWallet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? balance = null,
    Object? password = null,
    Object? accountId = null,
  }) {
    return _then(_$SnWalletImpl(
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
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      accountId: null == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnWalletImpl implements _SnWallet {
  const _$SnWalletImpl(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.balance,
      required this.password,
      required this.accountId});

  factory _$SnWalletImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnWalletImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final String balance;
  @override
  final String password;
  @override
  final int accountId;

  @override
  String toString() {
    return 'SnWallet(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, balance: $balance, password: $password, accountId: $accountId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnWalletImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, updatedAt,
      deletedAt, balance, password, accountId);

  /// Create a copy of SnWallet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnWalletImplCopyWith<_$SnWalletImpl> get copyWith =>
      __$$SnWalletImplCopyWithImpl<_$SnWalletImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnWalletImplToJson(
      this,
    );
  }
}

abstract class _SnWallet implements SnWallet {
  const factory _SnWallet(
      {required final int id,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final DateTime? deletedAt,
      required final String balance,
      required final String password,
      required final int accountId}) = _$SnWalletImpl;

  factory _SnWallet.fromJson(Map<String, dynamic> json) =
      _$SnWalletImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get deletedAt;
  @override
  String get balance;
  @override
  String get password;
  @override
  int get accountId;

  /// Create a copy of SnWallet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnWalletImplCopyWith<_$SnWalletImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SnTransaction _$SnTransactionFromJson(Map<String, dynamic> json) {
  return _SnTransaction.fromJson(json);
}

/// @nodoc
mixin _$SnTransaction {
  int get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  String get remark => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  SnWallet? get payer => throw _privateConstructorUsedError;
  SnWallet? get payee => throw _privateConstructorUsedError;
  int? get payerId => throw _privateConstructorUsedError;
  int? get payeeId => throw _privateConstructorUsedError;

  /// Serializes this SnTransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SnTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SnTransactionCopyWith<SnTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnTransactionCopyWith<$Res> {
  factory $SnTransactionCopyWith(
          SnTransaction value, $Res Function(SnTransaction) then) =
      _$SnTransactionCopyWithImpl<$Res, SnTransaction>;
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String remark,
      String amount,
      SnWallet? payer,
      SnWallet? payee,
      int? payerId,
      int? payeeId});

  $SnWalletCopyWith<$Res>? get payer;
  $SnWalletCopyWith<$Res>? get payee;
}

/// @nodoc
class _$SnTransactionCopyWithImpl<$Res, $Val extends SnTransaction>
    implements $SnTransactionCopyWith<$Res> {
  _$SnTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SnTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? remark = null,
    Object? amount = null,
    Object? payer = freezed,
    Object? payee = freezed,
    Object? payerId = freezed,
    Object? payeeId = freezed,
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
      remark: null == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      payer: freezed == payer
          ? _value.payer
          : payer // ignore: cast_nullable_to_non_nullable
              as SnWallet?,
      payee: freezed == payee
          ? _value.payee
          : payee // ignore: cast_nullable_to_non_nullable
              as SnWallet?,
      payerId: freezed == payerId
          ? _value.payerId
          : payerId // ignore: cast_nullable_to_non_nullable
              as int?,
      payeeId: freezed == payeeId
          ? _value.payeeId
          : payeeId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  /// Create a copy of SnTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnWalletCopyWith<$Res>? get payer {
    if (_value.payer == null) {
      return null;
    }

    return $SnWalletCopyWith<$Res>(_value.payer!, (value) {
      return _then(_value.copyWith(payer: value) as $Val);
    });
  }

  /// Create a copy of SnTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SnWalletCopyWith<$Res>? get payee {
    if (_value.payee == null) {
      return null;
    }

    return $SnWalletCopyWith<$Res>(_value.payee!, (value) {
      return _then(_value.copyWith(payee: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SnTransactionImplCopyWith<$Res>
    implements $SnTransactionCopyWith<$Res> {
  factory _$$SnTransactionImplCopyWith(
          _$SnTransactionImpl value, $Res Function(_$SnTransactionImpl) then) =
      __$$SnTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime? deletedAt,
      String remark,
      String amount,
      SnWallet? payer,
      SnWallet? payee,
      int? payerId,
      int? payeeId});

  @override
  $SnWalletCopyWith<$Res>? get payer;
  @override
  $SnWalletCopyWith<$Res>? get payee;
}

/// @nodoc
class __$$SnTransactionImplCopyWithImpl<$Res>
    extends _$SnTransactionCopyWithImpl<$Res, _$SnTransactionImpl>
    implements _$$SnTransactionImplCopyWith<$Res> {
  __$$SnTransactionImplCopyWithImpl(
      _$SnTransactionImpl _value, $Res Function(_$SnTransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SnTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deletedAt = freezed,
    Object? remark = null,
    Object? amount = null,
    Object? payer = freezed,
    Object? payee = freezed,
    Object? payerId = freezed,
    Object? payeeId = freezed,
  }) {
    return _then(_$SnTransactionImpl(
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
      remark: null == remark
          ? _value.remark
          : remark // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      payer: freezed == payer
          ? _value.payer
          : payer // ignore: cast_nullable_to_non_nullable
              as SnWallet?,
      payee: freezed == payee
          ? _value.payee
          : payee // ignore: cast_nullable_to_non_nullable
              as SnWallet?,
      payerId: freezed == payerId
          ? _value.payerId
          : payerId // ignore: cast_nullable_to_non_nullable
              as int?,
      payeeId: freezed == payeeId
          ? _value.payeeId
          : payeeId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SnTransactionImpl implements _SnTransaction {
  const _$SnTransactionImpl(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt,
      required this.remark,
      required this.amount,
      required this.payer,
      required this.payee,
      required this.payerId,
      required this.payeeId});

  factory _$SnTransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SnTransactionImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final String remark;
  @override
  final String amount;
  @override
  final SnWallet? payer;
  @override
  final SnWallet? payee;
  @override
  final int? payerId;
  @override
  final int? payeeId;

  @override
  String toString() {
    return 'SnTransaction(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, remark: $remark, amount: $amount, payer: $payer, payee: $payee, payerId: $payerId, payeeId: $payeeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SnTransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.remark, remark) || other.remark == remark) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.payer, payer) || other.payer == payer) &&
            (identical(other.payee, payee) || other.payee == payee) &&
            (identical(other.payerId, payerId) || other.payerId == payerId) &&
            (identical(other.payeeId, payeeId) || other.payeeId == payeeId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, updatedAt,
      deletedAt, remark, amount, payer, payee, payerId, payeeId);

  /// Create a copy of SnTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SnTransactionImplCopyWith<_$SnTransactionImpl> get copyWith =>
      __$$SnTransactionImplCopyWithImpl<_$SnTransactionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SnTransactionImplToJson(
      this,
    );
  }
}

abstract class _SnTransaction implements SnTransaction {
  const factory _SnTransaction(
      {required final int id,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final DateTime? deletedAt,
      required final String remark,
      required final String amount,
      required final SnWallet? payer,
      required final SnWallet? payee,
      required final int? payerId,
      required final int? payeeId}) = _$SnTransactionImpl;

  factory _SnTransaction.fromJson(Map<String, dynamic> json) =
      _$SnTransactionImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime? get deletedAt;
  @override
  String get remark;
  @override
  String get amount;
  @override
  SnWallet? get payer;
  @override
  SnWallet? get payee;
  @override
  int? get payerId;
  @override
  int? get payeeId;

  /// Create a copy of SnTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SnTransactionImplCopyWith<_$SnTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
