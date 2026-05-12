import 'package:aerstore/core/utils/app_logger.dart';
import 'package:aerstore/features/payment/domain/repository/payment_repository.dart';

class MakePayment {
  final PaymentRepository repository;
  MakePayment(this.repository);
  Future<void> call(
    int amount,
    Function() onSuccess,
    Function(String) onError,
  ) {
    try {
      AppLogger.info("USE payment CASE working");
      return repository.pay(amount, onSuccess, onError);
    } catch (e) {
      AppLogger.error("PAynet ise case error:-${e.toString()}");
      return Future.error(e);
    }
  }
}
