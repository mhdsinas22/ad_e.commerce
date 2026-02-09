class WalletTransaction {
  final String? id;
  final String walletId;
  final String type;
  final double amount;
  final String reason;
  WalletTransaction({
    this.id,
    required this.amount,
    required this.reason,
    required this.type,
    required this.walletId,
  });
}
