import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/helpers.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DigitalWarrantyCard extends StatelessWidget {
  final String warrantyCode;
  final String status;

  const DigitalWarrantyCard({
    super.key,

    required this.warrantyCode,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final splitCode = splitWarrantyCode(warrantyCode);
    return Container(
      height: 217,
      decoration: BoxDecoration(
        color: AppColors.primaryBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          /// LEFT SIDE
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AssetConstants.airdropletterlogobgremove,
                    color: AppColors.pureWhite,
                    width: 100,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        splitCode['letters']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        splitCode['numbers']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),

                    child: AppTexts.semiBold(
                      status,
                      fontSize: 13.5,
                      color: AppColors.pureWhite,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// RIGHT SIDE (PATTERN)
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  fit: BoxFit.cover,
                  AssetConstants.digitalWarrantyCardVectorSvg,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
