abstract class PaymentRepository {
  Future<void> pay(int amount, Function() onSuccess, Function(String) onError);
}
