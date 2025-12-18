import 'package:ad_e_commerce/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  final SupabaseClient client;
  UserRepository(this.client);
  Future<void> createUser(UserModel user) async {
    try {
      await client.from("users").insert(user.toJson());
    } on PostgrestException catch (e) {
      throw Exception(e.message);
    } catch (_) {
      throw Exception("Unknown error");
    }
  }
}
