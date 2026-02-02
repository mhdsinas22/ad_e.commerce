import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/features/home/pages/category_filtred_page.dart';
import 'package:ad_e_commerce/features/home/widgets/CategoryListSection/widgets/best_selling_category_card.dart';
import 'package:flutter/material.dart';

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
          Appnavigotor.push(
            context,
            CategoryFiltredPage(
              subCategory: SubCategory.empty,
              condition: PhoneCondition.empty,
              isBestSeller: true,
              onlyPhones: true,
            ),
          );
        },
      },
      {
        "title": "Best selling",
        "subtitle": "Laptop",
        "image": AssetConstants.bestsellinglaptoppng,
        "onTap": () {
          Appnavigotor.push(
            context,
            CategoryFiltredPage(
              subCategory: SubCategory.empty,
              condition: PhoneCondition.empty,
              isBestSeller: true,
              onlyPhones: false,
              category: Category.laptop,
            ),
          );
        },
      },
      {
        "title": "Best selling",
        "subtitle": "Wearable",
        "image": AssetConstants.smartbestsellingpng,
        "onTap": () {
          Appnavigotor.push(
            context,
            CategoryFiltredPage(
              subCategory: SubCategory.empty,
              condition: PhoneCondition.empty,
              isBestSeller: true,
              onlyPhones: false,
              category: Category.wearables,
            ),
          );
        },
      },
      {
        "title": "Best selling",
        "subtitle": "Earbuds",
        "image": AssetConstants.earbudspng,
        "onTap": () {
          Appnavigotor.push(
            context,
            CategoryFiltredPage(
              subCategory: SubCategory.empty,
              condition: PhoneCondition.empty,
              isBestSeller: true,
              onlyPhones: false,
              category: Category.earbuds,
            ),
          );
        },
      },
      {
        "title": "Best selling",
        "subtitle": "Tablet",
        "image": AssetConstants.samsungtablsellerpng,
        "onTap": () {
          Appnavigotor.push(
            context,
            CategoryFiltredPage(
              subCategory: SubCategory.empty,
              condition: PhoneCondition.empty,
              isBestSeller: true,
              onlyPhones: false,
              category: Category.tablet,
            ),
          );
        },
      },
      {
        "title": "Best selling",
        "subtitle": "Accessories",
        "image": AssetConstants.bestsellingCasespng,
        "onTap": () {
          Appnavigotor.push(
            context,
            CategoryFiltredPage(
              subCategory: SubCategory.empty,
              condition: PhoneCondition.empty,
              isBestSeller: true,
              onlyPhones: false,
              category: Category.accessories,
            ),
          );
        },
      },
    ];

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
}
