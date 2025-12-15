import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(const OtpState()) {
    on<OtpCodeChanged>(_onCodeChanged);
    on<OtpVerify>(_onVerify);
    on<OtpResend>(_onResend);
  }

  void _onCodeChanged(OtpCodeChanged event, Emitter<OtpState> emit) {
    emit(state.copyWith(otpCode: event.otpCode));
  }

  Future<void> _onVerify(OtpVerify event, Emitter<OtpState> emit) async {
    emit(state.copyWith(status: OtpStatus.verifying));
    try {
      // TODO: Integrate actual AuthRepository here
      await Future.delayed(const Duration(seconds: 2)); // Mock API delay

      if (state.otpCode.length == 6) {
        emit(state.copyWith(status: OtpStatus.verified));
      } else {
        emit(
          state.copyWith(status: OtpStatus.failed, errorMessage: 'Invalid OTP'),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: OtpStatus.failed, errorMessage: e.toString()),
      );
    }
  }

  void _onResend(OtpResend event, Emitter<OtpState> emit) {
    // Logic to resend OTP
    // For UI, we can reset timer
    emit(state.copyWith(timerSeconds: 30));
  }
}
