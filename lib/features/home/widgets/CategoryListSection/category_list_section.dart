import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:flutter/material.dart';

class CategoryListSection extends StatelessWidget {
  const CategoryListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(AssetConstants.bestSellingMobiles),
        const SizedBox(height: 16),
        Image.asset(AssetConstants.bestSellingLaptop),
        const SizedBox(height: 16),
        Image.asset(AssetConstants.bestSellingWearable),
        const SizedBox(height: 16),
        Image.asset(AssetConstants.bestSellingEarbuds),
        const SizedBox(height: 16),
        Image.asset(AssetConstants.bestSellingTablet),
        const SizedBox(height: 16),
        Image.asset(AssetConstants.bestSellingAccesories),
      ],
    );
  }
}
