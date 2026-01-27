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
      print("CRETA WARRANRTY:_${e.toString()}");
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
      print("GET WARRANTY:_${e.toString()}");
      return [];
    }
  }
}
