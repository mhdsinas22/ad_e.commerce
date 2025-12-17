import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
  @override
  List<Object?> get props => [];
}

class SendOtpEvent extends SignupEvent {
  const SendOtpEvent();
}

class VerifyOtpEvent extends SignupEvent {
  final String phone;
  final String otp;
  const VerifyOtpEvent(this.phone, this.otp);
}

class SaveUserDetails extends SignupEvent {
  final String email;
  final String username;
  final String password;
  final String phone;
  const SaveUserDetails({
    required this.email,
    required this.password,
    required this.username,
    required this.phone,
  });
}

class PhoneChangedEvent extends SignupEvent {
  final String phone;
  const PhoneChangedEvent(this.phone);

  @override
  List<Object?> get props => [phone];
}
