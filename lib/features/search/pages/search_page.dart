import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_sliver_app_bar.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/app_text_form_field.dart';
import 'package:ad_e_commerce/features/home/data/category_data.dart';
import 'package:ad_e_commerce/features/home/widgets/category_card.dart';
import 'package:ad_e_commerce/features/home/widgets/category_grid.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppSliverAppBar(showBack: true),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Search
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AppTextFormField(
                    width: double.infinity,
                    borderradiusno: 12,
                    hintText: "Search...",
                    suffixIcon: const Icon(
                      Icons.search,
                      color: AppColors.grayColor,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: AppTexts.medium(
                      "Select a Category to Browse",
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                CategoryGrid(
                  categories: CategoryData.categories,
                  layout: CategoryCardLayout.horizontal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
