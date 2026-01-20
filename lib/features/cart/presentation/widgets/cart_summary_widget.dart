import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CartSummaryWidget extends StatelessWidget {
  const CartSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSummaryRow("Sub-total", "RM 2,600", isBold: false),
          const SizedBox(height: 8),
          _buildSummaryRow("Voucher", "-RM 100", isBold: false),
          const SizedBox(height: 8),
          _buildSummaryRow("Delivery Fee", "RM 20", isBold: false),
          const SizedBox(height: 16),
          const Divider(color: AppColors.lightGrey, thickness: 1),
          const SizedBox(height: 16),
          _buildSummaryRow("Total", "RM 2,520", isBold: true),
          const SizedBox(height: 24),

          // Checkout Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: AppTexts.semiBold(
                "Checkout RM 2,520",
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {required bool isBold}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTexts.regular(
          label,
          fontSize: isBold ? 16 : 14,
          color: isBold ? Colors.black : AppColors.grayColor,
        ),
        isBold
            ? AppTexts.bold(value, fontSize: 16)
            : AppTexts.semiBold(value, fontSize: 14),
      ],
    );
  }
}
