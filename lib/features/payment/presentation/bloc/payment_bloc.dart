import 'package:aerstore/core/utils/app_logger.dart';
import 'package:aerstore/features/payment/domain/usecase/make_payment.dart';
import 'package:aerstore/features/payment/presentation/bloc/payment_event.dart';
import 'package:aerstore/features/payment/presentation/bloc/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final MakePayment makePayment;
  PaymentBloc({required this.makePayment}) : super(PaymentState()) {
    on<StartPayment>(_onStartPayment);
    on<PaymentSuccessEvent>(_onPaymentSuccess);
    on<PaymentFailureEvent>(_onPaymentFailure);
  }
  Future<void> _onStartPayment(
    StartPayment event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(status: PaymentStatus.loading));
    try {
      AppLogger.info("Start Payment:- ${event.amount}");
      await makePayment(
        event.amount,
        () {
          add(PaymentSuccessEvent());
        },
        (error) {
          add(PaymentFailureEvent(error));
        },
      );
    } catch (e) {
      AppLogger.error("Start paymetn error:- ${e.toString()}");
      emit(
        state.copyWith(
          status: PaymentStatus.failed,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onPaymentSuccess(
    PaymentSuccessEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWith(status: PaymentStatus.success));
  }

  Future<void> _onPaymentFailure(
    PaymentFailureEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(
      state.copyWith(status: PaymentStatus.failed, errorMessage: event.message),
    );
  }
}
