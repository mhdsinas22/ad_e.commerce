import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isEnabled;

  const CheckoutButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: isEnabled ? onTap : null,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isEnabled
                  ? AppColors.primaryBlack
                  : Colors.grey, // Vibrant Blue if enabled, Grey if disabled
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
