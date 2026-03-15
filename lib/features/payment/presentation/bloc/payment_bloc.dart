import 'package:ad_e_commerce/features/payment/domain/usecase/make_payment.dart';
import 'package:ad_e_commerce/features/payment/presentation/bloc/payment_event.dart';
import 'package:ad_e_commerce/features/payment/presentation/bloc/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final MakePayment makePayment;
  PaymentBloc({required this.makePayment}) : super(PaymentState()) {
    on<StartPayment>(_onStartPayment);
  }
  Future<void> _onStartPayment(
    StartPayment event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(status: PaymentStatus.loading));
    try {
      await makePayment(event.amount);
      emit(state.copyWith(status: PaymentStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentStatus.failed,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
