import 'package:equatable/equatable.dart';
// enum SignupStatus { initial, loading, otpSent, failure }

class SignupState extends Equatable {
  final String phone;
  final String name;
  const SignupState(this.phone, this.name);
  @override
  List<Object?> get props => [phone, name];
}

class SignupInitial extends SignupState {
  @override
  // ignore: overridden_fields
  final String phone;
  @override
  // ignore: overridden_fields
  final String name;
  const SignupInitial({this.phone = "", this.name = ""}) : super(phone, name);
}

class SignupLoading extends SignupState {
  @override
  // ignore: overridden_fields
  final String phone;
  @override
  // ignore: overridden_fields
  final String name;
  const SignupLoading({this.phone = "", this.name = ""}) : super(phone, name);
}

class OtpSend extends SignupState {
  @override
  // ignore: overridden_fields
  final String phone;
  @override
  // ignore: overridden_fields
  final String name;
  const OtpSend(this.phone, this.name) : super(phone, name);
}

class SignupSuccess extends SignupState {
  const SignupSuccess(super.phone, super.name);
}

class SignupError extends SignupState {
  final String message;
  const SignupError(this.message, {required String phone, required String name})
    : super(phone, name);
}
