import 'package:ad_e_commerce/features/profile/domain/enitites/wallet/reward_points.dart';
import 'package:ad_e_commerce/features/profile/domain/enitites/wallet/wallet.dart';
import 'package:ad_e_commerce/features/profile/domain/enitites/wallet/wallet_transaction.dart';

abstract class WalletRepo {
  Future<Wallet> getWallet(String userId);
  Future<void> createWallet(String userId);
  Future<void> createwalletforUser(String userId);
  Future<RewardPoints> getRewardPoints(String userId);
  Future<void> addRewardPoints(String userId, int points);
  Future<List<WalletTransaction>> getTransactions(String walletid);
}
