enum PaymentStatus { initial, loading, success, failed }

class PaymentState {
  final PaymentStatus status;
  final String? errorMessage;
  PaymentState({this.status = PaymentStatus.initial, this.errorMessage});
  PaymentState copyWith({PaymentStatus? status, String? errorMessage}) {
    return PaymentState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
