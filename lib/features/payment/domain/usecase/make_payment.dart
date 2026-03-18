import 'package:ad_e_commerce/features/payment/domain/repository/payment_repository.dart';

class MakePayment {
  final PaymentRepository repository;
  MakePayment(this.repository);
  Future<void> call(
    int amount,
    Function() onSuccess,
    Function(String) onError,
  ) {
    try {
      print("USE payment CASE working");
      return repository.pay(amount, onSuccess, onError);
    } catch (e) {
      print("PAynet ise case error:-${e.toString()}");
      return Future.error(e);
    }
  }
}
