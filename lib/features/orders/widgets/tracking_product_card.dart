import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/order_item.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/orders.dart';
import 'package:flutter/material.dart';

class TrackingProductCard extends StatelessWidget {
  final Orders order;
  final OrderItem orderItem;

  const TrackingProductCard({
    super.key,
    required this.order,
    required this.orderItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGrey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
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
          const SizedBox(width: 16),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts.semiBold(
                  "${orderItem.productName} ${orderItem.productStorge.isNotEmpty ? "(${orderItem.productStorge}) - " : ""}${orderItem.productColor}",
                  fontSize: 16,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                AppTexts.regular(
                  "Model: ${orderItem.productModelNumber}",
                  fontSize: 14,
                  color: AppColors.grayColor,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTexts.bold(
                      "₹ ${orderItem.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                      fontSize: 18,
                    ),
                    if (order.status.toLowerCase() == 'packed' ||
                        order.status.toLowerCase() == 'placed') ...[
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: AppColors.orange,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          AppTexts.medium(
                            "Processing",
                            color: AppColors.orange,
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ],
                    if (order.status.toLowerCase() == 'shipped') ...[
                      Row(
                        children: [
                          Icon(
                            Icons
                                .local_shipping_outlined, // Better icon matching design
                            color: AppColors.primaryBlack,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          AppTexts.medium(
                            "shipped",
                            color: AppColors.primaryBlack,
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ],

                    if (order.status.toLowerCase() == 'delivered') ...[
                      Row(
                        children: [
                          Icon(
                            Icons
                                .check_circle_outline, // Better icon matching design
                            color: Colors.green,
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          AppTexts.medium(
                            "Delivered",
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
