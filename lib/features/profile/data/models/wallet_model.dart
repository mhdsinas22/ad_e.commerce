import 'package:aerstore/features/profile/domain/enitites/wallet/wallet.dart';

class WalletModel extends Wallet {
  WalletModel({
    super.id,
    required super.userId,
    required super.balance,
    required super.walletNumber,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'],
      userId: json['user_id'],
      balance: (json['balance'] as num).toDouble(),
      walletNumber: json["wallet_number"] ?? "*******0000",
    );
  }

  Map<String, dynamic> toJson() {
    return {'user_id': userId, 'balance': balance};
  }
}
