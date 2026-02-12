import 'package:ad_e_commerce/core/utils/app_logger.dart';
import 'package:ad_e_commerce/features/profile/data/datasource/wallet_remote_datasource.dart';
import 'package:ad_e_commerce/features/profile/data/models/reward_points_model.dart';
import 'package:ad_e_commerce/features/profile/data/models/wallet_model.dart';
import 'package:ad_e_commerce/features/profile/data/models/wallet_transaction_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WalletRemoteDatasourceImpl implements WalletRemoteDataSource {
  final SupabaseClient supbase;
  WalletRemoteDatasourceImpl(this.supbase);
  @override
  Future<WalletModel> getWallet(String userId) async {
    try {
      final res =
          await supbase
              .from("wallets")
              .select()
              .eq("user_id", userId)
              .maybeSingle();
      if (res == null) {
        throw Exception("Wallet not found");
      }
      return WalletModel.fromJson(res);
    } catch (e) {
      AppLogger.error("GET WALLET ERROR: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> createWallet(String userId) async {
    try {
      final user = supbase.auth.currentUser!.id;
      await supbase.from("wallets").upsert({
        "user_id": user,
        "balance": 0,
      }, onConflict: "user_id");
      await supbase.from("reward_points").upsert({
        "user_id": user,
        "points": 0,
      }, onConflict: "user_id");
    } catch (e) {
      AppLogger.error("CREATE WALLET ERROR: ${e.toString()}");
    }
  }

  @override
  Future<void> createWalletForUser(String userId) async {
    try {
      await supbase.rpc(
        "create_wallet_for_user",
        params: {"p_user_id": userId},
      );
    } catch (e) {
      AppLogger.error("CREATE WALLET FOR USER ERROR: ${e.toString()}");
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
              .maybeSingle();
      if (response == null) {
        await createWallet(userId);
        return RewardPointsModel(userId: userId, points: 0);
      }
      return RewardPointsModel.fromJson(response);
    } catch (e) {
      AppLogger.error("GET REWARD POINTS ERROR: ${e.toString()}");
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
      AppLogger.error("ADD REWARD POINTS ERROR: ${e.toString()}");
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

  @override
  Future<void> addRewardAsWallet(String userid, int points) async {
    try {
      await supbase.rpc(
        "add_reward_as_wallet",
        params: {"p_user_id": userid, "p_points": points},
      );
    } catch (e) {
      AppLogger.error("ADD REWARD AS WALLET ERROR: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<List<WalletTransactionModel>> getTransactions(String walletid) async {
    try {
      final res = await supbase
          .from("wallet_transactions")
          .select()
          .eq("wallet_id", walletid)
          .order("created_at", ascending: false);
      return res.map((e) => WalletTransactionModel.fromJson(e)).toList();
    } catch (e) {
      AppLogger.error("GET TRANSACTIONS ERROR: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> debitWalletForOrder({
    required String userId,
    required double amount,
  }) async {
    try {
      await supbase.rpc(
        "debit_wallet_for_order",
        params: {"p_user_id": userId, "p_amount": amount},
      );
    } catch (e) {
      AppLogger.error("DEBIT WALLET FOR ORDER ERROR: $e");
    }
  }
}
