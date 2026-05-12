import 'package:aerstore/features/orders/domain/enities/order_item.dart';
import 'package:aerstore/features/orders/domain/enities/orders.dart';

enum OrdersStatus { initial, loading, success, failure }

class OrderState {
  final OrdersStatus status;
  final String errormessege;
  final List<Orders> orders;
  final List<OrderItem> orderitems;
  final bool isCancelSuccess;
  OrderState({
    this.status = OrdersStatus.initial,
    this.errormessege = "",
    this.orderitems = const [],
    this.orders = const [],
    this.isCancelSuccess = false,
  });
  OrderState copyWith({
    OrdersStatus? status,
    String? errormessege,
    List<Orders>? orders,
    List<OrderItem>? orderitems,
    bool? isCancelSuccess,
  }) {
    return OrderState(
      status: status ?? this.status,
      errormessege: errormessege ?? this.errormessege,
      orders: orders ?? this.orders,
      orderitems: orderitems ?? this.orderitems,
      isCancelSuccess: isCancelSuccess ?? this.isCancelSuccess,
    );
  }
}
