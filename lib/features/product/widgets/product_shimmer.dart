import 'package:flutter/material.dart';

import '../../../core/widgets/shimmers/shimmer_circle.dart';
import '../../../core/widgets/shimmers/shimmer_container.dart';
import '../../../core/widgets/shimmers/shimmer_text.dart';

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 1024;
        return Scaffold(
          body: isDesktop
              ? _buildDesktopShimmer(context)
              : _buildMobileShimmer(context),
          bottomNavigationBar: isDesktop ? null : _buildBottomBarShimmer(),
        );
      },
    );
  }

  Widget _buildMobileShimmer(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Image shimmer
                const AspectRatio(
                  aspectRatio: 1,
                  child: ShimmerContainer(
                    width: double.infinity,
                    height: double.infinity,
                    borderRadius: 0,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const ShimmerCircle(radius: 25),
                          Row(
                            children: const [
                              ShimmerCircle(radius: 25),
                              SizedBox(width: 10),
                              ShimmerCircle(radius: 25),
                              SizedBox(width: 10),
                              ShimmerCircle(radius: 25),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: _productInfoShimmer(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ShimmerContainer(
                width: double.infinity,
                height: 100,
                borderRadius: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopShimmer(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ShimmerCircle(radius: 22),
                    Row(
                      children: const [
                        ShimmerCircle(radius: 22),
                        SizedBox(width: 10),
                        ShimmerCircle(radius: 22),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ShimmerContainer(
                          width: double.infinity,
                          height: double.infinity,
                          borderRadius: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _productInfoShimmer(),
                          const SizedBox(height: 24),
                          Row(
                            children: const [
                              Expanded(
                                child: ShimmerContainer(
                                  width: double.infinity,
                                  height: 52,
                                  borderRadius: 24,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: ShimmerContainer(
                                  width: double.infinity,
                                  height: 52,
                                  borderRadius: 24,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          const ShimmerContainer(
                            width: double.infinity,
                            height: 100,
                            borderRadius: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productInfoShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rating
        Row(
          children: const [
            ShimmerContainer(width: 20, height: 20, borderRadius: 4),
            SizedBox(width: 8),
            ShimmerContainer(width: 40, height: 16, borderRadius: 4),
            SizedBox(width: 8),
            ShimmerContainer(width: 100, height: 16, borderRadius: 4),
          ],
        ),
        const SizedBox(height: 12),
        // Title
        const ShimmerText(lines: 1, height: 26, width: double.infinity),
        const SizedBox(height: 4),
        // Model
        const ShimmerText(lines: 1, height: 16, width: 150),
        const SizedBox(height: 16),
        // Price
        Row(
          children: const [
            ShimmerContainer(width: 100, height: 24, borderRadius: 4),
            SizedBox(width: 10),
            ShimmerContainer(width: 80, height: 24, borderRadius: 4),
          ],
        ),
        const SizedBox(height: 24),
        // Key Features
        const ShimmerContainer(width: 120, height: 20, borderRadius: 4),
        const SizedBox(height: 8),
        const ShimmerText(
          lines: 3,
          height: 16,
          spacing: 8,
          width: double.infinity,
        ),
      ],
    );
  }

  Widget _buildBottomBarShimmer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        child: Row(
          children: const [
            Expanded(
              child: ShimmerContainer(
                width: double.infinity,
                height: 48,
                borderRadius: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: ShimmerContainer(
                width: double.infinity,
                height: 48,
                borderRadius: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
