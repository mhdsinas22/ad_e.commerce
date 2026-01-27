import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CoverageItem extends StatelessWidget {
  final String text;
  final bool isCovered;

  const CoverageItem({super.key, required this.text, required this.isCovered});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Row(
        children: [
          Icon(
            isCovered ? Icons.check_circle_outline : Icons.cancel_outlined,
            size: 20,
            color: Colors.black,
          ),
          const SizedBox(width: 4),
          AppTexts.medium(text, fontSize: 12),
        ],
      ),
    );
  }
}
