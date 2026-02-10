import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/date_formatter.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/orders.dart';
import 'package:flutter/material.dart';

class TrackingTimelineWidget extends StatelessWidget {
  final String currentStatus;
  final Orders orders;
  const TrackingTimelineWidget({
    super.key,
    required this.currentStatus,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    final steps = [
      {
        'title': 'Order Placed',
        'date': DateFormatter.formatOrderDateTime(orders.createdAt),
        'description': 'Your order has been placed.',
      },
      {
        'title': 'Packed',
        'date': DateFormatter.formatOrderDateTime(orders.packedAt),
        'description': 'Seller has packed your order.',
      },
      {
        'title': 'Shipped',
        'date': DateFormatter.formatOrderDateTime(orders.shippedAt),
        'description':
            'Your item is on the way.\nCourier: BlueDart, Tracking ID: BD123456789,\nEstimated Delivery: 2025-11-02.',
      },
      {
        'title': 'Delivered',
        'date': DateFormatter.formatOrderDateTime(orders.deliveredAt),
        'description': '',
      },
    ];

    int currentStepIndex = 0;
    if (currentStatus.toLowerCase() == 'placed') {
      currentStepIndex = 0;
    } else if (currentStatus.toLowerCase() == 'packed') {
      currentStepIndex = 1;
    } else if (currentStatus.toLowerCase() == 'shipped' ||
        currentStatus.toLowerCase() == 'in transit') {
      currentStepIndex = 2;
    }
    // 'In Transit' maps to Shipped step actively
    else if (currentStatus.toLowerCase() == 'delivered') {
      currentStepIndex = 3;
    }

    return Container(
      padding: const EdgeInsets.all(24),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts.bold("Order Details", fontSize: 18),
          const SizedBox(height: 24),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: steps.length,
            itemBuilder: (context, index) {
              final step = steps[index];
              final isCompleted = index <= currentStepIndex;
              final isCurrent = index == currentStepIndex;
              final isLast = index == steps.length - 1;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color:
                              isCompleted
                                  ? Colors.green
                                  : (isCurrent
                                      ? AppColors.primaryBlue
                                      : const Color(0xFFE0E0E0)),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            isCompleted
                                ? Icons.check
                                : (index == 2
                                    ? Icons.local_shipping_outlined
                                    : Icons
                                        .circle), // Status specific icons if needed
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 60, // Fixed height connector
                          color:
                              isCompleted
                                  ? Colors.green
                                  : const Color(0xFFE0E0E0),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTexts.semiBold(
                          step['title']!,
                          fontSize: 16,
                          color: Colors.black, // Always black title
                        ),
                        const SizedBox(height: 4),
                        AppTexts.regular(
                          step['date']!,
                          fontSize: 13,
                          color: AppColors.grayColor,
                        ),
                        if (step['description']!.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          AppTexts.regular(
                            step['description']!,
                            fontSize: 14,
                            color: Colors.black87,
                            maxLines: 5,
                            height: 1.4,
                          ),
                        ],
                        SizedBox(
                          height: !isLast ? 32 : 0,
                        ), // Spacing between items
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
