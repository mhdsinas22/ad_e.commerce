import 'package:ad_e_commerce/core/utils/app_logger.dart';
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
      final name = state.name;

      emit(SignupLoading(phone: phone, name: name));
      if (name.trim().isEmpty) {
        emit(SignupError("Name is required", phone: phone, name: name));
        return;
      }
      if (phone.length != 10) {
        emit(
          SignupError(
            "Enter valid 10-digit phone number:-$phone",
            phone: phone,
            name: name,
          ),
        );
        return;
      }
      try {
        // Check phone already exists in DB
        final existingUser =
            await supabase
                .from("profiles")
                .select("user_id")
                .eq("phone", phone)
                .maybeSingle();
        if (existingUser != null) {
          emit(
            SignupError(
              "Already registered. Please login",
              phone: phone,
              name: name,
            ),
          );
          return;
        }

        await supabase.auth.signInWithOtp(phone: "+91$phone");
        emit(OtpSend(phone, name));
      } catch (e) {
        AppLogger.error("OTP SEND ERROR:-${e.toString()}");
        emit(SignupError("OTP send failed:-$e", phone: phone, name: name));
      }
    });
    // VERIFY OTP

    on<PhoneChangedEvent>((event, emit) {
      emit(SignupInitial(phone: event.phone, name: state.name));
    });
    on<NameChangedEvent>((event, emit) {
      emit(SignupInitial(name: event.name, phone: state.phone));
    });
  }
}
