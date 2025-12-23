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

      // 🔎 If username, fetch email
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

      // 🔐 Login
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        return 'INVALID_CREDENTIALS';
      }

      // 🚨 EMAIL VERIFICATION CHECK
      // if (user.emailConfirmedAt == null) {
      //   // Optional: logout immediately
      //   await supabaseClient.auth.signOut();

      //   return 'EMAIL_NOT_VERIFIED';
      // }

      // ✅ All good
      return null;
    } on AuthException catch (e) {
      if (e.code == 'email_not_confirmed') {
        return 'EMAIL_NOT_VERIFIED';
      }

      if (e.message.contains("Invalid login credentials")) {
        return "INVALID_CREDENTIALS";
      }
      return 'UNKNOWN_ERROR:-${e.toString()}';
    }
  }

  Future<AuthResponse> signupwithEmail({
    required String email,
    required String password,
  }) async {
    final response = await Supabase.instance.client.auth.signUp(
      password: password,
      email: email,
    );
    return response;
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

  Future<void> reloadSession() async {
    await supabaseClient.auth.refreshSession();
  }

  bool get isEmailVerified {
    final user = supabaseClient.auth.currentUser;
    return user?.emailConfirmedAt != null;
  }

  Future<void> signOut() async {
    await supabaseClient.auth.signOut();
  }

  User? get currentUser => supabaseClient.auth.currentUser;

  Future<void> resetPasswordForEmail(String email) async {
    try {
      await supabaseClient.auth.resetPasswordForEmail(
        email,
        redirectTo: 'yourapp://reset-password',
      );
    } on AuthException catch (e) {
      throw e.message;
    } catch (e) {
      throw 'An unexpected error occurred';
    }
  }
}

bool isEmail(String value) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
}
