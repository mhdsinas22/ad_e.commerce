import 'package:ad_e_commerce/features/profile/domain/enitites/wallet/wallet_transaction.dart';

class WalletTransactionModel extends WalletTransaction {
  WalletTransactionModel({
    super.id,
    required super.walletId,
    required super.type,
    required super.amount,
    required super.reason,
  });

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionModel(
      id: json['id'],
      walletId: json['wallet_id'],
      type: json['type'],
      amount: (json['amount'] as num).toDouble(),
      reason: json['reason'],
    );
  }
  factory WalletTransactionModel.fromEntity(WalletTransaction entity) {
    return WalletTransactionModel(
      id: entity.id,
      walletId: entity.walletId,
      amount: entity.amount,
      type: entity.type,
      reason: entity.reason,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'wallet_id': walletId,
      'type': type,
      'amount': amount,
      'reason': reason,
    };
  }
}
