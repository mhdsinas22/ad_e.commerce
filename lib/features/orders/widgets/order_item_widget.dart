import 'package:aerstore/core/routes/route_names.dart';
import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/core/widgets/app_text.dart';
import 'package:aerstore/core/widgets/primary_button.dart';
import 'package:aerstore/features/orders/bloc/order_bloc.dart';
import 'package:aerstore/features/orders/bloc/order_event.dart';
import 'package:aerstore/features/orders/domain/enities/order_item.dart';
import 'package:aerstore/features/orders/domain/enities/orders.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderItemWidget extends StatelessWidget {
  final Orders orders;
  final OrderItem orderItem;

  const OrderItemWidget({
    super.key,
    required this.orders,
    required this.orderItem,
  });

  void _showCancelBottomSheet(BuildContext context) {
    String selectedReason = 'Changed my mind';
    final reasons = [
      'Changed my mind',
      'Found a better price',
      'Delivery taking too long',
      'Ordered by mistake',
      'Other',
    ];
    final orderBloc = context.read<OrderBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (innerContext, setState) {
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    AppTexts.semiBold("Cancel Order?", fontSize: 20),
                    const SizedBox(height: 8),
                    AppTexts.regular(
                      "Are you sure you want to cancel this order? This action cannot be undone.",
                      fontSize: 14,
                      color: AppColors.grayColor,
                    ),
                    const SizedBox(height: 24),
                    AppTexts.medium("Reason for cancellation", fontSize: 14),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedReason,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items:
                              reasons.map((String reason) {
                                return DropdownMenuItem<String>(
                                  value: reason,
                                  child: AppTexts.regular(reason, fontSize: 14),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedReason = newValue;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => context.pop(),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(
                                color: AppColors.lightGrey,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: AppTexts.medium("Keep Order", fontSize: 16),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              final user =
                                  Supabase.instance.client.auth.currentUser;
                              if (user != null && orders.id != null) {
                                orderBloc.add(
                                  CancelOrderEvent(
                                    order: orders,
                                    reason: selectedReason,
                                  ),
                                );
                              }
                              context.pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: AppTexts.medium(
                              "Confirm Cancel",
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStatusBadge() {
    final status = orders.status.toLowerCase();

    if (status == 'cancelled') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cancel, color: Colors.red, size: 16),
            const SizedBox(width: 4),
            AppTexts.medium("Cancelled", color: Colors.red, fontSize: 12),
          ],
        ),
      );
    } else if (status == 'delivered') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 16),
            const SizedBox(width: 4),
            AppTexts.medium("Delivered", color: Colors.green, fontSize: 12),
          ],
        ),
      );
    } else if (status == 'shipped') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.local_shipping, color: Colors.blue, size: 16),
            const SizedBox(width: 4),
            AppTexts.medium("Shipped", color: Colors.blue, fontSize: 12),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.access_time_filled, color: AppColors.orange, size: 16),
            const SizedBox(width: 4),
            AppTexts.medium(
              "Processing",
              color: AppColors.orange,
              fontSize: 12,
            ),
          ],
        ),
      );
    }
  }

  Widget _buildActionButtons(BuildContext context) {
    final status = orders.status.toLowerCase();

    if (status == 'cancelled') {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: AppTexts.medium(
            "Order Cancelled",
            color: Colors.red,
            fontSize: 14,
          ),
        ),
      );
    }

    if (status == 'delivered') {
      return OutlinedButton(
        onPressed: () {
          // Future return implementation
        },
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 44),
          side: const BorderSide(color: AppColors.lightGrey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: AppTexts.medium("Return / Replace", fontSize: 14),
      );
    }

    if (status == 'shipped') {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: AppTexts.medium(
            "Cannot cancel after shipping",
            color: AppColors.grayColor,
            fontSize: 14,
          ),
        ),
      );
    }

    // Pending / Processing / Placed / Packed
    return OutlinedButton(
      onPressed: () => _showCancelBottomSheet(context),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 44),
        side: const BorderSide(color: Colors.red),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: AppTexts.medium("Cancel Order", color: Colors.red, fontSize: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTexts.medium(
                "Order #${orders.orderNumber.toString()}",
                fontSize: 14,
                color: AppColors.grayColor,
              ),
              _buildStatusBadge(),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.lightGrey),
          const SizedBox(height: 16),

          // Body Content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 90,
                height: 90,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTexts.semiBold(
                      "${orderItem.productName}${orderItem.productStorge.isEmpty ? "" : " (${orderItem.productStorge})"}",
                      fontSize: 16,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      height: 1.3,
                    ),
                    const SizedBox(height: 4),
                    AppTexts.regular(
                      "Model: ${orderItem.productModelNumber}",
                      fontSize: 13,
                      color: AppColors.grayColor,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFFFC107),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        AppTexts.medium(
                          orderItem.productrating.toString(),
                          fontSize: 13,
                        ),
                        const SizedBox(width: 4),
                        AppTexts.regular(
                          "(${orderItem.productNoOfRating})",
                          fontSize: 12,
                          color: AppColors.grayColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    AppTexts.bold(
                      "₹ ${orderItem.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                      fontSize: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Action Buttons
          Row(
            children: [
              Expanded(child: _buildActionButtons(context)),
              const SizedBox(width: 12),
              Expanded(
                child: PrimaryButton(
                  fontsize: 14,
                  height: 44,
                  text: "View Details",
                  onPressed: () {
                    context.pushNamed(
                      RouteNames.orderDetails,
                      extra: {"order": orders, "orderItem": orderItem},
                    );
                  },
                  borderRadius: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
