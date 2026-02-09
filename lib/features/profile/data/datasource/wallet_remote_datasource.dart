import 'package:ad_e_commerce/features/profile/data/models/reward_points_model.dart';
import 'package:ad_e_commerce/features/profile/data/models/wallet_model.dart';

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
}
