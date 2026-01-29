import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE9ECFF),
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
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
