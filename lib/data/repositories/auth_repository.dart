import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient supabaseClient;
  AuthRepository(this.supabaseClient);
  Future<String?> login({
    required String emailorUsername,
    required String password,
  }) async {
    try {
      String email = emailorUsername;
      if (!isEmail(emailorUsername)) {
        final res =
            await supabaseClient
                .from("users")
                .select("email")
                .eq("username", emailorUsername)
                .maybeSingle();
        if (res == null) {
          return 'ACCOUNT_NOT_FOUND';
        }
        email = res["email"];
      }
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      // ignore: unnecessary_null_comparison
      if (response == null) {
        return 'INVALID_CREDENTIALS';
      }
      return null;
    } on AuthException catch (e) {
      if (e.message.contains("Invalid login credentials")) {
        return "INVALID_CREDENTIALS";
      }
      return 'UNKNOWN_ERROR:-${e.toString()}';
    }
  }

  Future<void> updateEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final user = supabaseClient.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    await supabaseClient.auth.updateUser(
      UserAttributes(email: email, password: password),
    );
  }
}

bool isEmail(String value) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
}
