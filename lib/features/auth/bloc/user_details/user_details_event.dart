import 'package:equatable/equatable.dart';

abstract class UserDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsernameChanged extends UserDetailsEvent {
  final String username;
  UsernameChanged(this.username);
  @override
  List<Object?> get props => [username];
}

class EmailChanged extends UserDetailsEvent {
  final String email;
  EmailChanged(this.email);
  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends UserDetailsEvent {
  final String password;
  PasswordChanged(this.password);
  @override
  List<Object?> get props => [password];
}

class SubmitUserDetails extends UserDetailsEvent {}
