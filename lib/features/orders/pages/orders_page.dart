import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
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
  final bool isPushOnly;
  const OrdersPage({super.key, this.isPushOnly = false});

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
      child: OrderPageUi(isPushOnly: isPushOnly),
    );
  }
}

class OrderPageUi extends StatelessWidget {
  final bool isPushOnly;
  const OrderPageUi({super.key, this.isPushOnly = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading:
            isPushOnly
                ? Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.lightGrey,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.pureBlack,
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                )
                : SizedBox(),
        title: AppTexts.semiBold("Orders", fontSize: 18),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state.status == OrdersStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.status == OrdersStatus.failure) {
                return Center(child: Text("Error: ${state.errormessege}"));
              }
              if (state.status == OrdersStatus.success) {
                if (state.orders.isEmpty) {
                  return Center(
                    child: AppTexts.regular("No orders found", fontSize: 16),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.orders.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final order = state.orders[index];
                    // Render all items for each order
                    return Column(
                      children:
                          order.orderItems.map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: OrderItemWidget(
                                orders: order,
                                orderItem: item,
                              ),
                            );
                          }).toList(),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
