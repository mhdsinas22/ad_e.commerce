import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;
  final bool isVertical;

  const OptionCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
    this.isVertical = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grey100,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(12),
        child:
            isVertical
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// 👇 FIXED IMAGE BOX

                    /// Title
                    AppTexts.semiBold(title, fontSize: 13),
                    const SizedBox(width: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 81,
                        width: 68, // 👈 IMPORTANT
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset(imagePath),
                        ),
                      ),
                    ),
                  ],
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 8),

                    /// 👇 FIXED IMAGE BOX
                    SizedBox(
                      height: 95,
                      width: 110, // 👈 IMPORTANT
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Image.asset(imagePath),
                      ),
                    ),

                    /// Title
                    AppTexts.semiBold(title, fontSize: 13),
                  ],
                ),
      ),
    );
  }
}
