class UserModel {
  final String userId; // auth.users.id
  final String phone;
  final String username;
  final String email;
  UserModel({
    required this.phone,
    required this.email,
    required this.username,
    required this.userId,
  });
  Map<String, dynamic> toJson() {
    return {
      "phone": phone,
      "email": email,
      "username": username,
      "user_id": userId,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      phone: json["phone"] as String,
      email: json["email"] as String,
      username: json["username"] as String,
      userId: json["user_id"] as String,
    );
  }
}
