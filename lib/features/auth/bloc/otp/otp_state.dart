part of 'otp_bloc.dart';

enum OtpStatus { initial, verifying, verified, failed }

class OtpState extends Equatable {
  final OtpStatus status;
  final String otpCode;
  final String? errorMessage;
  final int timerSeconds;

  const OtpState({
    this.status = OtpStatus.initial,
    this.otpCode = '',
    this.errorMessage,
    this.timerSeconds = 30,
  });

  OtpState copyWith({
    OtpStatus? status,
    String? otpCode,
    String? errorMessage,
    int? timerSeconds,
  }) {
    return OtpState(
      status: status ?? this.status,
      otpCode: otpCode ?? this.otpCode,
      errorMessage: errorMessage ?? this.errorMessage,
      timerSeconds: timerSeconds ?? this.timerSeconds,
    );
  }

  @override
  List<Object?> get props => [status, otpCode, errorMessage, timerSeconds];
}
