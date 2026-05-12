import 'package:aerstore/core/constants/asset_constants.dart';
import 'package:aerstore/core/enums/category.dart';
import 'package:aerstore/core/enums/phone_condition.dart';
import 'package:aerstore/core/enums/sub_category.dart';
import 'package:aerstore/core/utils/app_logger.dart';
import 'package:aerstore/features/home/widgets/CategoryListSection/widgets/best_selling_category_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aerstore/core/routes/route_names.dart';

class CategoryListSection extends StatelessWidget {
  const CategoryListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> bestSellingCategories = [
      {
        "title": "Best selling",
        "subtitle": "Mobiles",
        "image": AssetConstants.bestsellingmobilepng,
        "onTap": () {
          AppLogger.info("Best Selling click ");
          context.pushNamed(
            RouteNames.categoryfiltredpage,
            extra: {
              "subCategory": SubCategory.empty,
              "condition": PhoneCondition.empty,
              "isBestSeller": true,
              "onlyPhones": true,
            },
          );
        },
      },
      {
        "title": "Best selling",
        "subtitle": "Laptop",
        "image": AssetConstants.bestsellinglaptoppng,
        "onTap": () {
          AppLogger.debug("LOOK it BEst Selling");
          context.pushNamed(
            RouteNames.categoryfiltredpage,
            extra: {
              "subCategory": SubCategory.empty,
              "condition": PhoneCondition.empty,
              "isBestSeller": true,
              "onlyPhones": false,
              "category": Category.laptop,
            },
          );
        },
      },
      {
        "title": "Best selling",
        "subtitle": "Wearable",
        "image": AssetConstants.smartbestsellingpng,
        "onTap": () {
          context.pushNamed(
            RouteNames.categoryfiltredpage,
            extra: {
              "subCategory": SubCategory.empty,
              "condition": PhoneCondition.empty,
              "isBestSeller": true,
              "onlyPhones": false,
              "category": Category.wearables,
            },
          );
        },
      },
      {
        "title": "Best selling",
        "subtitle": "Earbuds",
        "image": AssetConstants.earbudspng,
        "onTap": () {
          context.pushNamed(
            RouteNames.categoryfiltredpage,
            extra: {
              "subCategory": SubCategory.empty,
              "condition": PhoneCondition.empty,
              "isBestSeller": true,
              "onlyPhones": false,
              "category": Category.earbuds,
            },
          );
        },
      },
      {
        "title": "Best selling",
        "subtitle": "Tablet",
        "image": AssetConstants.samsungtablsellerpng,
        "onTap": () {
          context.pushNamed(
            RouteNames.categoryfiltredpage,
            extra: {
              "subCategory": SubCategory.empty,
              "condition": PhoneCondition.empty,
              "isBestSeller": true,
              "onlyPhones": false,
              "category": Category.tablet,
            },
          );
        },
      },
      {
        "title": "Best selling",
        "subtitle": "Accessories",
        "image": AssetConstants.bestsellingCasespng,
        "onTap": () {
          context.pushNamed(
            RouteNames.categoryfiltredpage,
            extra: {
              "subCategory": SubCategory.empty,
              "condition": PhoneCondition.empty,
              "isBestSeller": true,
              "onlyPhones": false,
              "category": Category.accessories,
            },
          );
        },
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          // Desktop / Tablet -> Grid
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: constraints.maxWidth > 1100 ? 3 : 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.2,
            ),
            itemCount: bestSellingCategories.length,
            itemBuilder: (context, index) {
              final item = bestSellingCategories[index];
              return BestSellingCategoryCard(
                title: item["title"],
                subtitle: item["subtitle"],
                image: item["image"],
                onTap: item["onTap"],
              );
            },
          );
        } else {
          // Mobile -> List (unchanged)
          return Column(
            children:
                bestSellingCategories.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: BestSellingCategoryCard(
                      title: item["title"],
                      subtitle: item["subtitle"],
                      image: item["image"],
                      onTap: item["onTap"],
                    ),
                  );
                }).toList(),
          );
        }
      },
    );
  }
}
