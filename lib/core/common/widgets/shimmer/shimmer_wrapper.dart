import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWrapper extends StatelessWidget {
  final Widget child;
  final bool enabled;

  const ShimmerWrapper({super.key, required this.child, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: child,
    );
  }
}
