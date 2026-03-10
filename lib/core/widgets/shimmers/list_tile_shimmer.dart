import 'package:flutter/material.dart';

import 'shimmer_circle.dart';
import 'shimmer_container.dart';
import 'shimmer_text.dart';

class ListTileShimmer extends StatelessWidget {
  final bool hasLeadingIcon;
  final bool hasTrailing;

  const ListTileShimmer({
    super.key,
    this.hasLeadingIcon = true,
    this.hasTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (hasLeadingIcon) ...[
            const ShimmerCircle(radius: 24),
            const SizedBox(width: 16),
          ],
          const Expanded(
            child: ShimmerText(
              lines: 2,
              height: 14,
              spacing: 8,
              lastLineShorter: true,
            ),
          ),
          if (hasTrailing) ...[
            const SizedBox(width: 16),
            const ShimmerContainer(width: 20, height: 20, borderRadius: 4),
          ],
        ],
      ),
    );
  }
}
