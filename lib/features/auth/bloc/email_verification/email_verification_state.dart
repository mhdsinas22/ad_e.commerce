part of 'email_verification_bloc.dart';

enum EmailVerificationStatus { initial, loading, success, failure }

class EmailVerificationState {
  final EmailVerificationStatus status;
  final String? error;

  const EmailVerificationState({
    this.status = EmailVerificationStatus.initial,
    this.error,
  });

  EmailVerificationState copyWith({
    EmailVerificationStatus? status,
    String? error,
  }) {
    return EmailVerificationState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
