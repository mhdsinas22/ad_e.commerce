import 'package:ad_e_commerce/features/orders/data/models/order_item_model.dart';
import 'package:ad_e_commerce/features/orders/data/models/order_model.dart';

abstract class OrderRemoteDatasource {
  Future<String> createOrder(OrderModel orders);
  Future<void> createOrderItems(String orderId, List<OrderItemModel> items);
  Future<List<OrderModel>> getOrders({required String userId});
  Future<List<OrderItemModel>> getOrderItems({required String orderId});
  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
  });
  Future<void> deleteOrder({required String orderId});
}
