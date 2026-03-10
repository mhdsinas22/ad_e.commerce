import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/app_colors.dart';

class BaseShimmer extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration period;

  const BaseShimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.period = const Duration(milliseconds: 1500),
  });

  @override
  Widget build(BuildContext context) {
    // Determine the brightness to adapt shimmer colors for dark mode if supported
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Use a very light grey for the base and pure white for the highlight
    // to match Apple/Amazon smooth and modern shimmer styles.
    final defaultBaseColor =
        isDark ? Colors.grey[800]! : const Color(0xFFEBEBF4);
    final defaultHighlightColor =
        isDark ? Colors.grey[600]! : AppColors.pureWhite;

    return Shimmer.fromColors(
      baseColor: baseColor ?? defaultBaseColor,
      highlightColor: highlightColor ?? defaultHighlightColor,
      period: period,
      child: child,
    );
  }
}
