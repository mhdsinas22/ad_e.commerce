import 'package:ad_e_commerce/features/auth/bloc/forgot_password/forgot_password_event.dart';
import 'package:ad_e_commerce/features/auth/bloc/forgot_password/forgot_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final SupabaseClient supabase;
  ForgotPasswordBloc({required this.supabase})
    : super(const ForgotPasswordState()) {
    on<ForgotPasswordEmailChanged>(_onEmailChanged);
    on<ForgotPasswordSubmitted>(_onSubmit);
  }
  void _onEmailChanged(
    ForgotPasswordEmailChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  void _onSubmit(
    ForgotPasswordSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    if (state.email.isEmpty) {
      emit(
        state.copyWith(
          status: ForgotPasswordStatus.failure,
          error: "Email required",
        ),
      );
      return;
    }
    emit(state.copyWith(status: ForgotPasswordStatus.loading));
    try {
      await supabase.auth.resetPasswordForEmail(
        state.email,
        redirectTo: 'yourapp://reset-password',
      );
      emit(state.copyWith(status: ForgotPasswordStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: ForgotPasswordStatus.failure,
          error: "Reset mail send cheyyan pattiyilla",
        ),
      );
    }
  }
}
