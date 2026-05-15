import 'package:aerstore/core/constants/asset_constants.dart';
import 'package:aerstore/core/routes/route_names.dart';
import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/core/widgets/app_text.dart';
import 'package:aerstore/core/widgets/circular_arrow_button.dart';
import 'package:aerstore/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingStartpage extends StatelessWidget {
  const OnboardingStartpage({super.key});

  @override
  Widget build(BuildContext context) {
    // Media query for responsive layout
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SizedBox(
            width: double.infinity,
            height: size.height,
            child: Column(
              children: [
                // ---------------- HEADER / IMAGE SECTION ----------------
                // Using a modern curved container for the visual interest

                // ---------------- CONTENT SECTION ----------------
                Expanded(
                  flex: 4, // Takes up ~40% of the screen
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Image.asset(AssetConstants.obboardingpng),
                        const Spacer(),

                        // ---------------- ACTION BUTTONS ----------------
                        // Primary Action
                        PrimaryButton(
                          borderRadius: 16,
                          height: 64, // Slightly taller for modern look
                          width: double.infinity,
                          text: "Let's get started",
                          onPressed: () {
                            context.pushReplacementNamed(RouteNames.signup);
                          },
                        ),

                        const SizedBox(height: 24),

                        // Login Link
                        // Preserving exact logic: InkWell wraps row + Arrow Button functionality
                        InkWell(
                          onTap: () {
                            context.pushReplacementNamed(RouteNames.phoneLogin);
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
                                backgroundColor: AppColors.primaryBlack,
                                onTap: () {
                                  context.pushReplacementNamed(
                                    RouteNames.phoneLogin,
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
        ),
      ),
    );
  }
}
