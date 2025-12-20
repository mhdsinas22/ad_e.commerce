part of 'email_verification_bloc.dart';

abstract class EmailVerificationEvent {}

class CheckVerificationStatus extends EmailVerificationEvent {}

class ResendVerificationEmail extends EmailVerificationEvent {}

class SignOut extends EmailVerificationEvent {}
