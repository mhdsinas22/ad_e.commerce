import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String email;
  final String username;
  final String phone;
  final String imageUrl;

  const UserEntity({
    required this.userId,
    required this.email,
    required this.username,
    required this.phone,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [userId, email, username, phone, imageUrl];
}
