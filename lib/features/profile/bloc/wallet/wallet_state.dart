import 'package:ad_e_commerce/features/profile/domain/enitites/wallet/wallet_transaction.dart';

enum WalletStatus { initial, loading, success, failure }

class WalletState {
  final WalletStatus status;
  final double balance;
  final String walletNumber;
  final String? error;
  final List<WalletTransaction> transactions;

  WalletState({
    this.status = WalletStatus.initial,
    this.walletNumber = "",
    this.balance = 0,
    this.error,
    this.transactions = const [],
  });

  WalletState copyWith({
    WalletStatus? status,
    double? balance,
    String? error,
    List<WalletTransaction>? transactions,
    String? walletNumber,
  }) {
    return WalletState(
      status: status ?? this.status,
      balance: balance ?? this.balance,
      error: error,
      transactions: transactions ?? this.transactions,
      walletNumber: walletNumber ?? this.walletNumber,
    );
  }
}
