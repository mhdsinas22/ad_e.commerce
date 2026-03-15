import 'package:ad_e_commerce/features/payment/domain/repository/payment_repository.dart';

class MakePayment {
  final PaymentRepository repository;
  MakePayment(this.repository);
  Future<void> call(int amount) {
    return repository.pay(amount);
  }
}
