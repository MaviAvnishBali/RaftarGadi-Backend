// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WalletTransaction _$WalletTransactionFromJson(Map<String, dynamic> json) =>
    _WalletTransaction(
      id: json['id'] as String,
      type: $enumDecode(_$WalletTransactionTypeEnumMap, json['type']),
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      bookingId: json['bookingId'] as String?,
    );

Map<String, dynamic> _$WalletTransactionToJson(_WalletTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$WalletTransactionTypeEnumMap[instance.type]!,
      'amount': instance.amount,
      'description': instance.description,
      'timestamp': instance.timestamp.toIso8601String(),
      'bookingId': instance.bookingId,
    };

const _$WalletTransactionTypeEnumMap = {
  WalletTransactionType.credit: 'credit',
  WalletTransactionType.debit: 'debit',
  WalletTransactionType.refund: 'refund',
  WalletTransactionType.cashback: 'cashback',
};

_Wallet _$WalletFromJson(Map<String, dynamic> json) => _Wallet(
  ownerId: json['ownerId'] as String,
  balance: (json['balance'] as num?)?.toDouble() ?? 0,
  currency: json['currency'] as String? ?? 'INR',
  transactions:
      (json['transactions'] as List<dynamic>?)
          ?.map((e) => WalletTransaction.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <WalletTransaction>[],
);

Map<String, dynamic> _$WalletToJson(_Wallet instance) => <String, dynamic>{
  'ownerId': instance.ownerId,
  'balance': instance.balance,
  'currency': instance.currency,
  'transactions': instance.transactions.map((e) => e.toJson()).toList(),
};
