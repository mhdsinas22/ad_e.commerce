import 'package:ad_e_commerce/features/orders/bloc/order_bloc.dart';
import 'package:ad_e_commerce/features/orders/bloc/order_event.dart';
import 'package:ad_e_commerce/features/orders/bloc/order_state.dart';
import 'package:ad_e_commerce/features/orders/data/datasource/order_remote_datasouceimpl.dart';
import 'package:ad_e_commerce/features/orders/data/repo/order_repo_impl.dart';
import 'package:ad_e_commerce/features/orders/widgets/order_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final orderdatasourceimpl = OrderRemoteDatasouceimpl(supabase: supabase);
    final orderRepo = OrderRepoImpl(remote: orderdatasourceimpl);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => OrderBloc(orderRepo)
                ..add(LoadOrdersEvent(userid: supabase.auth.currentUser!.id)),
        ),
      ],
      child: OrderPageUi(),
    );
  }
}

class OrderPageUi extends StatelessWidget {
  const OrderPageUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state.status == OrdersStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.status == OrdersStatus.failure) {
            return Center(child: Text("Errpr:${state.errormessege}"));
          }
          if (state.status == OrdersStatus.success) {
            return ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final orders = state.orders[index];
                return OrderItemWidget(
                  orders: orders,
                  orderItem: orders.orderItems[index],
                );
              },
            );
          }
          return Center(child: Text("Noghin woke"));
        },
      ),
    );
  }
}
