import 'package:ad_e_commerce/core/utils/app_logger.dart';
import 'package:ad_e_commerce/features/orders/bloc/order_event.dart';
import 'package:ad_e_commerce/features/orders/bloc/order_state.dart';

import 'package:ad_e_commerce/features/orders/domain/repo/order_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepo orderRepo;
  OrderBloc(this.orderRepo) : super(OrderState()) {
    on<CreateOrderEvent>(_createOrder);
    on<LoadOrdersEvent>(_loadOrders);
    on<CancelOrderEvent>(_cancelOrder);
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
      emit(state.copyWith(status: OrdersStatus.success));
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
      await orderRepo.updateOrderStatus(
        orderId: event.orderId,
        status: 'cancelled',
      );
      // Optional: Store cancel reason if backend supports it. Currently just changing status.

      // Re-fetch orders to reflect the change
      final orders = await orderRepo.getOrders(userId: event.userId);
      emit(state.copyWith(status: OrdersStatus.success, orders: orders));
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
