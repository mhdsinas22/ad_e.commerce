import 'package:ad_e_commerce/features/payment/data/datasource/razorpay_datasource.dart';
import 'package:ad_e_commerce/features/payment/helper/razorpay_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RazorpayDatasourceImpl implements RazorpayDatasource {
  final Razorpay _razorpay = Razorpay();

  @override
  void openPayment({
    required int amount,
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onError,
  }) async {
    _razorpay.clear(); // 🔥 IMPORTANT

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (response) {
      print("SUCCESS CALLBACK");
      onSuccess(response);
    });

    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (response) {
      print("ERROR CALLBACK");
      onError(response);
    });

    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (response) {
      print("WALLET SELECTED");
    });
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
    var options = {
      'key': 'rzp_live_SX2RgssiDfnKDR',
      'amount': amount, // must be in paisa
      'name': 'Aer Store',
      'description': 'Order Payment',
      'prefill': {
        'contact': '${userProfile['phone']}',
        'email': '${userProfile['email']}',
      },
      'theme': {'color': '#3399cc'},
    };

    try {
      print("OPENING RAZORPAY");
      if (kIsWeb) {
        RazorpayWeb.openPayment(
          amount,
          onSuccess: () {
            onSuccess(
              PaymentSuccessResponse(
                "web_payment_id",
                "web_order_id",
                "web_signature",
                null,
              ),
            );
          },
          onError: (err) {
            onError(PaymentFailureResponse(0, err, null));
          },
        );
      } else {
        _razorpay.open(options);
      }
    } catch (e) {
      print("RAZORPAY OPEN ERROR: $e");
    }
  }
}
