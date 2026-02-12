// ignore_for_file: unused_element
import 'dart:async';
import 'package:ad_e_commerce/core/utils/app_logger.dart';
import 'package:ad_e_commerce/features/auth/bloc/otp/otp_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/otp/otp_state.dart';
import 'package:ad_e_commerce/features/profile/data/datasource/wallet_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final SupabaseClient supabase;
  final WalletRemoteDataSource walletRemoteDataSource;
  final String phone;
  final String name;
  Timer? _timer;
  OtpBloc({
    required this.phone,
    required this.walletRemoteDataSource,
    required this.name,
  }) : supabase = Supabase.instance.client,
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
      final res = await supabase.auth.verifyOTP(
        type: OtpType.sms,
        token: state.otpCode,
        phone: "+91$phone",
      );
      if (res.session != null) {
        final user = res.user;
        // 1.Profile Check
        final existingProfile =
            await supabase
                .from('profiles')
                .select('user_id')
                .eq('user_id', user!.id)
                .maybeSingle();
        AppLogger.info("Existing Profile: $existingProfile");
        if (existingProfile == null) {
          await supabase.from('profiles').insert({
            'user_id': user.id,
            'phone': phone, // already +91 format
            "username": name,
          }).maybeSingle();
          // 2. Wallet Check
          await walletRemoteDataSource.createWallet(user.id);
        }
      }

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
