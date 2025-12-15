part of 'user_details_bloc.dart';

enum UserDetailsStatus { initial, saving, saved, failure }

class UserDetailsState extends Equatable {
  final UserDetailsStatus status;
  final String name;
  final String email;
  final String gender;
  final String? errorMessage;

  const UserDetailsState({
    this.status = UserDetailsStatus.initial,
    this.name = '',
    this.email = '',
    this.gender = 'Select Gender', // Default or placeholder
    this.errorMessage,
  });

  UserDetailsState copyWith({
    UserDetailsStatus? status,
    String? name,
    String? email,
    String? gender,
    String? errorMessage,
  }) {
    return UserDetailsState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, name, email, gender, errorMessage];
}
