import 'package:ad_e_commerce/core/utils/app_logger.dart';
import 'package:ad_e_commerce/features/profile/data/datasource/warranty_remote_datasource.dart';
import 'package:ad_e_commerce/features/profile/data/models/warranty_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WarrantyRemoteDatasourceimpl implements WarrantyRemoteDatasource {
  final SupabaseClient supabase;
  WarrantyRemoteDatasourceimpl(this.supabase);
  @override
  Future<void> createWarranty(WarrantyModel warrantymodel) async {
    try {
      await supabase.from("warranties").insert(warrantymodel.toJson());
    } catch (e) {
      AppLogger.error("CREATE WARRANTY ERROR:-${e.toString()}");
    }
  }

  @override
  Future<List<WarrantyModel>> getWarranties(String userId) async {
    try {
      final result = await supabase
          .from("warranties")
          .select()
          .eq("user_id", userId);
      return result.map((e) => WarrantyModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }
}
