import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class PricePromoCard extends StatelessWidget {
  final String title;
  final String label;
  final String price;
  final String imagePath;
  final Color backgroundColor;
  final double width;
  final double height;
  final VoidCallback onTap;

  const PricePromoCard({
    super.key,
    required this.title,
    required this.label,
    required this.price,
    required this.imagePath,
    required this.backgroundColor,
    this.width = 167,
    this.height = 90,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            //  Top Right Image
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(imagePath),
              ),
            ),

            //  Bottom Text Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 12.0,
                  ),
                  child: AppTexts.semiBold(
                    title,
                    fontSize: 12,
                    color: AppColors.pureWhite,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: AppTexts.medium(
                    label,
                    fontSize: 8,
                    color: AppColors.pureWhite,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: AppTexts.medium(
                    price,
                    fontSize: 18,
                    color: AppColors.pureWhite,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
