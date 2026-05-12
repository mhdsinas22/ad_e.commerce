import 'package:aerstore/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TransactionItemCard extends StatelessWidget {
  final String title;
  final String amount;
  final bool isCredit;
  final IconData iconInfo;
  final Widget? trailing;

  const TransactionItemCard({
    super.key,
    required this.title,
    required this.amount,
    required this.isCredit,
    required this.iconInfo,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGrey, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon Container
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  isCredit
                      ? const Color(0xFFE8FCE8) // Light Green
                      : const Color(0xFFFFEAEA), // Light Red
            ),
            child: Icon(
              iconInfo,
              color:
                  isCredit
                      ? const Color(0xFF4ADE80) // Green
                      : const Color(0xFFFF6B6B), // Red
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          // Title
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.pureBlack,
              ),
            ),
          ),
          // Amount
          Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color:
                  isCredit
                      ? const Color(0xFF4ADE80) // Green
                      : const Color(0xFFFF4B4B), // Red/Pink
            ),
          ),
        ],
      ),
    );
  }
}
