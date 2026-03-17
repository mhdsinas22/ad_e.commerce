import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/circular_arrow_button.dart';
import 'package:flutter/material.dart';

class BestSellingCategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final VoidCallback onTap;

  const BestSellingCategoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // LEFT CONTENT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTexts.regular(title, fontSize: 18, color: Colors.black),
                  const SizedBox(height: 4),
                  AppTexts.semiBold(subtitle, fontSize: 30),
                  const SizedBox(height: 10),
                  CircularArrowButton(
                    backgroundColor: AppColors.primaryBlack,
                    size: 28,
                    iconSize: 16,
                    onTap: onTap,
                  ),
                ],
              ),
            ),
            // RIGHT IMAGE
            Image.asset(image, height: 120, fit: BoxFit.contain),
          ],
        ),
      ),
    );
  }
}
