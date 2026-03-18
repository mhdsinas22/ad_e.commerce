abstract class PaymentEvent {}

class StartPayment extends PaymentEvent {
  final int amount;
  StartPayment({required this.amount});
}

class PaymentSuccessEvent extends PaymentEvent {}

class PaymentFailureEvent extends PaymentEvent {
  final String message;
  PaymentFailureEvent(this.message);
}
