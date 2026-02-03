import 'package:ad_e_commerce/features/orders/data/datasource/order_remote_datasource.dart';
import 'package:ad_e_commerce/features/orders/data/models/order_item_model.dart';
import 'package:ad_e_commerce/features/orders/data/models/order_model.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/order_item.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/orders.dart';
import 'package:ad_e_commerce/features/orders/domain/repo/order_repo.dart';

class OrderRepoImpl implements OrderRepo {
  final OrderRemoteDatasource remote;
  OrderRepoImpl({required this.remote});
  @override
  Future<String> createOrder({
    required Orders order,
    required List<OrderItem> orderitems,
  }) async {
    try {
      // 1️⃣ entity → model
      final ordermodel = OrderModel.fromEntity(order);

      // 2️⃣ create order
      final orderId = await remote.createOrder(ordermodel);

      // 3️⃣ IMPORTANT: await order items
      await remote.createOrderItems(
        orderId,
        orderitems.map((e) => OrderItemModel.fromEntity(e)).toList(),
      );

      return orderId;
    } catch (e) {
      print("Create order Repo error: $e");
      throw Exception("Create order Repo failed: $e");
    }
  }

  @override
  Future<List<Orders>> getOrders({required String userId}) async {
    try {
      final orders = await remote.getOrders(userId: userId);
      return orders;
    } catch (e) {
      print("Get order Repo error:_${e.toString()}");
      throw Exception("Get order REpo failed: $e");
    }
  }

  @override
  Future<List<OrderItem>> getOrderItems({required String orderId}) async {
    try {
      final orders = await remote.getOrderItems(orderId: orderId);
      return orders;
    } catch (e) {
      print("Get orderitems Repo error:_${e.toString()}");
      throw Exception("Get orderitems REpo failed: $e");
    }
  }

  @override
  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
  }) async {
    try {
      return remote.updateOrderStatus(orderId: orderId, status: status);
    } catch (e) {
      print("Update order Repo error:_${e.toString()}");
      throw Exception("Update order REpo failed: $e");
    }
  }

  @override
  Future<void> deleteOrder({required String orderId}) async {
    try {
      return remote.deleteOrder(orderId: orderId);
    } catch (e) {
      print("Update order Repo error:_${e.toString()}");
      throw Exception("Update order REpo failed: $e");
    }
  }
}
