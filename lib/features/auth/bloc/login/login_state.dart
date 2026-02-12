import 'package:equatable/equatable.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final String username;
  final String password;
  final LoginStatus status;
  final String? errorMessage;
  final String phone;

  const LoginState({
    this.username = '',
    this.password = '',
    this.status = LoginStatus.initial,
    this.errorMessage,
    this.phone = "",
  });

  LoginState copyWith({
    String? username,
    String? password,
    LoginStatus? status,
    String? errorMessage,
    String? phone,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [username, password, status, errorMessage, phone];
}
