import 'package:ad_e_commerce/features/orders/data/datasource/order_remote_datasource.dart';
import 'package:ad_e_commerce/features/orders/data/models/order_item_model.dart';
import 'package:ad_e_commerce/features/orders/data/models/order_model.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class OrderRemoteDatasouceimpl implements OrderRemoteDatasource {
  final SupabaseClient supabase;
  OrderRemoteDatasouceimpl({required this.supabase});
  @override
  Future<String> createOrder(OrderModel orders) async {
    try {
      final res =
          await supabase
              .from("orders")
              .insert(orders.toJson())
              .select()
              .single();
      return res["id"] as String;
    } catch (e) {
      print("Crete order error:_${e.toString()}");
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
      print("Create order items  ERROR:_${e.toString()}");
      throw Exception("Create order items failed: $e");
    }
  }

  @override
  Future<List<OrderModel>> getOrders({required String userId}) async {
    try {
      final res = await supabase.from("orders").select().eq("user_id", userId);
      return res.map((e) => OrderModel.fromJson(e)).toList();
    } catch (e) {
      print("GET ORDERS ERROR:_${e.toString()}");
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
      print("GET ORDERSITEms ERROR:_${e.toString()}");
      throw Exception("GET orderItems failed: $e");
    }
  }

  @override
  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
  }) async {
    try {
      await supabase
          .from("orders")
          .update({"status": status})
          .eq("id", orderId);
    } catch (e) {
      print(" UPDAYE  ERROR:_${e.toString()}");
      throw Exception("Updtae order failed: $e");
    }
  }

  @override
  Future<void> deleteOrder({required String orderId}) async {
    try {
      await supabase.from("orders").delete().eq("id", orderId);
    } catch (e) {
      print(" DELETE  ERROR:_${e.toString()}");
      throw Exception("DELTE order failed: $e");
    }
  }
}
