abstract class WalletEvent {}

class FetchWallet extends WalletEvent {
  final String userId;
  FetchWallet(this.userId);
}

class UseWallet extends WalletEvent {
  final double amount;
  UseWallet(this.amount);
}

class RefundWallet extends WalletEvent {
  final double amount;
  RefundWallet(this.amount);
}
