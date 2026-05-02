import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CoverageItem extends StatelessWidget {
  final String text;
  final bool isCovered;

  const CoverageItem({super.key, required this.text, required this.isCovered});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 22,
            color: Color(0xFF1D1B20), // Dark grey/black for icons
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppTexts.medium(
              text,
              fontSize: 15,
              color: const Color(0xFF1D1B20),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
