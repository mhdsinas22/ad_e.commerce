import 'package:aerstore/features/orders/data/models/order_item_model.dart';
import 'package:aerstore/features/orders/data/models/order_model.dart';

abstract class OrderRemoteDatasource {
  Future<String> createOrder(OrderModel orders, List<OrderItemModel> items);
  Future<void> createOrderItems(String orderId, List<OrderItemModel> items);
  Future<List<OrderModel>> getOrders({required String userId});
  Future<List<OrderItemModel>> getOrderItems({required String orderId});
  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
    String? cancelReason,
    DateTime? cancelledAt,
  });
  Future<void> deleteOrder({required String orderId});
}
