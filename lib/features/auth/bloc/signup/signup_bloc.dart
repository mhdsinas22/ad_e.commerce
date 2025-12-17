import 'package:ad_e_commerce/features/auth/bloc/signup/signup_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/signup/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final supabase = Supabase.instance.client;
  String phone = "";
  SignupBloc() : super(SignupInitial()) {
    // Send Otp
    on<SendOtpEvent>((event, emit) async {
      emit(SignupLoading());
      if (phone.length != 10) {
        emit(SignupError("Enter valid 10-digit phone number"));
        return;
      }
      try {
        await supabase.auth.signInWithOtp(phone: "+91$phone");
        emit(OtpSend(phone));
      } catch (e) {
        SignupError("OTP send failed");
      }
    });
    // VERIFY OTP
    on<VerifyOtpEvent>((event, emit) async {
      emit(SignupLoading());
      try {
        await supabase.auth.verifyOTP(
          phone: "+91$phone",
          token: event.otp,
          type: OtpType.sms,
        );
        emit(SignupSuccess());
      } catch (e) {
        emit(SignupError("Invalid OTP"));
      }
    });
    // SAVE USER DETAILS
    on<SaveUserDetails>((event, emit) async {
      emit(SignupLoading());
      final user = supabase.auth.currentUser;
      if (user == null) {
        emit(SignupError("User not authenticated"));
        return;
      }
      try {
        await supabase.from("users").insert({
          "id": user.id,
          "username": event.username,
          "email": event.email,
          " phone": phone,
        });
        emit(SignupSuccess());
      } catch (e) {
        emit(SignupError("Failed to save user"));
      }
    });

    on<PhoneChangedEvent>((event, emit) {
      phone = event.phone;
    });
  }
}
