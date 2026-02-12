import 'package:ad_e_commerce/core/utils/app_logger.dart';
import 'package:ad_e_commerce/data/repositories/auth_repository.dart';
import 'package:ad_e_commerce/features/auth/bloc/login/login_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      final result = await authRepository.checkPhoneExists(event.phone);
      if (result == null) {
        final formattedPhone = "+91${event.phone}";
        await authRepository.sendOtp(phone: formattedPhone);
        emit(state.copyWith(status: LoginStatus.success, phone: event.phone));
      }
    } catch (e) {
      AppLogger.error("Error in login phone submitted: $e");
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'USER_NOT_FOUND',
        ),
      );
    }
  }
}
