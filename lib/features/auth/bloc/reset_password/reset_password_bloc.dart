import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'reset_password_event.dart';
import 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final SupabaseClient supabase;

  ResetPasswordBloc({required this.supabase}) : super(ResetPasswordState()) {
    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<ResetPasswordSubmitted>((event, emit) async {
      if (state.password.length < 6) {
        emit(
          state.copyWith(
            status: ResetPasswordStatus.failure,
            error: "Password minimum 6 chars venam",
          ),
        );
        return;
      }

      emit(state.copyWith(status: ResetPasswordStatus.loading));

      try {
        await supabase.auth.updateUser(
          UserAttributes(password: state.password),
        );

        emit(state.copyWith(status: ResetPasswordStatus.success));
      } catch (e) {
        emit(
          state.copyWith(
            status: ResetPasswordStatus.failure,
            error: "Password update failed",
          ),
        );
      }
    });
  }
}
