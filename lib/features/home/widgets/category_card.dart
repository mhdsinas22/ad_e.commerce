import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

enum CategoryCardLayout { horizontal, vertical }

enum CategoryCardSize { big, small }

class CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final CategoryCardLayout layout;
  final CategoryCardSize size;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.title,
    required this.image,
    required this.layout,
    this.size = CategoryCardSize.small,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isBig = size == CategoryCardSize.big;
    final borderRadius = BorderRadius.circular(isBig ? 24 : 16);

    return InkWell(
      borderRadius: borderRadius,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grey100,
          borderRadius: borderRadius,
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child:
              layout == CategoryCardLayout.vertical
                  ? _vertical(isBig)
                  : _horizontal(isBig),
        ),
      ),
    );
  }

  Widget _vertical(bool isBig) {
    return Stack(
      children: [
        /// TITLE
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: isBig ? 24 : 12),
            child: AppTexts.semiBold(
              title,
              fontSize: isBig ? 20 : 13,
              // letterSpacing: -0.5,
            ),
          ),
        ),

        /// IMAGE
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top: isBig ? 55 : 34,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }

  Widget _horizontal(bool isBig) {
    return Row(
      children: [
        const SizedBox(width: 10),
        AppTexts.semiBold(
          title,
          fontSize: isBig ? 15 : 12,
          // letterSpacing: -0.5,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Image.asset(
            image,
            fit: BoxFit.contain,
            alignment: Alignment.centerRight,
          ),
        ),
      ],
    );
  }
}
