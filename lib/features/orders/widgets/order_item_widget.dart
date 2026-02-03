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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGrey, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                orderItem.productImage,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported,
                    color: AppColors.grayColor,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Rating
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFFFC107), size: 18),
              const SizedBox(width: 6),
              AppTexts.bold("4.9", fontSize: 14),
              const SizedBox(width: 6),
              AppTexts.regular(
                "(85) Reviews",
                fontSize: 13,
                color: AppColors.grayColor,
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Title
          AppTexts.semiBold(
            orderItem.productName,
            fontSize: 16,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            height: 1.4,
          ),
          const SizedBox(height: 4),

          // Model (using SKU as model number substitute based on initial code)
          AppTexts.regular(
            "Model: ${orderItem.sku}", // derived from previous code intent
            fontSize: 14,
            color: AppColors.grayColor,
          ),
          const SizedBox(height: 12),

          // Price
          AppTexts.bold(
            "₹ ${orderItem.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
            fontSize: 16,
          ),
        ],
      ),
    );
  }
}
