import 'package:aerstore/core/utils/app_logger.dart';
import 'package:aerstore/features/cart/domain/enities/cart_item.dart';

class CartItemModel extends CartItem {
  CartItemModel({
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
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final product = json["products"];
    AppLogger.info("PRODUCT JSON 👉 $product");
    return CartItemModel(
      id: json["id"] ?? "",
      productId: json["product_id"] ?? "",
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: (json["quantity"] as num?)?.toInt() ?? 0,
      storename: json["store_name"] ?? "",
      // Prdocut Details for Ui
      title: product["title"] ?? "",
      modelNumber: product["model_number"] ?? " ",
      storeage: product["storage"] ?? "",
      color: product["color"] ?? "",
      imageUrl:
          (product["image_url"] != null &&
                  product["image_url"] is List &&
                  product["image_url"].isNotEmpty)
              ? product["image_url"][0]
              : "",
      rating: (product["rating"] ?? 0.0).toString(),
      noOfRating: (product["no_of_reviews"] ?? 0).toString(),
    );
  }
  Map<String, dynamic> toJson() {
    return {"price": price, "quantity": quantity, "store_name": storename};
  }
}
