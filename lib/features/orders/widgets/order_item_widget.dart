import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/order_item.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/orders.dart';
import 'package:flutter/material.dart';

class OrderItemWidget extends StatelessWidget {
  final Orders orders;
  final OrderItem orderItem;

  const OrderItemWidget({
    super.key,
    required this.orders,
    required this.orderItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Placeholder
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: Image.network(orderItem.productImage)),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 12),

          // Reviews
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const SizedBox(width: 4),
              AppTexts.bold("4.9", fontSize: 14),
              const SizedBox(width: 4),
              AppTexts.regular(
                "(${85}) Reviews",
                fontSize: 12,
                color: AppColors.pureBlack,
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Title
          AppTexts.semiBold(
            "${orderItem.productName}(${orderItem.productId})-${orderItem.productName}",
            fontSize: 16,
          ),
          const SizedBox(height: 4),

          // Model
          AppTexts.regular(
            "Model: ${"modelNumber"}",
            fontSize: 14,
            color: AppColors.pureBlack,
          ),
          const SizedBox(height: 12),

          // Price & Counter
          // AppTexts.bold(
          //   "₹ ${item.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
          //   fontSize: 18,
          // ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
