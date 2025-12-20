import 'package:flutter/material.dart';
import '../theme/app_colors.dart'; // adjust path if needed

class CircularArrowButton extends StatelessWidget {
  final VoidCallback onTap;
  final double size;
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final double iconSize;

  const CircularArrowButton({
    super.key,
    required this.onTap,
    this.size = 30,
    this.backgroundColor = AppColors.primaryBlue,
    this.iconColor = AppColors.pureWhite,
    this.icon = Icons.arrow_forward,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(size / 2),
        ),
        child: Center(child: Icon(icon, size: iconSize, color: iconColor)),
      ),
    );
  }
}
