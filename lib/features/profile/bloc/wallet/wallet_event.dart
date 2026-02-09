abstract class WalletEvent {}

class LoadWallet extends WalletEvent {}

class UseWallet extends WalletEvent {
  final double amount;
  UseWallet(this.amount);
}

class RefundWallet extends WalletEvent {
  final double amount;
  RefundWallet(this.amount);
}
