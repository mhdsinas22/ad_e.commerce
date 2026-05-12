import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

enum CategoryCardLayout { horizontal, vertical }

enum CategoryCardSize { big, small }

class CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final CategoryCardLayout layout;
  final CategoryCardSize size;
  final VoidCallback? onTap;
  final bool customborder;
  final double borderRaduis;
  final Color bgColor;
  final List<Color>? gradientColors;

  const CategoryCard({
    super.key,
    required this.title,
    required this.image,
    required this.layout,
    this.customborder = false,
    this.size = CategoryCardSize.small,
    this.onTap,
    this.borderRaduis = 1.0,
    this.bgColor = AppColors.grey100,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final isBig = size == CategoryCardSize.big;
    final borderRadius = BorderRadius.circular(
      customborder
          ? borderRaduis
          : isBig
          ? 24
          : 16,
    );

    return InkWell(
      borderRadius: borderRadius,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: borderRadius,
          gradient:
              gradientColors != null
                  ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gradientColors!,
                  )
                  : null,
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
            child: AppTexts.medium(
              title,
              fontSize:
                  customborder
                      ? 11
                      : isBig
                      ? 20
                      : 13,
              // letterSpacing: -0.5,
            ),
          ),
        ),

        /// IMAGE
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          top:
              customborder
                  ? 10
                  : isBig
                  ? 55
                  : 1,
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
