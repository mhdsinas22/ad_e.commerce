import 'package:ad_e_commerce/features/product/domain/entites/banner_entity.dart';

class BannerModel extends BannerEntity {
  const BannerModel({
    super.id,
    required super.imageUrl,
    required super.isActive,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      imageUrl: List<String>.from(json['image_url'] ?? []),
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'image_url': imageUrl, 'is_active': isActive};
  }
}
