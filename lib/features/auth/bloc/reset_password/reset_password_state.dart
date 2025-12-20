enum ResetPasswordStatus { initial, loading, success, failure }

class ResetPasswordState {
  final String password;
  final ResetPasswordStatus status;
  final String? error;

  ResetPasswordState({
    this.password = '',
    this.status = ResetPasswordStatus.initial,
    this.error,
  });

  ResetPasswordState copyWith({
    String? password,
    ResetPasswordStatus? status,
    String? error,
  }) {
    return ResetPasswordState(
      password: password ?? this.password,
      status: status ?? this.status,
      error: error,
    );
  }
}
