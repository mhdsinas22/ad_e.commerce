part of 'signup_bloc.dart';

enum SignupStatus { initial, loading, otpSent, failure }

class SignupState extends Equatable {
  final SignupStatus status;
  final String phoneNumber;
  final String? errorMessage;

  const SignupState({
    this.status = SignupStatus.initial,
    this.phoneNumber = '',
    this.errorMessage,
  });

  SignupState copyWith({
    SignupStatus? status,
    String? phoneNumber,
    String? errorMessage,
  }) {
    return SignupState(
      status: status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, phoneNumber, errorMessage];
}
