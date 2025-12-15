part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class OtpCodeChanged extends OtpEvent {
  final String otpCode;

  const OtpCodeChanged(this.otpCode);

  @override
  List<Object> get props => [otpCode];
}

class OtpVerify extends OtpEvent {
  const OtpVerify();
}

class OtpResend extends OtpEvent {
  const OtpResend();
}
