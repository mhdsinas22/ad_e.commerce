import 'package:ad_e_commerce/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.userId,
    required super.email,
    required super.username,
    required super.phone,
    required super.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "email": email,
      "username": username,
      "phone": phone,
      "image_url": imageUrl,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["user_id"] ?? '',
      email: json["email"] ?? '',
      username: json["username"] ?? '',
      phone: json["phone"] ?? '',
      imageUrl: json["image_url"] ?? '',
    );
  }

  UserModel copyWith({
    String? userId,
    String? email,
    String? username,
    String? phone,
    String? imageUrl,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
