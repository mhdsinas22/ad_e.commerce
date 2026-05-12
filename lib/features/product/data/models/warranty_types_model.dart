import 'package:aerstore/features/product/domain/entites/warranty_types.dart';

class WarrantyTypesModel extends WarrantyTypes {
  const WarrantyTypesModel({super.id, required super.name});

  /// 🔹 JSON → Model
  factory WarrantyTypesModel.fromJson(Map<String, dynamic> json) {
    return WarrantyTypesModel(id: json['id'] ?? "", name: json['name'] ?? "");
  }

  /// 🔹 Model → JSON
  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
