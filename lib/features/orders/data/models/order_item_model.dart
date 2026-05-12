import 'package:aerstore/features/orders/domain/enities/order_item.dart';

class OrderItemModel extends OrderItem {
  OrderItemModel({
    required super.id,
    required super.orderId,
    required super.productId,
    required super.productName,
    required super.productImage,
    required super.sku,
    required super.price,
    required super.quantity,
    required super.productStorge,
    required super.productColor,
    required super.productModelNumber,
    required super.productrating,
    required super.productNoOfRating,
  });

  factory OrderItemModel.fromEntity(OrderItem item) {
    return OrderItemModel(
      id: item.id,
      orderId: item.orderId,
      productId: item.productId,
      productName: item.productName,
      productImage: item.productImage,
      sku: item.sku,
      price: item.price,
      quantity: item.quantity,
      productColor: item.productColor,
      productModelNumber: item.productModelNumber,
      productStorge: item.productStorge,
      productNoOfRating: item.productNoOfRating,
      productrating: item.productrating,
    );
  }
  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json["id"] ?? "",
      orderId: json["order_id"] ?? "",
      productId: json["product_id"] ?? "",
      productName: json["product_name"] ?? "",
      productImage: json["product_image"] ?? "",
      sku: json["sku"] ?? "",
      price: (json["price"] as num?)?.toDouble() ?? 0.0,
      quantity: (json["quantity"] as num?)?.toInt() ?? 0,
      productStorge: json["product_stroage"] ?? "",
      productColor: json["product_color"] ?? "",
      productModelNumber: json["product_modelnumber"] ?? "",
      productNoOfRating: json["product_no_of_rating"] ?? "",
      productrating: json["product_rating"] ?? "",
    );
  }
  Map<String, dynamic> toJson({required String orderID}) {
    return {
      "order_id": orderID,
      "product_id": productId,
      "product_name": productName,
      "product_image": productImage,
      "sku": sku,
      "price": price,
      "quantity": quantity,
      "product_stroage": productStorge,
      "product_color": productColor,
      "product_modelnumber": productModelNumber,
      "product_no_of_rating": productNoOfRating,
      "product_rating": productrating,
    };
  }
}
