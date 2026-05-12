import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/core/widgets/app_text.dart';
import 'package:aerstore/features/orders/domain/enities/order_item.dart';
import 'package:aerstore/features/orders/domain/enities/orders.dart';
import 'package:aerstore/features/orders/widgets/need_help_widget.dart';
import 'package:aerstore/features/orders/widgets/tracking_product_card.dart';
import 'package:aerstore/features/orders/widgets/tracking_timeline_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderDetailsPage extends StatelessWidget {
  final Orders order;
  final OrderItem orderItem;

  const OrderDetailsPage({
    super.key,
    required this.order,
    required this.orderItem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
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
              onPressed: () => context.pop(),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        title: AppTexts.semiBold("Track Order", fontSize: 18),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 800,
          ), // Max width for desktop
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TrackingProductCard(order: order, orderItem: orderItem),
                const SizedBox(height: 24),
                TrackingTimelineWidget(
                  currentStatus: order.status,
                  orders: order,
                ),
                const SizedBox(height: 24),
                const NeedHelpWidget(),
                const SizedBox(height: 48), // Bottom spacing
              ],
            ),
          ),
        ),
      ),
    );
  }
}
