import 'package:aerstore/core/common/widgets/shimmer/shimmer_wrapper.dart';
import 'package:flutter/material.dart';

class AppShimmer extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Color? color;

  const AppShimmer({
    super.key,
    required this.width,
    required this.height,
    this.radius = 0,
    this.color,
  });

  /// Basic rectangular shimmer
  factory AppShimmer.rect({
    required double width,
    required double height,
    double radius = 0,
  }) {
    return AppShimmer(width: width, height: height, radius: radius);
  }

  /// Circular shimmer (avatar, icons)
  factory AppShimmer.circle({required double size}) {
    return AppShimmer(width: size, height: size, radius: size / 2);
  }

  /// Matches the Home Banner (height ~180, full width)
  static Widget banner({double height = 180, double borderRadius = 20}) {
    return ShimmerWrapper(
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  /// Matches FlashSaleCard (167 x 170 + text placeholders)
  static Widget productCard() {
    return ShimmerWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 167,
            height: 170,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 6),
          Container(width: 100, height: 12, color: Colors.white),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(width: 14, height: 14, color: Colors.white), // Star
              const SizedBox(width: 4),
              Container(width: 20, height: 12, color: Colors.white), // Rating
            ],
          ),
          const SizedBox(height: 4),
          Container(width: 60, height: 16, color: Colors.white), // Price
        ],
      ),
    );
  }

  /// Matches CategoryCard
  static Widget categoryCard({bool isBig = false}) {
    // Small: padding 10, big: 16. Approx size is controlled by parent usually in a grid/list.
    // But internal structure varies.
    return ShimmerWrapper(
      child: Container(
        width: 100, // flexible
        height: 100, // flexible
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  /// Generic List Tile Shimmer
  static Widget listTile({bool hasImage = true}) {
    return ShimmerWrapper(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            if (hasImage)
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            if (hasImage) const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 16.0,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(width: 150, height: 12.0, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
