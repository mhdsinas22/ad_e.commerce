import 'package:ad_e_commerce/features/profile/data/datasource/wallet_remote_datasource.dart';
import 'package:ad_e_commerce/features/profile/data/models/reward_points_model.dart';
import 'package:ad_e_commerce/features/profile/data/models/wallet_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WalletRemoteDatasourceImpl implements WalletRemoteDataSource {
  final SupabaseClient supbase;
  WalletRemoteDatasourceImpl(this.supbase);
  @override
  Future<WalletModel> getWallet(String userId) async {
    try {
      final res =
          await supbase.from("wallets").select().eq("user_id", userId).single();
      return WalletModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> createWallet(String userId) async {
    try {
      await supbase.from("wallets").insert({"user_id": userId, "balance": 0});
      await supbase.from("reward_points").insert({
        "user_id": userId,
        "points": 0,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<RewardPointsModel> getRewardPoints(String userId) async {
    try {
      final response =
          await supbase
              .from("reward_points")
              .select()
              .eq("user_id", userId)
              .single();
      return RewardPointsModel.fromJson(response);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> addRewardPoints(String userId, int points) async {
    try {
      await supbase.rpc(
        "add_reward_points",
        params: {"p_user_id": userId, "p_points": points},
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> debitWallet({
    required String userId,
    required double amount,
    required String reason,
  }) async {
    await supbase.rpc(
      'debit_wallet',
      params: {'p_amount': amount, 'p_reason': reason, 'p_user_id': userId},
    );
  }
}
