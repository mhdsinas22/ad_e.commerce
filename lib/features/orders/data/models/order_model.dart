import 'package:ad_e_commerce/features/orders/domain/enities/orders.dart';

class OrderModel extends Orders {
  OrderModel({
    required super.id,
    required super.userId,
    required super.totalAmount,
    required super.status,
    required super.paymentMethod,
    required super.shippingAddress,
  });
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"],
      userId: json["user_id"],
      totalAmount: (json['total_amount'] as num).toDouble(),
      status: json["status"],
      paymentMethod: json["payment_method"],
      shippingAddress: json["shipping_address"],
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
    );
  }
  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "total_amount": totalAmount,
    "status": status,
    "payment_method": paymentMethod,
    "shipping_address": shippingAddress,
  };
}
