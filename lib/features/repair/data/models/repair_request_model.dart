import 'package:ad_e_commerce/features/repair/domain/entities/repair_request_entity.dart';

class RepairRequestModel extends RepairRequestEntity {
  const RepairRequestModel({
    super.id,
    required super.brand,
    required super.services,
    required super.deviceModel,
    required super.complaintDescription,
    required super.imageUrls,
    required super.name,
    required super.mobileNumber,
    required super.email,
    required super.location,
    required super.createdAt,
  });

  factory RepairRequestModel.fromJson(Map<String, dynamic> json) {
    return RepairRequestModel(
      id: json['id'] as String?,
      brand: json['brand'] as String,
      services: List<String>.from(json['services'] ?? []),
      deviceModel: json['device_model'] as String,
      complaintDescription: json['complaint_description'] as String,
      imageUrls: List<String>.from(json['image_urls'] ?? []),
      name: json['name'] as String,
      mobileNumber: json['mobile_number'] as String,
      email: json['email'] as String,
      location: json['location'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'brand': brand,
      'services': services,
      'device_model': deviceModel,
      'complaint_description': complaintDescription,
      'image_urls': imageUrls,
      'name': name,
      'mobile_number': mobileNumber,
      'email': email,
      'location': location,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory RepairRequestModel.fromEntity(RepairRequestEntity entity) {
    return RepairRequestModel(
      id: entity.id,
      brand: entity.brand,
      services: entity.services,
      deviceModel: entity.deviceModel,
      complaintDescription: entity.complaintDescription,
      imageUrls: entity.imageUrls,
      name: entity.name,
      mobileNumber: entity.mobileNumber,
      email: entity.email,
      location: entity.location,
      createdAt: entity.createdAt,
    );
  }
}
