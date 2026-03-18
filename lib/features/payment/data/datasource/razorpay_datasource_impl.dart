import 'package:ad_e_commerce/features/payment/data/datasource/razorpay_datasource.dart';
import 'package:ad_e_commerce/features/payment/helper/razorpay_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayDatasourceImpl implements RazorpayDatasource {
  final Razorpay _razorpay = Razorpay();

  @override
  void openPayment({
    required int amount,
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onError,
  }) {
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

    var options = {
      'key': 'rzp_test_SSO7BmEXoUr4WM',
      'amount': amount, // must be in paisa
      'name': 'AD E-Commerce',
      'description': 'Order Payment',
      'prefill': {'contact': '9999999999', 'email': 'test@email.com'},
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
