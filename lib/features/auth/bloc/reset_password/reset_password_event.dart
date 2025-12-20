abstract class ResetPasswordEvent {}

class PasswordChanged extends ResetPasswordEvent {
  final String password;
  PasswordChanged(this.password);
}

class ResetPasswordSubmitted extends ResetPasswordEvent {}
