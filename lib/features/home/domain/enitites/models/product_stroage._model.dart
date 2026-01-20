import 'package:ad_e_commerce/features/product/domain/entites/product.dart';
import 'package:ad_e_commerce/features/product/domain/entites/product_stock.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.condition,
    required super.price,
    required super.originalPrice,
    required super.warrantyMonths,
    required super.isActive,
    required super.color,
    required super.category,
    required super.imageUrls,
    required super.ram,
    required super.storageid,
    required super.tag,
    required super.modelNumber,
    required super.conditionType,
    required super.stocks,
    required super.storageName,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    print("FULL MAP => $map");

    return ProductModel(
      id: map['id']?.toString() ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      condition: map['condition'] ?? '',
      conditionType: map["condition_type"] ?? "",
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      originalPrice: (map['original_price'] as num?)?.toDouble() ?? 0.0,
      warrantyMonths: map['warranty_months'] ?? 0,
      isActive: map['is_active'] ?? false,
      storageName: map["storage"] ?? "",
      color: map['color'] ?? '',
      category: map['category'] ?? '',
      modelNumber: map['model_number'] ?? '',
      ram: map['ram'] ?? '',
      storageid: "storage_id",

      tag: map['tag'] ?? '',
      stocks:
          (map["product_stocks"] as List<dynamic>?)
              ?.map(
                (e) => ProductStock(
                  id: e["id"]?.toString() ?? "",
                  productId: e["product_id"]?.toString() ?? "",
                  storeName: e["store_name"]?.toString() ?? "",
                  quantity: e["quantity"] ?? 0,
                ),
              )
              .toList() ??
          [],
      imageUrls: List<String>.from(map['image_url'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'condition': condition,

      'price': price,
      'original_price': originalPrice,
      'warranty_months': warrantyMonths,
      'is_active': isActive,

      'color': color,
      'category': category,
      "condition_type": conditionType,

      'image_url': imageUrls,
      'model_number': modelNumber,
      'ram': ram,
      'storage_id': storageid,
      'tag': tag,
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      'title': title,
      'description': description,
      'condition': condition,

      'price': price,
      'original_price': originalPrice,
      'warranty_months': warrantyMonths,
      'is_active': isActive,

      'color': color,
      'category': category,
      "condition_type": conditionType,

      'image_url': imageUrls,
      'model_number': modelNumber,
      'ram': ram,
      'storage_id': storageid,
      'tag': tag,
    };
  }
}
