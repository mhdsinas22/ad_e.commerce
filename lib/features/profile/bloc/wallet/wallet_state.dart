enum WalletStatus { initial, loading, success, failure }

class WalletState {
  final WalletStatus status;
  final double balance;
  final String? error;

  WalletState({required this.status, this.balance = 0, this.error});

  WalletState copyWith({WalletStatus? status, double? balance, String? error}) {
    return WalletState(
      status: status ?? this.status,
      balance: balance ?? this.balance,
      error: error,
    );
  }
}
