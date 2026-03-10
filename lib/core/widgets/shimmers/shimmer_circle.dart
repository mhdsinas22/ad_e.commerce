import 'package:flutter/material.dart';

import 'base_shimmer.dart';

class ShimmerCircle extends StatelessWidget {
  final double radius;
  final EdgeInsetsGeometry? margin;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerCircle({
    super.key,
    required this.radius,
    this.margin,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: radius * 2,
        height: radius * 2,
        margin: margin,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
