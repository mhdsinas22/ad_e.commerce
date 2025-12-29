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

        Image.asset(AssetConstants.bestSellingLaptop),
        Image.asset(AssetConstants.bestSellingWearable),
        Image.asset(AssetConstants.bestSellingEarbuds),
        Image.asset(AssetConstants.bestSellingTablet),
        Image.asset(AssetConstants.bestSellingAccesories),
      ],
    );
  }
}
