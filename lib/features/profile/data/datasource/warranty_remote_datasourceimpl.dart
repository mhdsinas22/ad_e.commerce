import 'package:aerstore/core/utils/app_logger.dart';
import 'package:aerstore/features/profile/data/datasource/warranty_remote_datasource.dart';
import 'package:aerstore/features/profile/data/models/warranty_card_mode.dart';
import 'package:aerstore/features/profile/data/models/warranty_model.dart';
import 'package:aerstore/features/profile/domain/enitites/wallet/warranty.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WarrantyRemoteDatasourceimpl implements WarrantyRemoteDatasource {
  final SupabaseClient supabase;
  WarrantyRemoteDatasourceimpl(this.supabase);
  @override
  Future<WarrantyCardModel> createCard(
    WarrantyCardModel warrantyCardModel,
    String userId,
  ) async {
    try {
      final result =
          await supabase
              .from("warranty_card")
              .select()
              .eq("user_id", userId)
              .maybeSingle();

      if (result == null) {
        final res =
            await supabase
                .from("warranty_card")
                .insert(warrantyCardModel.toJson())
                .select()
                .single();
        return WarrantyCardModel.fromJson(res);
      }

      return WarrantyCardModel.fromJson(result);
    } catch (e) {
      AppLogger.error("CRETA WARRANRTY:_${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<List<WarrantyCardModel>> getWarranties() async {
    try {
      final userId = supabase.auth.currentUser!.id;
      final result = await supabase
          .from("warranty_card")
          .select()
          .eq("user_id", userId);
      return result.map((e) => WarrantyCardModel.fromJson(e)).toList();
    } catch (e) {
      AppLogger.error("GET WARRANTY:_${e.toString()}");
      return [];
    }
  }

  @override
  Future<void> createWarranty(WarrantyModel warrantyModel) async {
    try {
      await supabase.from("warranties").insert(warrantyModel.toJson());
    } catch (e) {
      AppLogger.error("CRETA WARRANRTY:_${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<WarrantyCardModel?> getWarrantyCardByUser(String userId) async {
    try {
      final result =
          await supabase
              .from("warranty_card")
              .select()
              .eq("user_id", userId)
              .maybeSingle();

      if (result == null) return null;

      return WarrantyCardModel.fromJson(result);
    } catch (e) {
      AppLogger.error("GET WARRANTY:_${e.toString()}");
      return null;
    }
  }

  @override
  Future<List<Warranty>> getWarrantiesByCardId(String cardId) async {
    final result = await supabase
        .from("warranties")
        .select()
        .eq("warranty_card_id", cardId);

    return result.map((e) => WarrantyModel.fromJson(e)).toList();
  }

  @override
  Future<({WarrantyCardModel card, List<WarrantyModel> warranties})?>
  getWarrantyData(String userId) async {
    try {
      final res =
          await supabase
              .from("warranty_card")
              .select("*, warranties(*)")
              .eq("user_id", userId)
              .maybeSingle();

      if (res == null) return null;

      final card = WarrantyCardModel.fromJson(res);
      final warrantiesList =
          (res['warranties'] as List)
              .map((e) => WarrantyModel.fromJson(e))
              .toList();

      return (card: card, warranties: warrantiesList);
    } catch (e) {
      AppLogger.error("GET WARRANTY DATA:_${e.toString()}");
      return null; // Return null instead of empty list for consistency
    }
  }
}
