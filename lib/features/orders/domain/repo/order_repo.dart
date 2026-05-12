import 'package:aerstore/features/orders/domain/enities/order_item.dart';
import 'package:aerstore/features/orders/domain/enities/orders.dart';

abstract class OrderRepo {
  Future<String> createOrder({
    required Orders order,
    required List<OrderItem> orderitems,
  });
  Future<List<Orders>> getOrders({required String userId});
  Future<List<OrderItem>> getOrderItems({required String orderId});
  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
  });
  Future<void> cancelOrder({
    required Orders order,
    required String reason,
  });
  Future<void> deleteOrder({required String orderId});
}
