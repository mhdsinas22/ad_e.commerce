import 'package:aerstore/core/constants/asset_constants.dart';
import 'package:aerstore/core/enums/category.dart';
import 'package:aerstore/core/enums/phone_condition.dart';
import 'package:aerstore/core/enums/sub_category.dart';

import 'package:aerstore/core/routes/route_names.dart';
import 'package:aerstore/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:aerstore/features/home/widgets/BestSellerSection/price_promo_card.dart';
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

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 2;
        if (constraints.maxWidth > 1100) {
          crossAxisCount = 5;
        } else if (constraints.maxWidth > 700) {
          crossAxisCount = 4;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: bestSellerPrices.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.9,
          ),
          itemBuilder: (context, index) {
            final item = bestSellerPrices[index];

            return PricePromoCard(
              title: "Best sellers",
              label: item["label"]!,
              price: item["price"].toString(),
              imagePath: item["imagePath"]!,
              backgroundColor: AppColors.primaryBlack,
              onTap: () {
                context.push(
                  '/${RouteNames.categoryfiltredpage}?'
                  'subcategory=${SubCategory.empty.name}'
                  '&condition=${PhoneCondition.empty.name}'
                  '&isBestSeller=true'
                  '&category=${Category.phones.name}'
                  '&priceTYpe=${item["label"]}'
                  '&priceAmount=${int.parse(item["price"]!.replaceAll(",", ""))}'
                  '&search=',
                );
              },
            );
          },
        );
      },
    );
  }
}
