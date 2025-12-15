part of 'user_details_bloc.dart';

abstract class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();

  @override
  List<Object> get props => [];
}

class UserDetailsNameChanged extends UserDetailsEvent {
  final String name;

  const UserDetailsNameChanged(this.name);

  @override
  List<Object> get props => [name];
}

class UserDetailsEmailChanged extends UserDetailsEvent {
  final String email;

  const UserDetailsEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class UserDetailsGenderChanged extends UserDetailsEvent {
  final String gender;

  const UserDetailsGenderChanged(this.gender);

  @override
  List<Object> get props => [gender];
}

class UserDetailsSubmit extends UserDetailsEvent {
  const UserDetailsSubmit();
}
