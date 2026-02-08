import 'package:ad_admin_side/features/product/domain/entities/warranty/product_warranty.dart';

class ProductWarrantyModel extends ProductWarranty {
  const ProductWarrantyModel({
    super.id,
    required super.productId,
    required super.warrantyTypeId,
    required super.startDate,
    required super.endDate,
    required super.durationText,
  });

  /// 🔹 JSON → Model
  factory ProductWarrantyModel.fromJson(Map<String, dynamic> json) {
    return ProductWarrantyModel(
      id: json['id'] as String?,
      productId: json['product_id'] ?? "",
      warrantyTypeId: json["warranty_type_id"] ?? "",
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      durationText: json['duration_text'] ?? "",
    );
  }

  /// 🔹 Model → JSON
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'warranty_type_id': warrantyTypeId,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'duration_text': durationText,
    };
  }
}
