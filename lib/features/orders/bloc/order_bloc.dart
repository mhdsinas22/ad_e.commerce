import 'package:aerstore/core/utils/app_logger.dart';
import 'package:aerstore/features/orders/bloc/order_event.dart';
import 'package:aerstore/features/orders/bloc/order_state.dart';
import 'package:aerstore/features/orders/domain/repo/order_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepo orderRepo;
  OrderBloc(this.orderRepo) : super(OrderState()) {
    on<CreateOrderEvent>(_createOrder);
    on<LoadOrdersEvent>(_loadOrders);
    on<CancelOrderEvent>(_cancelOrder);
    on<ClearOrdersEvent>(_clearOrders);
  }

  void _clearOrders(ClearOrdersEvent event, Emitter<OrderState> emit) {
    emit(OrderState());
  }
  Future<void> _createOrder(
    CreateOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(status: OrdersStatus.loading));
    try {
      await orderRepo.createOrder(
        order: event.orders,
        orderitems: event.orderitems,
      );
      await Future.delayed(const Duration(seconds: 2));
      await Supabase.instance.client.functions.invoke(
        "send-notification",
        body: {"type": "new_order"},
      );
      final orders = await orderRepo.getOrders(userId: event.orders.userId);
      emit(state.copyWith(status: OrdersStatus.success, orders: orders));
    } catch (e) {
      AppLogger.error("Order Error:-${e.toString()}");
      emit(
        state.copyWith(
          status: OrdersStatus.failure,
          errormessege: e.toString(),
        ),
      );
    }
  }

  Future<void> _loadOrders(
    LoadOrdersEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(status: OrdersStatus.loading));
    try {
      final orders = await orderRepo.getOrders(userId: event.userid);
      emit(
        state.copyWith(
          status: OrdersStatus.success,
          orders: orders,
          orderitems: [],
          isCancelSuccess: false,
        ),
      );
    } catch (e) {
      AppLogger.error("Order Error:-${e.toString()}");
      emit(
        state.copyWith(
          status: OrdersStatus.failure,
          errormessege: e.toString(),
        ),
      );
    }
  }

  Future<void> _cancelOrder(
    CancelOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(state.copyWith(status: OrdersStatus.loading));
    try {
      await orderRepo.cancelOrder(order: event.order, reason: event.reason);

      if (event.order.paymentMethod == 'online') {}

      // Re-fetch orders to reflect the change
      final orders = await orderRepo.getOrders(userId: event.order.userId);
      emit(
        state.copyWith(
          status: OrdersStatus.success,
          orders: orders,
          isCancelSuccess: true,
        ),
      );
    } catch (e) {
      AppLogger.error("Order Cancel Error:-${e.toString()}");
      emit(
        state.copyWith(
          status: OrdersStatus.failure,
          errormessege: e.toString(),
        ),
      );
    }
  }
}
