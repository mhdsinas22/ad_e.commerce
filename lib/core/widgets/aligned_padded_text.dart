import 'package:flutter/material.dart';

import 'package:ad_e_commerce/core/theme/app_colors.dart';

class AlignedPaddedText extends StatelessWidget {
  final String text;
  final Alignment alignment;
  final EdgeInsets padding;
  final Color color;
  final double fontSize;
  final Widget? child;

  const AlignedPaddedText({
    super.key,
    this.text = "",
    this.alignment = Alignment.topLeft,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
    this.color = AppColors.grayColor,
    this.fontSize = 12,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Align(alignment: alignment, child: child),
    );
  }
}
