import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/product/domain/entites/product.dart';
import 'package:ad_e_commerce/features/search/widgets/search_cart_button_logic.dart';
import 'package:flutter/material.dart';

class SearchProductGridItem extends StatelessWidget {
  final Product product;

  const SearchProductGridItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image Card
        GestureDetector(
          onTap:
              () => Appnavigotor.pushnamed(context, RouteNames.productpage, {
                "product": product,
              }),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                product.imageUrls.isNotEmpty ? product.imageUrls.first : '',
                fit: BoxFit.contain,
                errorBuilder:
                    (c, o, s) => const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                    ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Title & Rating
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: "Manrope",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.grayColor,
                ),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
            const SizedBox(width: 2),
            AppTexts.medium(
              "${product.rating}",
              fontSize: 14,
              color: Colors.black,
            ),
          ],
        ),

        const SizedBox(height: 4),

        // Price
        AppTexts.semiBold(
          "₹ ${product.price.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
          fontSize: 16,
          color: Colors.black,
        ),

        const SizedBox(height: 8),

        // Button / Status
        SizedBox(
          height: 38,
          child:
              product.isActive
                  ? SearchCartButtonLogic(product: product)
                  : Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: AppTexts.semiBold(
                      "Out of Stock",
                      color: AppColors.purered,
                      fontSize: 12,
                    ),
                  ),
        ),
      ],
    );
  }
}
