import 'package:equatable/equatable.dart';

enum ForgotPasswordStatus { initial, loading, success, failure }

class ForgotPasswordState extends Equatable {
  final String email;
  final ForgotPasswordStatus status;
  final String? error;
  const ForgotPasswordState({
    this.email = "",
    this.error = "",
    this.status = ForgotPasswordStatus.initial,
  });
  ForgotPasswordState copyWith({
    String? email,
    ForgotPasswordStatus? status,
    String? error,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      error: error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [email, status, error];
}
