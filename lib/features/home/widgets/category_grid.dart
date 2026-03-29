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
    final List<List<Color>> categoryGradients = [
      [Color(0xFF77fcc6), Color(0xFFb4fbd5)], // green
      [Color(0xFFfefdb2), Color(0xFFfcef85)], // yellow
      [Color(0xffd4f8ff), Color(0xFFd4f8ff)], // blue
      [Color(0xFF77fcc6), Color(0xFFb4fbd5)], // green
      [Color(0xFFfefdb2), Color(0xFFfcef85)], // yellow
      [Color(0xffd4f8ff), Color(0xFFd4f8ff)], // blue
      // [Color(0xfffed8ff), Color(0xFFfff0ff)], // purple
    ];
    final isVertical = layout == CategoryCardLayout.vertical;

    if (!isVertical) {
      return LayoutBuilder(
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
                gradientColors:
                    categoryGradients[index % categoryGradients.length],
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

    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 600) {
      // Desktop, tablet, laptop -> All 6 in one row
      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: categories.length > 0 ? categories.length : 6, // Typically 6 items
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1, // Keep them square
              ),
              itemBuilder: (context, index) {
                final item = categories[index];
                return CategoryCard(
                  onTap: () => handleNavigation(context, item),
                  title: item.title,
                  image: item.image,
                  size: CategoryCardSize.small,
                  layout: CategoryCardLayout.vertical,
                  customborder: index >= 2,
                  borderRaduis: index >= 2 ? 9.88 : 1.0,
                  gradientColors:
                      categoryGradients[index % categoryGradients.length],
                );
              },
            ),
          ),
        ),
      );
    }

    // Mobile: < 600px -> current design
    return Padding(
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
                gradientColors:
                    categoryGradients[index % categoryGradients.length],
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
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final item = categories[index + 2];
              return CategoryCard(
                gradientColors:
                    categoryGradients[(index + 2) %
                        categoryGradients.length],
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
    );
  }
}
