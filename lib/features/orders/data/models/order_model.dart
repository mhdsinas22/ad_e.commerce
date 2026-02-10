import 'package:ad_e_commerce/features/orders/data/models/order_item_model.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/orders.dart';

class OrderModel extends Orders {
  OrderModel({
    required super.id,
    required super.userId,
    required super.totalAmount,
    required super.status,
    required super.paymentMethod,
    required super.shippingAddress,
    required super.orderItems,
    required super.walletUsed,
    super.orderNumber,
    super.packedAt,
    super.shippedAt,
    super.deliveredAt,
    super.createdAt,
  });
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"],
      userId: json["user_id"],
      orderNumber: json["order_number"] ?? "",
      totalAmount: (json['total_amount'] as num).toDouble(),
      status: json["status"] ?? "",
      paymentMethod: json["payment_method"] ?? "",
      shippingAddress: json["shipping_address"] ?? "",
      orderItems:
          (json["order_items"] as List)
              .map((e) => OrderItemModel.fromJson(e))
              .toList(),
      walletUsed: (json["wallet_used"] as num?)?.toDouble() ?? 0.0,
      packedAt:
          json['packed_at'] != null ? DateTime.parse(json['packed_at']) : null,
      shippedAt:
          json['shipped_at'] != null
              ? DateTime.parse(json['shipped_at'])
              : null,
      deliveredAt:
          json['delivered_at'] != null
              ? DateTime.parse(json['delivered_at'])
              : null,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
    );
  }
  factory OrderModel.fromEntity(Orders order) {
    return OrderModel(
      id: order.id,
      userId: order.userId,
      totalAmount: order.totalAmount,
      status: order.status,
      paymentMethod: order.paymentMethod,
      shippingAddress: order.shippingAddress,
      orderItems: order.orderItems,
      orderNumber: order.orderNumber,
      walletUsed: order.walletUsed,
      packedAt: order.packedAt,
      shippedAt: order.shippedAt,
      deliveredAt: order.deliveredAt,
    );
  }
  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "total_amount": totalAmount,
    "status": status,
    "payment_method": paymentMethod,
    "shipping_address": shippingAddress,
    "wallet_used": walletUsed,
  };
}
