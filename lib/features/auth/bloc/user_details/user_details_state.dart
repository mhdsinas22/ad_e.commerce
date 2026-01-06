import 'package:equatable/equatable.dart';

enum UserDetailsStatus { initial, loading, success, failure }

class UserDetailsState extends Equatable {
  final String phone;
  final String email;
  final String username;
  final String password;
  final String imageUrl;
  final String? error;
  final UserDetailsStatus? status;
  final bool isPasswordVisible;
  const UserDetailsState({
    this.phone = "",
    this.email = "",
    this.username = "",
    this.password = "",
    this.error,
    this.status = UserDetailsStatus.initial,
    this.isPasswordVisible = false,
    this.imageUrl = "",
  });
  UserDetailsState copyWith({
    String? username,
    String? email,
    String? password,
    String? error,
    UserDetailsStatus? status,
    String? phoneNumber,
    bool? isPasswordVisible,
    String? imageUrl,
  }) {
    return UserDetailsState(
      phone: phoneNumber ?? phone,
      username: username ?? this.username,
      password: password ?? this.password,
      error: error,
      email: email ?? this.email,
      // ignore: unnecessary_this
      status: status ?? this.status,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [
    username,
    phone,
    email,
    password,
    status,
    error,
    isPasswordVisible,
    imageUrl,
  ];
}
