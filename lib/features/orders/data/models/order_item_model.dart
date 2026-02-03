import 'package:ad_e_commerce/features/orders/domain/enities/order_item.dart';

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
    );
  }
  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json["id"],
      orderId: json["order_id"],
      productId: json["product_id"],
      productName: json["product_name"],
      productImage: json["product_image"],
      sku: json["sku"],
      price: json["price"],
      quantity: json["quantity"],
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
    };
  }
}
