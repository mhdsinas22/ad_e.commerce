import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Username / Email typing
class LoginUsernameChanged extends LoginEvent {
  final String username;

  LoginUsernameChanged(this.username);

  @override
  List<Object?> get props => [username];
}

class LoginPhoneChanged extends LoginEvent {
  final String phone;

  LoginPhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

// Password typing
class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  final String emailOrUsername;
  final String password;

  LoginSubmitted({required this.emailOrUsername, required this.password});
  @override
  List<Object?> get props => [password, emailOrUsername];
}

class LoginPhoneSubmitted extends LoginEvent {
  final String phone;

  LoginPhoneSubmitted(this.phone);

  @override
  List<Object?> get props => [phone];
}
