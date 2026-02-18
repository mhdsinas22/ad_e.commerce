import 'package:flutter/material.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/primary_button.dart';

class StoreCard extends StatelessWidget {
  final String image;
  final String title;
  final String phone;
  final VoidCallback onLocationTap;
  final VoidCallback onWhatsappTap;
  final VoidCallback onCallTap;

  const StoreCard({
    super.key,
    required this.image,
    required this.title,
    required this.phone,
    required this.onLocationTap,
    required this.onWhatsappTap,
    required this.onCallTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth = constraints.maxWidth;

        if (cardWidth > 600) {
          cardWidth = 350; // Desktop max width
        }
        return Center(
          child: SizedBox(
            width: cardWidth,
            child: Card(
              color: AppColors.pureWhite,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🔹 IMAGE
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        image,
                        height: 190,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// 🔹 TITLE
                    AppTexts.medium(title, fontSize: 16),

                    const SizedBox(height: 16),

                    /// 🔹 BUTTON ROW
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            fontsize: 10,
                            text: "Call",
                            height: 40,
                            onPressed: onCallTap,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: PrimaryButton(
                            fontsize: 10,
                            text: "Location",
                            height: 40,
                            onPressed: onLocationTap,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: PrimaryButton(
                            fontsize: 10,
                            text: "Whatsapp",
                            height: 40,
                            onPressed: onWhatsappTap,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
