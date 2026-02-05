import 'package:ad_e_commerce/features/orders/domain/enities/order_item.dart';

class Orders {
  final String? id;
  final String userId;
  final String? orderNumber;
  final double totalAmount;
  final String status;
  final String paymentMethod;
  final Map<String, dynamic> shippingAddress;
  final List<OrderItem> orderItems;

  Orders({
    this.id,
    required this.userId,
    required this.totalAmount,
    required this.status,
    required this.paymentMethod,
    required this.shippingAddress,
    required this.orderItems,
    this.orderNumber,
  });
}
