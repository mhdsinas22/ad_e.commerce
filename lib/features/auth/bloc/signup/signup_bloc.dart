import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState()) {
    on<SignupPhoneChanged>(_onPhoneChanged);
    on<SignupSendOtp>(_onSendOtp);
  }

  void _onPhoneChanged(SignupPhoneChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  Future<void> _onSendOtp(
    SignupSendOtp event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(status: SignupStatus.loading));
    try {
      // TODO: Integrate actual AuthRepository here
      await Future.delayed(const Duration(seconds: 2)); // Mock API delay

      // Basic validation
      if (event.phoneNumber.length >= 10) {
        emit(state.copyWith(status: SignupStatus.otpSent));
      } else {
        emit(
          state.copyWith(
            status: SignupStatus.failure,
            errorMessage: 'Invalid phone number',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: SignupStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
