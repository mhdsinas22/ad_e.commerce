import 'package:ad_e_commerce/features/profile/data/datasource/wallet_remote_datasource.dart';

import 'package:ad_e_commerce/features/profile/domain/enitites/wallet/reward_points.dart';
import 'package:ad_e_commerce/features/profile/domain/enitites/wallet/wallet.dart';
import 'package:ad_e_commerce/features/profile/domain/repositories/wallet_repo.dart';

class WalletRepoImpl implements WalletRepo {
  final WalletRemoteDataSource remote;

  WalletRepoImpl(this.remote);

  @override
  Future<Wallet> getWallet(String userId) {
    return remote.getWallet(userId);
  }

  @override
  Future<void> createWallet(String userId) {
    return remote.createWallet(userId);
  }

  @override
  Future<RewardPoints> getRewardPoints(String userId) {
    return remote.getRewardPoints(userId);
  }

  @override
  Future<void> addRewardPoints(String userId, int points) {
    return remote.addRewardPoints(userId, points);
  }
}
