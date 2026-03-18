class RazorpayWeb {
  static void openPayment(
    int amount, {
    required Function() onSuccess,
    required Function(String) onError,
  }) {
    throw UnsupportedError("Web only");
  }
}
