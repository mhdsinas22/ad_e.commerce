class Wallet {
  final String? id;
  final String userId;
  final double balance;
  final String walletNumber;

  Wallet({
    this.id,
    required this.balance,
    required this.userId,
    required this.walletNumber,
  });
}
