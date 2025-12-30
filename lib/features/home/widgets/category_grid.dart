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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              /// 🔹 BIG CARDS (Phones, Accessories)
              GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1, // ⭐ SAME width & height
                ),
                itemBuilder: (context, index) {
                  final item = categories[index];
                  return CategoryCard(
                    title: item.title,
                    image: item.image,
                    size: CategoryCardSize.big,
                    layout: CategoryCardLayout.vertical,
                  );
                },
              ),
              const SizedBox(height: 12), // ⭐ CONTROLLED SPACE
              /// 🔹 SMALL CARDS (Laptop, Tablet, Wearables, Earbuds)
              GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length - 2,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final item = categories[index + 2];
                  return CategoryCard(
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
        : GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.8,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final item = categories[index];
            return CategoryCard(
              title: item.title,
              image: item.image,
              layout: layout,
              onTap: () {
                debugPrint("${item.title} tapped");
              },
            );
          },
        );
  }
}
