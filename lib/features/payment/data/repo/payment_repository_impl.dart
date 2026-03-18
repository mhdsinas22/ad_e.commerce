import 'package:ad_e_commerce/core/utils/app_logger.dart';
import 'package:ad_e_commerce/features/payment/data/datasource/razorpay_datasource.dart';
import 'package:ad_e_commerce/features/payment/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final RazorpayDatasource datasource;
  PaymentRepositoryImpl({required this.datasource});
  @override
  Future<void> pay(
    int amount,
    Function() onSuccess,
    Function(String) onError,
  ) async {
    try {
      datasource.openPayment(
        amount: amount,
        onSuccess: (response) {
          onSuccess();
        },
        onError: (err) {
          onError(err.message ?? "Payment Failed");
        },
      );
    } catch (e) {
      AppLogger.error("REPO ERROR PAYMENR:- ${e.toString()}");
    }
  }
}
