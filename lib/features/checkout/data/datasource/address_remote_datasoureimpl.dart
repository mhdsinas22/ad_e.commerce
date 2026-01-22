import 'package:ad_e_commerce/features/checkout/data/datasource/address_remote_datasource.dart';
import 'package:ad_e_commerce/features/checkout/data/models/address_model.dart';
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
      print("get AddesEEROR:_${e.toString()}");
      return [];
    }
  }

  @override
  Future<void> addAddress(AddressModel address) async {
    try {
      await supabase.from("address").insert(address.toJson());
    } catch (e) {
      print("Add ADDress:-${e.toString()}");
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
      print("Update Address:-${e.toString()}");
    }
  }

  @override
  Future<void> deleteAddress(String id) async {
    try {
      await supabase.from("address").delete().eq("id", id);
    } catch (e) {
      print("Delete Address:-${e.toString()}");
    }
  }
}
