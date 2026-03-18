// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

class RazorpayWeb {
  static void openPayment(
    int amount, {
    required Function() onSuccess,
    required Function(String) onError,
  }) {
    final options = js.JsObject.jsify({
      'key': 'rzp_test_SSO7BmEXoUr4WM',
      'amount': amount,
      'name': 'AD E-Commerce',
      'description': 'Order Payment',
      'prefill': {'contact': '9999999999', 'email': 'test@email.com'},
    });

    // ✅ SUCCESS handler
    options['handler'] = (response) {
      print("WEB PAYMENT SUCCESS");
      onSuccess(); // 🔥 THIS WAS MISSING
    };

    // ❌ FAILURE / CLOSE handler
    options['modal'] = js.JsObject.jsify({
      'ondismiss': () {
        print("WEB PAYMENT FAILED / CLOSED");
        onError("Payment Cancelled"); // 🔥 THIS WAS MISSING
      },
    });

    js.context.callMethod('openRazorpay', [options]);
  }
}
