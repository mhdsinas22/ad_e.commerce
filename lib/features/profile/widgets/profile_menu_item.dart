import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/core/widgets/app_text.dart';
import 'package:aerstore/core/widgets/circular_arrow_button.dart';
import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isneedChangedbuttoncolor;
  final Color buttoncolor;

  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.onTap,
    this.isneedChangedbuttoncolor = false,
    this.buttoncolor = AppColors.primaryBlack,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTexts.medium(title, fontSize: 14),
                CircularArrowButton(
                  size: 18,
                  iconSize: 15,
                  onTap: onTap,
                  backgroundColor:
                      isneedChangedbuttoncolor
                          ? buttoncolor
                          : AppColors.primaryBlack,
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
