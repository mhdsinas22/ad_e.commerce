import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/orders/bloc/order_bloc.dart';
import 'package:ad_e_commerce/features/orders/bloc/order_event.dart';
import 'package:ad_e_commerce/features/orders/bloc/order_state.dart';
import 'package:ad_e_commerce/features/orders/data/datasource/order_remote_datasouceimpl.dart';
import 'package:ad_e_commerce/features/orders/data/repo/order_repo_impl.dart';
import 'package:ad_e_commerce/features/orders/pages/guest_order_page.dart';
import 'package:ad_e_commerce/features/orders/widgets/order_item_widget.dart';
import 'package:ad_e_commerce/features/profile/data/datasource/wallet_remote_datasource_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrdersPage extends StatelessWidget {
  final bool isPushOnly;
  const OrdersPage({super.key, this.isPushOnly = false});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    if (user == null) {
      return GuestOrdersUI(isScaffold: isPushOnly);
    }
    final orderdatasourceimpl = OrderRemoteDatasouceimpl(supabase: supabase);
    final walletRemotedatasourceimpl = WalletRemoteDatasourceImpl(supabase);
    final orderRepo = OrderRepoImpl(
      remote: orderdatasourceimpl,
      walletRemoteDataSource: walletRemotedatasourceimpl,
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  OrderBloc(orderRepo)..add(LoadOrdersEvent(userid: user.id)),
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
          constraints: const BoxConstraints(maxWidth: 1200),
          child: BlocConsumer<OrderBloc, OrderState>(
            listener: (context, state) {
              if (state.status == OrdersStatus.success &&
                  state.isCancelSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: AppTexts.medium(
                      "Order cancelled successfully",
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state.status == OrdersStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: AppTexts.medium(
                      state.errormessege,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
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

                final screenWidth = MediaQuery.of(context).size.width;

                if (screenWidth >= 600) {
                  // Desktop and Tablet: Grid layout
                  final List<Map<String, dynamic>> flatOrderItems = [];
                  for (var order in state.orders) {
                    for (var item in order.orderItems) {
                      flatOrderItems.add({'order': order, 'item': item});
                    }
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 550, // Automatically adjusts columns
                      mainAxisExtent: 290, // Safe height without overflow
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: flatOrderItems.length,
                    itemBuilder: (context, index) {
                      final order = flatOrderItems[index]['order'];
                      final item = flatOrderItems[index]['item'];
                      return OrderItemWidget(orders: order, orderItem: item);
                    },
                  );
                }

                // Mobile: untouched (original behavior)
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
