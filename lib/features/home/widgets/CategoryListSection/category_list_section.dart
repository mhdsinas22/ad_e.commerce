import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/circular_arrow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryListSection extends StatelessWidget {
  const CategoryListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: 345,
            height: 156,
            child: Card(
              color: AppColors.pureWhite,
              elevation: 1,
              child: Stack(
                clipBehavior: Clip.none, // ✅ ADD THIS
                children: [
                  Positioned(
                    right: -8, // little overflow looks premium
                    bottom: -6,
                    child: SizedBox(
                      width: 120,
                      height: 140,
                      child: SvgPicture.asset("assets/svg/Rectangle 2.svg"),
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: AppTexts.medium("Best Selling", fontSize: 18),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: AppTexts.semiBold("Mobiles", fontSize: 30),
                      ),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: CircularArrowButton(
                          onTap: () {},
                          size: 30,
                          iconSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        Image.asset(AssetConstants.bestSellingLaptop),

        Image.asset(AssetConstants.bestSellingWearable),

        Image.asset(AssetConstants.bestSellingEarbuds),

        Image.asset(AssetConstants.bestSellingTablet),

        Image.asset(AssetConstants.bestSellingAccesories),
      ],
    );
  }
}
