import 'package:ad_e_commerce/features/orders/domain/enities/order_item.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/orders.dart';

abstract class OrderEvent {}

class CreateOrderEvent extends OrderEvent {
  final Orders orders;
  final List<OrderItem> orderitems;
  CreateOrderEvent({required this.orders, required this.orderitems});
}

class LoadOrdersEvent extends OrderEvent {
  final String userid;
  LoadOrdersEvent({required this.userid});
}
