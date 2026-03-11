import 'package:ad_e_commerce/core/constants/app_icons.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_bloc.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_event.dart';
import 'package:ad_e_commerce/features/cart/domain/enities/cart_item.dart';
import 'package:ad_e_commerce/features/cart/presentation/widgets/cart_counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final storagetext =
        item.storeage.isEmpty
            ? item.color
            : "${(item.storeage)} - ${(item.color)}";
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
                child: Center(child: Image.network(item.imageUrl)),
              ),
              const Spacer(),
              // Delete Icon
              GestureDetector(
                onTap:
                    () => context.read<CartBloc>().add(
                      RemoveCartItemEvent(cartitemid: item.id!),
                    ),
                child: Image.asset(AppIcons.deleteIcon),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Reviews
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const SizedBox(width: 4),
              AppTexts.bold(item.rating, fontSize: 14),
              const SizedBox(width: 4),
              AppTexts.regular(
                "(${item.noOfRating}) Reviews",
                fontSize: 12,
                color: AppColors.pureBlack,
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Title
          AppTexts.semiBold("${item.title} $storagetext", fontSize: 16),
          const SizedBox(height: 4),

          // Model
          AppTexts.regular(
            "Model: ${item.modelNumber}",
            fontSize: 14,
            color: AppColors.pureBlack,
          ),
          const SizedBox(height: 12),

          // Price & Counter
          AppTexts.bold(
            "₹ ${item.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
            fontSize: 18,
          ),
          const SizedBox(height: 12),
          CartCounterWidget(
            quantity: item.quantity,

            onIncrement: () {
              context.read<CartBloc>().add(
                UpdateCartItemEvent(
                  cartItemid: item.id!,
                  currentQty: item.quantity + 1,
                ),
              );
            },

            onDecrement: () {
              if (item.quantity > 1) {
                context.read<CartBloc>().add(
                  UpdateCartItemEvent(
                    cartItemid: item.id!,
                    currentQty: item.quantity - 1,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
