// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:aerstore/core/utils/app_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RazorpayWeb {
  static void openPayment(
    int amount, {
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    final user = Supabase.instance.client;
    final currentUser = user.auth.currentUser;
    if (currentUser == null) {
      throw Exception("User not logged in");
    }
    final userProfile =
        await user
            .from('profiles')
            .select()
            .eq('user_id', currentUser.id)
            .single();
    final options = js.JsObject.jsify({
      'key': 'rzp_live_SX2RgssiDfnKDR',
      'amount': amount,
      'name': 'Aer Store',
      'description': 'Order Payment',
      'prefill': {
        'contact': '${userProfile['phone'] ?? ""}',
        'email': '${userProfile['email'] ?? ""}',
      },
    });

    // ✅ SUCCESS handler
    options['handler'] = (response) {
      AppLogger.info("WEB PAYMENT SUCCESS");
      onSuccess(); // 🔥 THIS WAS MISSING
    };

    // ❌ FAILURE / CLOSE handler
    options['modal'] = js.JsObject.jsify({
      'ondismiss': () {
        AppLogger.error("WEB PAYMENT FAILED / CLOSED");
        onError("Payment Cancelled"); // 🔥 THIS WAS MISSING
      },
    });

    js.context.callMethod('openRazorpay', [options]);
  }
}
