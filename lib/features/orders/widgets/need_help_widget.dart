import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/core/widgets/app_text.dart';
import 'package:aerstore/core/widgets/primary_button.dart';
import 'package:aerstore/core/widgets/store_call_bottom_sheet.dart';
import 'package:flutter/material.dart';

class NeedHelpWidget extends StatelessWidget {
  const NeedHelpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGrey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts.bold("Need Help?", fontSize: 18),
          const SizedBox(height: 16),
          PrimaryButton(
            fontsize: 16,
            height: 48,
            text: "Contact Support",
            onPressed: () {
              StoreCallBottomSheet.show(context);
            },
            borderRadius: 12,
            backgroudColor: AppColors.primaryBlack,
          ),
        ],
      ),
    );
  }
}
