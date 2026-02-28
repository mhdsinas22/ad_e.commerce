import 'package:ad_e_commerce/data/repositories/auth_repository.dart';
import 'package:ad_e_commerce/features/auth/bloc/login/login_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  LoginBloc({required this.authRepository}) : super(const LoginState()) {
    on<LoginUsernameChanged>((event, emit) {
      emit(state.copyWith(username: event.username));
    });
    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<LoginPhoneChanged>(_onLoginPhoneChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginPhoneSubmitted>(_onLoginPhoneSubmitted);
  }
  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));
    final result = await authRepository.login(
      emailorUsername: event.emailOrUsername,
      password: event.password,
    );
    if (result == null) {
      emit(state.copyWith(status: LoginStatus.success));
    } else if (result == "EMAIL_NOT_VERIFIED") {
      await authRepository.signOut(); // ✅ correct place
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'EMAIL_NOT_VERIFIED',
        ),
      );
    } else {
      emit(state.copyWith(status: LoginStatus.failure, errorMessage: result));
    }
  }

  _onLoginPhoneChanged(LoginPhoneChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(phone: event.phone));
  }

  Future<void> _onLoginPhoneSubmitted(
    LoginPhoneSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      // Step 1:  Check user exists in profiles table
      final existingUser =
          await Supabase.instance.client
              .from("profiles")
              .select("user_id")
              .eq("phone", event.phone)
              .maybeSingle();
      if (existingUser == null) {
        emit(
          state.copyWith(
            status: LoginStatus.failure,
            errorMessage: "User not found. Please signup",
          ),
        );
        return;
      }
      // Step 2: Send OTP
      final response = await Supabase.instance.client.functions.invoke(
        "send-otp",
        body: {"phone": event.phone},
      );
      if (response.status != 200) {
        throw Exception("Otp send Failed");
      }
      emit(state.copyWith(status: LoginStatus.success, phone: event.phone));
    } catch (e) {
      print("LOgin phone error:-${e.toString()}");
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'something went wrong:-${e.toString()}',
        ),
      );
    }
  }
}
