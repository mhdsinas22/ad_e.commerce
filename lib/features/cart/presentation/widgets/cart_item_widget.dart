import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/cart/presentation/dummy/cart_dummy_data.dart';
import 'package:ad_e_commerce/features/cart/presentation/widgets/cart_counter_widget.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel item;

  const CartItemWidget({super.key, required this.item});

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
                child: Center(
                  child: Icon(
                    Icons
                        .headphones, // Placeholder icon as commonly seen with airpods/phones
                    color: AppColors.grayColor.withOpacity(0.5),
                    size: 40,
                  ),
                ),
              ),
              const Spacer(),
              // Delete Icon
              Icon(Icons.delete_outline, color: Colors.black54, size: 24),
            ],
          ),
          const SizedBox(height: 12),

          // Reviews
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const SizedBox(width: 4),
              AppTexts.bold("${item.rating}", fontSize: 14),
              const SizedBox(width: 4),
              AppTexts.regular(
                "(${item.reviewCount}) Reviews",
                fontSize: 12,
                color: AppColors.grayColor,
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Title
          AppTexts.semiBold(item.title, fontSize: 16),
          const SizedBox(height: 4),

          // Model
          AppTexts.regular(item.model, fontSize: 14, color: Colors.black54),
          const SizedBox(height: 12),

          // Price & Counter
          AppTexts.bold(
            "₹ ${item.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
            fontSize: 18,
          ),
          const SizedBox(height: 12),

          CartCounterWidget(
            quantity: item.quantity,
            onDecrement: () {},
            onIncrement: () {},
          ),
        ],
      ),
    );
  }
}
