import 'package:equatable/equatable.dart';
// enum SignupStatus { initial, loading, otpSent, failure }

class SignupState extends Equatable {
  const SignupState();
  @override
  List<Object?> get props => [];
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class OtpSend extends SignupState {
  final String phone;

  const OtpSend(this.phone);
}

class SignupSuccess extends SignupState {}

class SignupError extends SignupState {
  final String message;
  const SignupError(this.message);
}
