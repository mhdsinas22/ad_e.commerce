import 'package:ad_e_commerce/features/orders/domain/enities/order_item.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/orders.dart';

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
  Future<void> deleteOrder({required String orderId});
}
