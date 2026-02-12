import 'package:ad_e_commerce/core/utils/app_logger.dart';
import 'package:ad_e_commerce/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  final SupabaseClient client;
  UserRepository(this.client);
  Future<void> createUser(UserModel user) async {
    try {
      await client.from("profiles").insert(user.toJson());
    } on PostgrestException catch (e) {
      throw Exception(e.message);
    } catch (_) {
      throw Exception("Unknown error");
    }
  }

  Future<void> createUserprofile(UserModel user) async {
    try {
      await client.rpc(
        'create_user_profile',
        params: {
          'p_user_id': user.userId,
          'p_phone': user.phone,
          'p_email': user.email,
          'p_username': user.username,
          'p_image_url': user.imageUrl,
        },
      );
    } catch (e) {
      AppLogger.error("CREATE USER PROFILE ERROR:-${e.toString()}");
    }
  }
}
