import 'package:equatable/equatable.dart';

enum OtpStatus { initial, verifying, verified, failed }

class OtpState extends Equatable {
  final String otpCode;
  final OtpStatus status;
  final String? errorMessage;
  final int timerSeconds;

  const OtpState({
    this.otpCode = '',
    this.status = OtpStatus.initial,
    this.errorMessage,
    this.timerSeconds = 30,
  });

  OtpState copyWith({
    String? otpCode,
    OtpStatus? status,
    String? errorMessage,
    int? timerSeconds,
  }) {
    return OtpState(
      otpCode: otpCode ?? this.otpCode,
      status: status ?? this.status,
      errorMessage: errorMessage,
      timerSeconds: timerSeconds ?? this.timerSeconds,
    );
  }

  @override
  List<Object?> get props => [otpCode, status, errorMessage, timerSeconds];
}
