import 'package:ad_e_commerce/features/product/domain/entites/product.dart';
import 'package:ad_e_commerce/features/search/widgets/search_product_grid_item.dart';
import 'package:flutter/material.dart';

class ProductGridSection extends StatelessWidget {
  final List<Product> products;
  final int crossAxisCount;
  final double childAspectRatio;
  final double screenWidth;
  const ProductGridSection({
    super.key,
    required this.products,
    required this.crossAxisCount,
    required this.childAspectRatio,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: childAspectRatio,
          mainAxisExtent: screenWidth < 600 ? 320 : 360,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return SearchProductGridItem(product: product);
        },
      ),
    );
  }
}
