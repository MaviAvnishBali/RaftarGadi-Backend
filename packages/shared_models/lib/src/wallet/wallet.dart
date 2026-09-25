import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet.freezed.dart';
part 'wallet.g.dart';

/// Direction/purpose of a wallet movement.
enum WalletTransactionType { credit, debit, refund, cashback }

/// A single ledger entry in a wallet.
@freezed
abstract class WalletTransaction with _$WalletTransaction {
  const factory WalletTransaction({
    required String id,
    required WalletTransactionType type,
    required double amount,
    required String description,
    required DateTime timestamp,
    String? bookingId,
  }) = _WalletTransaction;

  factory WalletTransaction.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionFromJson(json);
}

/// A customer's (or driver's) wallet: current balance and its ledger.
@freezed
abstract class Wallet with _$Wallet {
  const factory Wallet({
    required String ownerId,
    @Default(0) double balance,
    @Default('INR') String currency,
    @Default(<WalletTransaction>[]) List<WalletTransaction> transactions,
  }) = _Wallet;

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
}
