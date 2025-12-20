import 'package:ad_e_commerce/features/auth/bloc/signup/signup_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/signup/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final supabase = Supabase.instance.client;
  SignupBloc() : super(SignupInitial()) {
    // Send Otp
    on<SendOtpEvent>((event, emit) async {
      final phone = state.phone;
      emit(SignupLoading(phone: phone));

      if (phone.length != 10) {
        emit(
          SignupError(
            "Enter valid 10-digit phone number:-$phone",
            phone: phone,
          ),
        );
        return;
      }
      try {
        // Check phone already exists in DB
        final existingUser =
            await supabase
                .from("users")
                .select("id")
                .eq("phone", phone)
                .maybeSingle();
        if (existingUser != null) {
          emit(SignupError("Already registered. Please login", phone: phone));
          return;
        }
        await supabase.auth.signInWithOtp(phone: "+91$phone");
        emit(OtpSend(phone));
      } catch (e) {
        emit(SignupError("OTP send failed:-$e", phone: phone));
      }
    });
    // VERIFY OTP
    on<VerifyOtpEvent>((event, emit) async {
      final phone = (state as OtpSend).phone;
      emit(SignupLoading(phone: phone));
      try {
        final res = await supabase.auth.verifyOTP(
          phone: "+91$phone",
          token: event.otp,
          type: OtpType.sms,
        );
        if (res.session != null) {
          emit(SignupSuccess(phone));
        } else {
          emit(SignupError("OTP verification failed", phone: phone));
        }
      } on AuthException catch (e) {
        emit(SignupError(e.message, phone: phone));
      } catch (e) {
        emit(SignupError("Invalid OTP", phone: phone));
      }
    });

    on<PhoneChangedEvent>((event, emit) {
      emit(SignupInitial(phone: event.phone));
    });
  }
}
