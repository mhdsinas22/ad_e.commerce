part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupPhoneChanged extends SignupEvent {
  final String phoneNumber;

  const SignupPhoneChanged(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class SignupSendOtp extends SignupEvent {
  final String phoneNumber;

  const SignupSendOtp(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}
