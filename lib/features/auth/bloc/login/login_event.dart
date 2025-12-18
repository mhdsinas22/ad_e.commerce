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
