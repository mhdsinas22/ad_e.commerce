import 'package:flutter/material.dart';

import 'shimmer_circle.dart';
import 'shimmer_container.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        // Avatar
        const ShimmerCircle(radius: 50),
        const SizedBox(height: 16),
        // Name
        const ShimmerContainer(width: 150, height: 20, borderRadius: 8),
        const SizedBox(height: 8),
        // Email
        const ShimmerContainer(width: 200, height: 14, borderRadius: 6),
        const SizedBox(height: 32),
        // Stats/Info Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            3,
            (index) => const Column(
              children: [
                ShimmerContainer(width: 40, height: 24, borderRadius: 8),
                SizedBox(height: 8),
                ShimmerContainer(width: 60, height: 12, borderRadius: 4),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        // Settings Options
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                child: Row(
                  children: [
                    ShimmerCircle(radius: 20),
                    SizedBox(width: 16),
                    Expanded(
                      child: ShimmerContainer(
                        height: 16,
                        width: double.infinity,
                        borderRadius: 6,
                      ),
                    ),
                    SizedBox(width: 16),
                    ShimmerContainer(width: 24, height: 24, borderRadius: 12),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
