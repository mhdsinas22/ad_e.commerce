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
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: isVertical ? 0.9 : 1.8, // base
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final item = categories[index];

        final isBigCard = index < 2; // ⭐ FIRST TWO BIG

        return CategoryCard(
          title: item.title,
          image: item.image,
          layout: layout,
          size: isBigCard ? CategoryCardSize.big : CategoryCardSize.small,
          onTap: () {
            debugPrint("${item.title} tapped");
          },
        );
      },
    );
  }
}
