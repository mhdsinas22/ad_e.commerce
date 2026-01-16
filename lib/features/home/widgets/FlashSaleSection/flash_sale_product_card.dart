import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/product/domain/entites/product.dart';
import 'package:flutter/material.dart';

class FlashSaleCard extends StatelessWidget {
  final Product product;
  const FlashSaleCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              width: 167,
              height: 212,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
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
                  child: Image.network(
                    product.imageUrls.first,
                    width: 107,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppTexts.medium(product.title, fontSize: 12),
                    SizedBox(width: 70),
                    Image.asset("assets/png/image 4.png"),
                    SizedBox(width: 5),
                    AppTexts.semiBold("4.9"),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                AppTexts.semiBold("₹ ${product.price}"),
                SizedBox(width: 90),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
