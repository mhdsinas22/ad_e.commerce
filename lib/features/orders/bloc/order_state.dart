import 'package:ad_e_commerce/features/orders/domain/enities/order_item.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/orders.dart';

enum OrdersStatus { initial, loading, success, failure }

class OrderState {
  final OrdersStatus status;
  final String errormessege;
  final List<Orders> orders;
  final List<OrderItem> orderitems;
  OrderState({
    this.status = OrdersStatus.initial,
    this.errormessege = "",
    this.orderitems = const [],
    this.orders = const [],
  });
  OrderState copyWith({
    OrdersStatus? status,
    String? errormessege,
    List<Orders>? orders,
    List<OrderItem>? orderitems,
  }) {
    return OrderState(
      status: status ?? this.status,
      errormessege: errormessege ?? this.errormessege,
      orders: orders ?? this.orders,
      orderitems: orderitems ?? this.orderitems,
    );
  }
}
