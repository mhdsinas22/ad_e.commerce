import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/circular_arrow_button.dart';
import 'package:ad_e_commerce/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class OnboardingStartpage extends StatelessWidget {
  const OnboardingStartpage({super.key});

  @override
  Widget build(BuildContext context) {
    // Media query for responsive layout
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: SizedBox(
        width: double.infinity,
        height: size.height,
        child: Column(
          children: [
            // ---------------- HEADER / IMAGE SECTION ----------------
            // Using a modern curved container for the visual interest
            Expanded(
              flex: 6, // Takes up ~60% of the screen
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      // ignore: deprecated_member_use
                      AppColors.primaryBlue.withOpacity(0.05),
                      AppColors.pureWhite,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Placeholder for the "Image" from the prompt
                    // Since we don't have the asset, we use a high-quality icon/placeholder
                    Container(
                      height: size.width * 0.8,
                      width: size.width * 0.8,
                      decoration: const BoxDecoration(
                        // If provided an asset, specific Image.asset would go here
                        // image: DecorationImage(image: AssetImage('...'))
                      ),
                      child: Icon(
                        Icons.shopping_cart_checkout_rounded,
                        size: 140,
                        // ignore: deprecated_member_use
                        color: AppColors.primaryBlue.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ---------------- CONTENT SECTION ----------------
            Expanded(
              flex: 4, // Takes up ~40% of the screen
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),

                    // Headline for Visual Hierarchy
                    AppTexts.extraBold(
                      "Define yourself in\nyour unique way.",
                      fontSize: 32, // Large modern font size
                      align: TextAlign.center,
                      color: Colors.black,
                    ),

                    const SizedBox(height: 12),
                    // Subtitle
                    AppTexts.regular(
                      "Discover the best products for your lifestyle",
                      fontSize: 16,
                      align: TextAlign.center,
                      color: Colors.grey.shade600,
                    ),

                    const Spacer(),

                    // ---------------- ACTION BUTTONS ----------------
                    // Primary Action
                    PrimaryButton(
                      borderRadius: 16,
                      height: 64, // Slightly taller for modern look
                      width: double.infinity,
                      text: "Let's get started",
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RouteNames.signup,
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // Login Link
                    // Preserving exact logic: InkWell wraps row + Arrow Button functionality
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RouteNames.login,
                        );
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize:
                            MainAxisSize
                                .min, // Use min to keep tap area tight to content
                        children: [
                          AppTexts.semiBold(
                            // Upgraded weight for better readability
                            "I already have an account",
                            fontSize: 15,
                            color: Colors.grey.shade800,
                          ),
                          const SizedBox(width: 8), // Improved spacing
                          CircularArrowButton(
                            size: 32,
                            iconSize: 18,
                            backgroundColor: AppColors.primaryBlue,
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                context,
                                RouteNames.login,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48), // Bottom padding safe area
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
