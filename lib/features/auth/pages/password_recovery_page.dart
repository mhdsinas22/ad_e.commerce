import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class PasswordRecoveryPage extends StatelessWidget {
  const PasswordRecoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 4),
              AppTexts.bold(
                "Password Recovery",
                fontSize: 24,
                align: TextAlign.center,
              ),
              const SizedBox(height: 12),
              AppTexts.medium(
                "Check your Mail id for\nconfirmation mail",
                fontSize: 16,
                align: TextAlign.center,
                height: 1.5,
                color: Colors.black.withOpacity(0.7),
              ),
              const SizedBox(height: 20),
              AppTexts.semiBold(
                "shahamck@gmail.com",
                fontSize: 16,
                align: TextAlign.center,
              ),
              const Spacer(flex: 5),
              TextButton(
                onPressed: () {
                  // No logic as per rules
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black.withOpacity(0.6),
                ),
                child: AppTexts.medium(
                  "Cancel",
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
