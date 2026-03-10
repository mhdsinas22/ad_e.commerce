import 'package:flutter/material.dart';

import 'shimmer_container.dart';

class ShimmerText extends StatelessWidget {
  final double width;
  final double height;
  final int lines;
  final double spacing;
  final double borderRadius;
  final bool lastLineShorter;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerText({
    super.key,
    this.width = double.infinity,
    this.height = 14.0,
    this.lines = 1,
    this.spacing = 8.0,
    this.borderRadius = 8.0,
    this.lastLineShorter = true,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    if (lines <= 1) {
      return ShimmerContainer(
        width: width,
        height: height,
        borderRadius: borderRadius,
        baseColor: baseColor,
        highlightColor: highlightColor,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(lines, (index) {
        final isLast = index == lines - 1;
        // Make the last line half the width to mimic real text paragraphs
        final currentWidth = (isLast && lastLineShorter) ? width * 0.5 : width;

        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : spacing),
          child: ShimmerContainer(
            width: currentWidth,
            height: height,
            borderRadius: borderRadius,
            baseColor: baseColor,
            highlightColor: highlightColor,
          ),
        );
      }),
    );
  }
}
