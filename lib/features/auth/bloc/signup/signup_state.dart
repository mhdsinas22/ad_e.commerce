import 'package:equatable/equatable.dart';
// enum SignupStatus { initial, loading, otpSent, failure }

class SignupState extends Equatable {
  final String phone;
  const SignupState(this.phone);
  @override
  List<Object?> get props => [phone];
}

class SignupInitial extends SignupState {
  @override
  final String phone;
  const SignupInitial({this.phone = ""}) : super(phone);
}

class SignupLoading extends SignupState {
  @override
  final String phone;
  const SignupLoading({this.phone = ""}) : super(phone);
}

class OtpSend extends SignupState {
  @override
  final String phone;

  const OtpSend(this.phone) : super(phone);
}

class SignupSuccess extends SignupState {
  const SignupSuccess(super.phone);
}

class SignupError extends SignupState {
  final String message;
  const SignupError(this.message, {required String phone}) : super(phone);
}
