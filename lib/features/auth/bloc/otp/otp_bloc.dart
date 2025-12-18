// ignore_for_file: unused_element

import 'dart:async';

import 'package:ad_e_commerce/features/auth/bloc/otp/otp_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/otp/otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final SupabaseClient supabase;
  final String phone;
  Timer? _timer;
  OtpBloc({required this.phone})
    : supabase = Supabase.instance.client,
      super(const OtpState()) {
    // on<OtpTimerTicked>(_onTimerTicked);
    _startTimer();
    // OTP input Change
    on<OtpCodeChanged>((event, emit) {
      emit(state.copyWith(otpCode: event.code));
    });
    // VERIFY OTP
    on<OtpVerify>(_onVerifyOtp);
    // RESEND OTP
    on<ResendOtp>(_onResendOtp);
    // Start timerr
    _startTimer();
  }
  // VERIFY OTP LOGIC
  Future<void> _onVerifyOtp(OtpVerify event, Emitter<OtpState> emit) async {
    if (state.otpCode.length != 6) {
      emit(
        state.copyWith(
          status: OtpStatus.failed,
          errorMessage: 'Enter valid 6 digit OTP',
        ),
      );
      return;
    }
    emit(state.copyWith(status: OtpStatus.verifying));
    try {
      await supabase.auth.verifyOTP(
        type: OtpType.sms,
        token: state.otpCode,
        phone: "+91$phone",
      );
      emit(state.copyWith(status: OtpStatus.verified));
    } catch (e) {
      emit(
        state.copyWith(status: OtpStatus.failed, errorMessage: "Invalid Otp"),
      );
    }
  }

  // RESEND  OTP LOGIC
  Future<void> _onResendOtp(ResendOtp event, Emitter<OtpState> emit) async {
    try {
      await supabase.auth.signInWithOtp(phone: "+91$phone");
      emit(state.copyWith(timerSeconds: 30, status: OtpStatus.initial));
      _startTimer(); // restart timer properly
    } catch (e) {
      emit(
        state.copyWith(
          status: OtpStatus.failed,
          errorMessage: 'Failed to resend OTP',
        ),
      );
    }
  }

  // TIMER LOGIC
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      add(OtpTimerTicked());
    });
  }

  Future<void> _stoptimer() {
    _timer?.cancel();
    return super.close();
  }

  void _onTimerTicked(OtpTimerTicked event, Emitter<OtpState> emit) {
    if (state.timerSeconds == 0) {
      _timer?.cancel();
    } else {
      emit(state.copyWith(timerSeconds: state.timerSeconds - 1));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
