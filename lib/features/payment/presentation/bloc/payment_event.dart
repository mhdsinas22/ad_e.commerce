abstract class PaymentEvent {}

class StartPayment extends PaymentEvent {
  final int amount;
  StartPayment({required this.amount});
}
