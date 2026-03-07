import 'package:ad_e_commerce/core/utils/app_logger.dart';
import 'package:ad_e_commerce/features/cart/domain/enities/cart_item.dart';

class LocalCartItemModel extends CartItem {
  LocalCartItemModel({
    super.id,
    required super.productId,
    required super.price,
    required super.quantity,
    required super.storename,
    required super.title,
    required super.modelNumber,
    required super.imageUrl,
    required super.storeage,
    required super.color,
    required super.rating,
    required super.noOfRating,
  });
  factory LocalCartItemModel.fromJson(Map<String, dynamic> json) {
    final product = json["products"];
    AppLogger.info("PRODUCT JSON 👉 $product");
    return LocalCartItemModel(
      id: json["product_id"] ?? "",
      productId: json["product_id"] ?? "",
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: (json["quantity"] as num?)?.toInt() ?? 0,
      storename: json["store_name"] ?? "",
      title: json["title"] ?? "",
      modelNumber: json["model_number"] ?? "",
      storeage: json["storage"] ?? "",
      color: json["color"] ?? "",
      imageUrl: json["image_url"] ?? "",
      rating: json["rating"] ?? "",
      noOfRating: json["no_of_reviews"] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "store_name": storename,
      "price": price,
      "quantity": quantity,
      "title": title,
      "model_number": modelNumber,
      "image_url": imageUrl,
      "color": color,
      "storage": storeage,
      "rating": rating,
      "no_of_reviews": noOfRating,
    };
  }
}
