import 'package:equatable/equatable.dart';

enum UserDetailsStatus { initial, loading, success, failure }

class UserDetailsState extends Equatable {
  final String phone;
  final String email;
  final String username;
  final String password;
  final String? error;
  final UserDetailsStatus? status;

  const UserDetailsState({
    this.phone = "",
    this.email = "",
    this.username = "",
    this.password = "",
    this.error,
    this.status = UserDetailsStatus.initial,
  });
  UserDetailsState copyWith({
    String? username,
    String? email,
    String? password,
    String? error,
    UserDetailsStatus? status,
    String? phoneNumber,
  }) {
    return UserDetailsState(
      phone: phoneNumber ?? this.phone,
      username: username ?? this.username,
      password: password ?? this.password,
      error: error,
      email: email ?? this.email,
      // ignore: unnecessary_this
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [username, phone, email, password, status, error];
}
