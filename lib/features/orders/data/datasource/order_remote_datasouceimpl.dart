import 'package:aerstore/core/utils/app_logger.dart';
import 'package:aerstore/features/orders/data/datasource/order_remote_datasource.dart';
import 'package:aerstore/features/orders/data/models/order_item_model.dart';
import 'package:aerstore/features/orders/data/models/order_model.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class OrderRemoteDatasouceimpl implements OrderRemoteDatasource {
  final SupabaseClient supabase;
  OrderRemoteDatasouceimpl({required this.supabase});
  @override
  Future<String> createOrder(
    OrderModel orders,
    List<OrderItemModel> orderitems,
  ) async {
    try {
      // 1. Loop Each order item
      for (var item in orderitems) {
        final productId = item.productId;
        final orderQty = item.quantity;
        // 2. Get All stocks of that Product
        final stocks = await supabase
            .from("product_stocks")
            .select()
            .eq("product_id", productId)
            .order("quantity", ascending: false);
        if (stocks.isEmpty) {
          throw Exception("No stock available");
        }
        // 3. Check total Stock
        int totalStock = 0;
        for (var stock in stocks) {
          totalStock += stock["quantity"] as int;
        }
        if (totalStock < orderQty) {
          throw Exception("No stock available");
        }
        // 4. split deduction Logic
        int remaining = orderQty;
        for (var stock in stocks) {
          if (remaining == 0) break;
          int storeQty = stock["quantity"] as int;
          int deduct = remaining > storeQty ? storeQty : remaining;
          await supabase
              .from("product_stocks")
              .update({"quantity": storeQty - deduct})
              .eq("id", stock["id"]);
          remaining -= deduct;
        }
      }
      final res =
          await supabase
              .from("orders")
              .insert(orders.toJson())
              .select()
              .single();
      return res["id"] as String;
    } catch (e) {
      AppLogger.error("CREATE ORDER ERROR: ${e.toString()}");
      throw Exception("Create order failed: $e");
    }
  }

  @override
  Future<void> createOrderItems(
    String orderId,
    List<OrderItemModel> items,
  ) async {
    try {
      final data = items.map((e) => e.toJson(orderID: orderId)).toList();
      await supabase.from("order_items").insert(data);
    } catch (e) {
      AppLogger.error("CREATE ORDER ITEMS ERROR: ${e.toString()}");
      throw Exception("Create order items failed: $e");
    }
  }

  @override
  Future<List<OrderModel>> getOrders({required String userId}) async {
    try {
      final res = await supabase
          .from("orders")
          .select('''
          *,
          order_items (*),
          order_logistics(*)
        ''')
          .eq("user_id", userId)
          .order('created_at', ascending: false);

      return res.map<OrderModel>((e) => OrderModel.fromJson(e)).toList();
    } catch (e) {
      AppLogger.error("GET ORDERS ERROR: ${e.toString()}");
      throw Exception("GET order failed: $e");
    }
  }

  @override
  Future<List<OrderItemModel>> getOrderItems({required String orderId}) async {
    try {
      final res = await supabase
          .from("order_items")
          .select()
          .eq("order_id", orderId);
      return res.map((e) => OrderItemModel.fromJson(e)).toList();
    } catch (e) {
      AppLogger.error("GET ORDER ITEMS ERROR: ${e.toString()}");
      throw Exception("GET orderItems failed: $e");
    }
  }

  @override
  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
    String? cancelReason,
    DateTime? cancelledAt,
  }) async {
    try {
      final updateData = <String, dynamic>{"status": status};
      if (cancelReason != null) updateData["cancel_reason"] = cancelReason;
      if (cancelledAt != null) {
        updateData["cancelled_at"] = cancelledAt.toIso8601String();
      }

      await supabase.from("orders").update(updateData).eq("id", orderId);
    } catch (e) {
      AppLogger.error("UPDATE ORDER ERROR: ${e.toString()}");
      throw Exception("Updtae order failed: $e");
    }
  }

  @override
  Future<void> deleteOrder({required String orderId}) async {
    try {
      await supabase.from("orders").delete().eq("id", orderId);
    } catch (e) {
      AppLogger.error("DELETE ORDER ERROR: ${e.toString()}");
      throw Exception("DELTE order failed: $e");
    }
  }
}
