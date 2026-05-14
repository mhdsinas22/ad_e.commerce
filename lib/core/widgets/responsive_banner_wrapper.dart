import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/core/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ResponsiveBannerWrapper extends StatelessWidget {
  final Widget child;
  final String desktopTitle;
  final String desktopSubtitle;
  final String? mobileTitle;
  final String? buttonText;
  final VoidCallback? onButtonTap;

  const ResponsiveBannerWrapper({
    super.key,
    required this.child,
    required this.desktopTitle,
    required this.desktopSubtitle,
    this.mobileTitle,
    this.buttonText,
    this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = MediaQuery.of(context).size.width;

        if (width > 1024) {
          // Desktop 2-column layout
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 24.0,
                  left: 24.0,
                  right: 24.0,
                  top: 16.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left Side Text
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppTexts.bold(
                              desktopTitle,
                              fontSize: 48,
                              color: AppColors.primaryBlack,
                              height: 1.1,
                            ),
                            if (desktopSubtitle.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              AppTexts.regular(
                                desktopSubtitle,
                                fontSize: 18,
                                color: AppColors.grayColor,
                                height: 1.5,
                              ),
                            ],
                            if (buttonText != null && onButtonTap != null) ...[
                              const SizedBox(height: 32),
                              ElevatedButton(
                                onPressed: onButtonTap,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryBlack,
                                  foregroundColor: AppColors.pureWhite,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 0,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppTexts.medium(
                                      buttonText!,
                                      fontSize: 16,
                                      color: AppColors.pureWhite,
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.arrow_forward,
                                      size: 18,
                                      color: AppColors.pureWhite,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    // Right Side Image
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: child,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (width > 600) {
          // Tablet Layout (Slightly improved spacing & stacked)
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (mobileTitle != null) ...[
                  AppTexts.bold(mobileTitle!, fontSize: 24),
                  const SizedBox(height: 16),
                ],
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: child,
                ),
              ],
            ),
          );
        }

        // Mobile Layout (< 600px) - EXACTLY SAME AS ORIGINAL
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (mobileTitle != null) ...[
                AppTexts.medium(mobileTitle!, fontSize: 18),
                const SizedBox(height: 16),
              ],
              ClipRRect(borderRadius: BorderRadius.circular(20), child: child),
            ],
          ),
        );
      },
    );
  }
}
