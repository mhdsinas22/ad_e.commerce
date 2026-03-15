import 'package:ad_e_commerce/features/payment/data/datasource/razorpay_datasource.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayDatasourceImpl implements RazorpayDatasource {
  final Razorpay _razorpay = Razorpay();

  @override
  void openPayment({
    required int amount,
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onError,
  }) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onError);
    var options = {
      'key': 'rzp_test_xxxxxxxxx',
      'amount': amount,
      'name': 'AD E-Commerce',
      'description': 'Product Payment',
      'prefill': {'contact': '9999999999', 'email': 'test@email.com'},
    };
    _razorpay.open(options);
  }
}
