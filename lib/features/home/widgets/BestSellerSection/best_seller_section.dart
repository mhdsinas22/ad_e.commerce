import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';

import 'package:ad_e_commerce/features/home/widgets/BestSellerSection/price_promo_card.dart';
import 'package:flutter/material.dart';

class BestSellersSection extends StatelessWidget {
  const BestSellersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> bestSellerPrices = [
      {
        "label": "Under",
        "price": "15,000",
        "imagePath": AssetConstants.iphonesepng,
      },
      {
        "label": "Under",
        "price": "30,000",
        "imagePath": AssetConstants.iphone11png,
      },
      {
        "label": "Under",
        "price": "50,000",
        "imagePath": AssetConstants.iphone15png,
      },
      {
        "label": "Above",
        "price": "75,000",
        "imagePath": AssetConstants.iphone17propng,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: bestSellerPrices.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 👈 2 cards per row
        crossAxisSpacing: 12, // 👈 horizontal gap
        mainAxisSpacing: 12, // 👈 vertical gap
        childAspectRatio: 1.9, // 👈 IMPORTANT (card shape)
      ),
      itemBuilder: (context, index) {
        final item = bestSellerPrices[index];

        return PricePromoCard(
          title: "Best sellers",
          label: item["label"]!,
          price: item["price"]!,
          imagePath: item["imagePath"]!,
          backgroundColor: AppColors.brightBlue,
          onTap: () {},
        );
      },
    );
  }
}
