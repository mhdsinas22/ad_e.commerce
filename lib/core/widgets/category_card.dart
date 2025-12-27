import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final double width;
  final double height;
  final String image;
  final String title;
  const CategoryCard({
    super.key,
    required this.title,
    required this.image,
    this.height = 172,
    this.width = 167,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.pastelBlue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(children: [Image.asset(image), AppTexts.semiBold(title)]),
    );
  }
}
