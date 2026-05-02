import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_cached_image.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/product/domain/entites/product.dart';
import 'package:flutter/material.dart';

class FlashSaleCard extends StatelessWidget {
  final Product product;
  const FlashSaleCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isSoldOut =
        product.stocks.isEmpty ||
        product.stocks.every((stock) => stock.quantity == 0) ||
        product.isActive == false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 167,
          height: 170,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                spreadRadius: 1,
                offset: Offset(0, 4),
              ),
            ],
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Appnavigotor.pushnamed(context, RouteNames.productpage, {
                  "product": product,
                });
              },
              child: Center(
                child: AppCachedImage(
                  imageUrl: product.imageUrls.first,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                child: AppTexts.medium(
                  product.title,
                  fontSize: 12,
                  color: AppColors.grayColor,
                ),
              ),
              const SizedBox(width: 8),
              Image.asset("assets/png/image 4.png", width: 14, height: 14),
              const SizedBox(width: 4),
              AppTexts.semiBold("${product.rating}"),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.1),
          child: AppTexts.semiBold(
            isSoldOut ? "Out of Stock " : "₹ ${product.price}",
            fontSize: isSoldOut ? 12 : 16,
            color: isSoldOut ? Colors.grey : AppColors.pureBlack,
          ),
        ),
      ],
    );
  }
}
