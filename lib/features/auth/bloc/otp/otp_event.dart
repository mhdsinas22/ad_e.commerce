import 'package:equatable/equatable.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();
  @override
  List<Object?> get props => [];
}

// OTP input change
class OtpCodeChanged extends OtpEvent {
  final String code;
  const OtpCodeChanged(this.code);
  @override
  List<Object?> get props => [code];
}

// Otp Veritfy Button Click
class OtpVerify extends OtpEvent {
  const OtpVerify();
}

// ResendOtp
class ResendOtp extends OtpEvent {
  const ResendOtp();
}

class OtpTimerTicked extends OtpEvent {}
