class UserModel {
  final String userId; // auth.users.id
  final String phone;
  final String username;
  final String email;
  final String imageUrl;
  UserModel({
    required this.phone,
    required this.email,
    required this.username,
    required this.userId,
    required this.imageUrl,
  });
  Map<String, dynamic> toJson() {
    return {
      "phone": phone,
      "email": email,
      "username": username,
      "user_id": userId,
      "image_url": imageUrl,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      phone: json["phone"] as String,
      email: json["email"] as String,
      username: json["username"] as String,
      userId: json["user_id"] as String,
      imageUrl: json["image_url"] as String,
    );
  }
}
