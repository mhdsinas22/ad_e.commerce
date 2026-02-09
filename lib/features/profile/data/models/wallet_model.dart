import 'package:ad_e_commerce/features/profile/domain/enitites/wallet/wallet.dart';

class WalletModel extends Wallet {
  WalletModel({super.id, required super.userId, required super.balance});

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'],
      userId: json['user_id'],
      balance: (json['balance'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'user_id': userId, 'balance': balance};
  }
}
