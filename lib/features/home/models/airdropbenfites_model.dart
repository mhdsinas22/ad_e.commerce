import 'package:ad_e_commerce/features/home/domain/enitites/airdropbenfites_entity.dart';

class AirdropbenfitesModel extends AirdropbenfitesEntity {
  const AirdropbenfitesModel({
    super.id,
    required super.imageUrl,
    required super.isActive,
  });

  factory AirdropbenfitesModel.fromJson(Map<String, dynamic> json) {
    return AirdropbenfitesModel(
      id: json['id'],
      imageUrl: List<String>.from(json['image_url'] ?? []),
      isActive: json['is_active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'image_url': imageUrl, 'is_active': isActive};
  }
}
