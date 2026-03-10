import 'package:flutter/material.dart';

import 'shimmer_card.dart';
import 'shimmer_container.dart';
import 'shimmer_text.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerCard(
      width: 160,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          const ShimmerContainer(
            width: double.infinity,
            height: 120,
            borderRadius: 12,
          ),
          const SizedBox(height: 12),
          // Title placeholder
          const ShimmerText(lines: 2, height: 12, spacing: 6),
          const SizedBox(height: 12),
          const Spacer(),
          // Price and action button placeholder
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              ShimmerContainer(width: 60, height: 16, borderRadius: 4),
              ShimmerContainer(
                width: 24,
                height: 24,
                borderRadius: 12, // Circular button
              ),
            ],
          ),
        ],
      ),
    );
  }
}
