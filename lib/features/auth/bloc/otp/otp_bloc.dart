// ignore_for_file: unused_element
import 'dart:async';
import 'package:ad_e_commerce/core/services/notification_service.dart';
import 'package:ad_e_commerce/features/auth/bloc/otp/otp_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/otp/otp_state.dart';
import 'package:ad_e_commerce/features/cart/domain/repositories/cart_repository.dart';
import 'package:ad_e_commerce/features/profile/data/datasource/wallet_remote_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final SupabaseClient supabase;
  final WalletRemoteDataSource walletRemoteDataSource;
  final CartRepository cartRepository;
  final NotificationService notificationService;
  final String phone;
  final String name;
  Timer? _timer;
  OtpBloc({
    required this.phone,
    required this.walletRemoteDataSource,
    required this.name,
    required this.cartRepository,
    required this.notificationService,
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
    on<OtpTimerTicked>(_onTimerTicked); // ✅ ADD THIS
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
      final res = await supabase.functions.invoke(
        "verify-otp",
        body: {"phone": phone, "otp": state.otpCode, "name": name},
      );

      if (res.data != null && res.data['success'] == true) {
        final data = res.data as Map<String, dynamic>;
        final refreshToken = data['refreshToken'];

        if (refreshToken == null) {
          throw Exception("Refresh token is null from Edge Function");
        }
        await supabase.auth.setSession(refreshToken);
        final userId = supabase.auth.currentUser!.id;
        await walletRemoteDataSource.ensureWalletExists(userId);
        await notificationService.attachUser(userId);
        await cartRepository.syncGuestCart();

        emit(state.copyWith(status: OtpStatus.verified));
      } else {
        emit(
          state.copyWith(
            status: OtpStatus.failed,
            errorMessage: res.data?['message'] ?? "Invalid OTP",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: OtpStatus.failed, errorMessage: "Invalid Otp"),
      );
    }
  }

  // RESEND  OTP LOGIC
  Future<void> _onResendOtp(ResendOtp event, Emitter<OtpState> emit) async {
    try {
      await supabase.functions.invoke("send-otp", body: {"phone": phone});
      emit(
        state.copyWith(
          timerSeconds: 30,
          status: OtpStatus.initial,
          otpCode: "",
        ),
      );
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
