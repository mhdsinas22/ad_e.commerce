import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double height;
  final double borderRadius;
  final Color backgroudColor;
  final double width;
  final String keyy;
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.height = 56,
    this.borderRadius = 30,
    this.backgroudColor = AppColors.primaryBlue,
    this.width = double.infinity,
    this.keyy = "",
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        key: Key(keyy),
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroudColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child:
            isLoading
                ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
                : AppTexts.semiBold(
                  text,
                  fontSize: 18,
                  color: AppColors.pureWhite,
                  align: TextAlign.center,
                ),
      ),
    );
  }
}
