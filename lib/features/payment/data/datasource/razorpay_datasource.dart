import 'package:razorpay_flutter/razorpay_flutter.dart';

abstract class RazorpayDatasource {
  void openPayment({
    required int amount,
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onError,
  });
}
