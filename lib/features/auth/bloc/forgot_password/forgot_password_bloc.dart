import 'package:ad_e_commerce/data/repositories/auth_repository.dart';
import 'package:ad_e_commerce/features/auth/bloc/forgot_password/forgot_password_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/forgot_password/forgot_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository authRepository;

  ForgotPasswordBloc({required this.authRepository})
    : super(const ForgotPasswordState()) {
    on<ForgotPasswordEmailChanged>(_onEmailChanged);
    on<ForgotPasswordSubmitted>(_onSubmit);
  }

  void _onEmailChanged(
    ForgotPasswordEmailChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
        status: ForgotPasswordStatus.initial,
        error: null,
      ),
    );
  }

  Future<void> _onSubmit(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    if (state.email.isEmpty) {
      emit(
        state.copyWith(
          status: ForgotPasswordStatus.failure,
          error: "Email is required",
        ),
      );
      return;
    }

    emit(state.copyWith(status: ForgotPasswordStatus.loading));

    try {
      await authRepository.resetPasswordForEmail(state.email);
      emit(state.copyWith(status: ForgotPasswordStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: ForgotPasswordStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }
}
