import 'package:ad_e_commerce/features/profile/data/models/reward_points_model.dart';
import 'package:ad_e_commerce/features/profile/data/models/wallet_model.dart';
import 'package:ad_e_commerce/features/profile/data/models/wallet_transaction_model.dart';

abstract class WalletRemoteDataSource {
  Future<WalletModel> getWallet(String userId);
  Future<void> createWallet(String userId);
  Future<RewardPointsModel> getRewardPoints(String userId);
  Future<void> addRewardPoints(String userId, int points);
  Future<void> debitWallet({
    required String userId,
    required double amount,
    required String reason,
  });
  Future<void> createWalletForUser(String userId);
  Future<void> addRewardAsWallet(String userid, int points);
  Future<List<WalletTransactionModel>> getTransactions(String userid);
  Future<void> debitWalletForOrder({
    required String userId,
    required double amount,
  });
  Future<String> getUserName(String userId);
}
