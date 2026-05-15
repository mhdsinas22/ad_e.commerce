import 'package:aerstore/core/utils/app_logger.dart';
import 'package:aerstore/features/checkout/data/datasource/address_remote_datasource.dart';
import 'package:aerstore/features/checkout/data/models/address_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddressRemoteDatasoureimpl implements AddressRemoteDatasource {
  final SupabaseClient supabase;
  AddressRemoteDatasoureimpl(this.supabase);
  @override
  Future<List<AddressModel>> getAddresses() async {
    try {
      final userId = supabase.auth.currentUser!.id;

      final response = await supabase
          .from("address")
          .select("*")
          .eq("user_id", userId);
      return response.map((e) => AddressModel.fromJson(e)).toList();
    } catch (e) {
      AppLogger.error("get AddesEEROR:_${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> addAddress(AddressModel address) async {
    try {
      await supabase.from("address").insert(address.toJson());
    } catch (e) {
      AppLogger.error("Add ADDress:-${e.toString()}");
    }
  }

  @override
  Future<void> updateAddress(AddressModel address) async {
    try {
      await supabase
          .from("address")
          .update(address.toJson())
          .eq("id", address.id!);
    } catch (e) {
      AppLogger.error("Update Address:-${e.toString()}");
    }
  }

  @override
  Future<void> deleteAddress(String id) async {
    try {
      await supabase.from("address").delete().eq("id", id);
    } catch (e) {
      AppLogger.error("Delete Address:-${e.toString()}");
    }
  }
}
