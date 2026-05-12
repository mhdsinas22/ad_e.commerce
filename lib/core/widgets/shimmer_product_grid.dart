import 'package:aerstore/core/common/widgets/shimmer/app_shimmer.dart';
import 'package:flutter/material.dart';

class ShimmerProductGrid extends StatelessWidget {
  final int itemCount;
  final int crossAxisCount;
  final double childAspectRatio;
  final double? mainAxisExtent;
  final EdgeInsetsGeometry padding;

  const ShimmerProductGrid({
    super.key,
    this.itemCount = 8,
    required this.crossAxisCount,
    required this.childAspectRatio,
    this.mainAxisExtent,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: padding,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: childAspectRatio,
          mainAxisExtent: mainAxisExtent ?? (screenWidth < 600 ? 320 : 360),
        ),
        itemBuilder: (context, index) {
          return AppShimmer.productCard();
        },
      ),
    );
  }
}
