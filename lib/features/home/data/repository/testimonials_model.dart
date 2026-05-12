import 'package:aerstore/features/home/domain/enitites/testimonials_entity.dart';

class TestmonialModel extends TestmonialEntity {
  TestmonialModel({
    super.id,
    required super.username,
    required super.content,
    required super.isActive,
  });
  factory TestmonialModel.fromJson(Map<String, dynamic> json) {
    return TestmonialModel(
      id: json["id"],
      username: json["user_name"],
      content: json["content"],
      isActive: json["is_active"],
    );
  }
  Map<String, dynamic> toJson() {
    return {"user_name": username, "content": content, "is_active": isActive};
  }
}
