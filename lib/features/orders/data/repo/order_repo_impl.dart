import 'package:ad_e_commerce/core/utils/app_logger.dart';
import 'package:ad_e_commerce/features/orders/data/datasource/order_remote_datasource.dart';
import 'package:ad_e_commerce/features/orders/data/models/order_item_model.dart';
import 'package:ad_e_commerce/features/orders/data/models/order_model.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/order_item.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/orders.dart';
import 'package:ad_e_commerce/features/orders/domain/repo/order_repo.dart';
import 'package:ad_e_commerce/features/profile/data/datasource/wallet_remote_datasource.dart';

class OrderRepoImpl implements OrderRepo {
  final OrderRemoteDatasource remote;
  final WalletRemoteDataSource walletRemoteDataSource;
  OrderRepoImpl({required this.remote, required this.walletRemoteDataSource});
  @override
  Future<String> createOrder({
    required Orders order,
    required List<OrderItem> orderitems,
  }) async {
    try {
      // 1️ Create order
      final ordermodel = OrderModel.fromEntity(order);
      final orderiitemModel =
          orderitems.map((e) => OrderItemModel.fromEntity(e)).toList();
      final orderId = await remote.createOrder(ordermodel, orderiitemModel);

      // 2 Create order items
      await remote.createOrderItems(
        orderId,
        orderitems.map((e) => OrderItemModel.fromEntity(e)).toList(),
      );

      double payableAmount = order.totalAmount;

      // 3 Wallet use cheythal mathram
      if (order.walletUsed > 0) {
        await walletRemoteDataSource.debitWalletForOrder(
          userId: order.userId,
          amount: order.walletUsed,
        );

        AppLogger.info("wallet used amount :- ${order.walletUsed}");

        payableAmount = order.totalAmount - order.walletUsed;
      }

      // 4 Reward points (payable amount base cheyth)
      final points = payableAmount ~/ 100;
      if (points >= 0) {
        await walletRemoteDataSource.addRewardAsWallet(order.userId, points);
      }

      return orderId;
    } catch (e) {
      AppLogger.error("Create Order Repo Error:-${e.toString()}");
      throw Exception("Create order Repo failed: $e");
    }
  }

  @override
  Future<List<Orders>> getOrders({required String userId}) async {
    try {
      final orders = await remote.getOrders(userId: userId);
      return orders;
    } catch (e) {
      AppLogger.error("Get Order Repo Error:-${e.toString()}");
      throw Exception("Get order REpo failed: $e");
    }
  }

  @override
  Future<List<OrderItem>> getOrderItems({required String orderId}) async {
    try {
      final orders = await remote.getOrderItems(orderId: orderId);
      return orders;
    } catch (e) {
      AppLogger.error("Get OrderItems Repo Error:-${e.toString()}");
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
      AppLogger.error("Update Order Repo Error:-${e.toString()}");
      throw Exception("Update order REpo failed: $e");
    }
  }

  @override
  Future<void> cancelOrder({
    required Orders order,
    required String reason,
  }) async {
    try {
      if (order.id == null) return;

      // Update order status and set reason/time
      await remote.updateOrderStatus(
        orderId: order.id!,
        status: 'cancelled',
        cancelReason: reason,
        cancelledAt: DateTime.now(),
      );

      // Refund wallet amount if wallet was used
      // if (order.walletUsed > 0) {
      //   await walletRemoteDataSource.refundWallet(
      //     order.userId,
      //     order.walletUsed,
      //     'Refund for cancelled order #${order.id?.substring(0, 8).toUpperCase()}',
      //   );
      // }
    } catch (e) {
      AppLogger.error("Cancel Order Repo Error:-${e.toString()}");
      throw Exception("Cancel order Repo failed: $e");
    }
  }

  @override
  Future<void> deleteOrder({required String orderId}) async {
    try {
      return remote.deleteOrder(orderId: orderId);
    } catch (e) {
      AppLogger.error("Delete Order Repo Error:-${e.toString()}");
      throw Exception("Delete order REpo failed: $e");
    }
  }
}
