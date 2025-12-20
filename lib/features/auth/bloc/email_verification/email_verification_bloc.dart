import 'package:ad_e_commerce/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'email_verification_event.dart';
part 'email_verification_state.dart';

class EmailVerificationBloc
    extends Bloc<EmailVerificationEvent, EmailVerificationState> {
  final AuthRepository _authRepository;

  EmailVerificationBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const EmailVerificationState()) {
    on<CheckVerificationStatus>(_onCheckVerificationStatus);
    on<ResendVerificationEmail>(_onResendVerificationEmail);
    on<SignOut>(_onSignOut);
  }

  Future<void> _onCheckVerificationStatus(
    CheckVerificationStatus event,
    Emitter<EmailVerificationState> emit,
  ) async {
    emit(state.copyWith(status: EmailVerificationStatus.loading));
    try {
      await _authRepository.reloadSession();
      if (_authRepository.isEmailVerified) {
        emit(state.copyWith(status: EmailVerificationStatus.success));
      } else {
        emit(
          state.copyWith(
            status: EmailVerificationStatus.failure,
            error: "Email not verified yet. Please check your inbox.",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: EmailVerificationStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _onResendVerificationEmail(
    ResendVerificationEmail event,
    Emitter<EmailVerificationState> emit,
  ) async {
    // Supabase handles this mostly, but if needed, we can trigger an update or re-signup
    // For now, we will assume the initial email is sufficient, or implement specific logic if the API supports it
    // specific "resend" relies on update user or sign in again usually.
    // We'll keep it simple for now as requested.
  }

  Future<void> _onSignOut(
    SignOut event,
    Emitter<EmailVerificationState> emit,
  ) async {
    await _authRepository.signOut();
  }
}
