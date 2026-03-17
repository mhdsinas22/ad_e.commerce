import 'package:ad_e_commerce/core/utils/helpers.dart';
import 'package:ad_e_commerce/features/home/models/category_model.dart';
import 'package:ad_e_commerce/features/home/widgets/category_card.dart';
import 'package:flutter/material.dart';

class CategoryGrid extends StatelessWidget {
  final List<CategoryModel> categories;
  final CategoryCardLayout layout;

  const CategoryGrid({
    super.key,
    required this.categories,
    this.layout = CategoryCardLayout.vertical,
  });

  @override
  Widget build(BuildContext context) {
    final isVertical = layout == CategoryCardLayout.vertical;

    return isVertical
        ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              /// 🔹 BIG CARDS (Phones, Accessories)
              GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length >= 2 ? 2 : categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1, // ⭐ SAME width & height
                ),
                itemBuilder: (context, index) {
                  final item = categories[index];
                  return CategoryCard(
                    onTap: () => handleNavigation(context, item),
                    title: item.title,
                    image: item.image,
                    size: CategoryCardSize.small,
                    layout: CategoryCardLayout.vertical,
                  );
                },
              ),
              const SizedBox(height: 16), // ⭐ CONTROLLED SPACE
              /// 🔹 SMALL CARDS (Laptop, Tablet, Wearables, Earbuds)
              GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length > 2 ? categories.length - 2 : 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.86,
                ),
                itemBuilder: (context, index) {
                  final item = categories[index + 2];
                  return CategoryCard(
                    borderRaduis: 9.88,
                    customborder: true,
                    onTap: () => handleNavigation(context, item),
                    title: item.title,
                    image: item.image,
                    size: CategoryCardSize.small,
                    layout: CategoryCardLayout.vertical,
                  );
                },
              ),
            ],
          ),
        )
        : LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 2;
            if (constraints.maxWidth > 1100) {
              crossAxisCount = 6;
            } else if (constraints.maxWidth > 700) {
              crossAxisCount = 4;
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.8,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final item = categories[index];
                return CategoryCard(
                  onTap: () => handleNavigation(context, item),
                  title: item.title,
                  image: item.image,
                  layout: layout,
                );
              },
            );
          },
        );
  }
}
