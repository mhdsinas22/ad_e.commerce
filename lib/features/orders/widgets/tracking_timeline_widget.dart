import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/core/utils/date_formatter.dart';
import 'package:aerstore/core/widgets/app_text.dart';
import 'package:aerstore/features/orders/domain/enities/orders.dart';
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
    final logistics =
        orders.logistics != null && orders.logistics!.isNotEmpty
            ? orders.logistics!.first
            : null;
    final isCancelled = currentStatus.toLowerCase() == 'cancelled';

    final List<Map<String, dynamic>> steps =
        isCancelled
            ? [
              {
                'title': 'Order Placed',
                'date': DateFormatter.formatOrderDateTime(orders.createdAt),
                'description': 'Your order has been placed.',
              },
              {
                'title': 'Cancelled',
                'date': '16 Mar 2026', // Based on prompt requirement
                'description': 'Your order has been cancelled.',
              },
            ]
            : [
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
                'descriptionWidget': (BuildContext context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTexts.regular("In Transit"),
                      AppTexts.regular("Your item is on the way."),
                      const SizedBox(height: 4),
                      AppTexts.regular(
                        "Courier: ${logistics?.courierPartner ?? "-"}",
                      ),
                      AppTexts.regular(
                        "Tracking ID: ${logistics?.trackingNumber ?? "-"}",
                      ),
                      AppTexts.regular(
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        maxLines: null,
                        "Location: ${logistics?.pickupLocation ?? "-"}",
                      ),
                      AppTexts.regular(
                        maxLines: null,
                        overflow: TextOverflow.visible,
                        softWrap: true,
                        "Estimated Delivery: ${logistics?.pickupDate != null ? DateFormatter.formatDate(logistics!.pickupDate.toString()) : "-"}",
                      ),
                    ],
                  );
                },
              },
              {
                'title': 'Delivered',
                'date': DateFormatter.formatOrderDateTime(orders.deliveredAt),
                'description': '',
              },
            ];

    int currentStepIndex = 0;
    if (isCancelled) {
      currentStepIndex = 1;
    } else if (currentStatus.toLowerCase() == 'placed') {
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
              final isCancelledStep = isCancelled && index == 1;

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
                              isCancelledStep
                                  ? Colors.red
                                  : (isCompleted
                                      ? Colors.green
                                      : (isCurrent
                                          ? AppColors.primaryBlack
                                          : const Color(0xFFE0E0E0))),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            isCancelledStep
                                ? Icons.close
                                : (isCompleted
                                    ? Icons.check
                                    : (index == 2
                                        ? Icons.local_shipping_outlined
                                        : Icons.circle)),
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
                              isCancelledStep
                                  ? Colors
                                      .transparent // No connector after cancelled, or if there is, but it's the last step anyway
                                  : (isCompleted
                                      ? Colors.green
                                      : const Color(0xFFE0E0E0)),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTexts.semiBold(
                          step['title'],
                          fontSize: 16,
                          color: isCancelledStep ? Colors.red : Colors.black,
                        ),
                        const SizedBox(height: 4),
                        AppTexts.regular(
                          step['date'],
                          fontSize: 13,
                          color:
                              isCancelledStep
                                  ? Colors.red.shade300
                                  : AppColors.grayColor,
                        ),
                        if (step['descriptionWidget'] != null) ...[
                          const SizedBox(height: 4),
                          step["descriptionWidget"](context),
                          // AppTexts.regular(
                          //   step['description'],
                          //   fontSize: 14,
                          //   color:
                          //       isCancelledStep
                          //           ? Colors.red.shade900
                          //           : Colors.black87,
                          //   softWrap: true,
                          //   overflow: TextOverflow.visible,
                          //   height: 1.4,
                          // ),
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
