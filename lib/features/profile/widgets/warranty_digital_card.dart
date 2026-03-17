import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/helpers.dart';
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
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        color: AppColors.primaryBlack, // Bright blue from reference
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlack.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Right Side Pattern (Background)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 150, // Approximate width for the pattern area
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: SvgPicture.asset(
                AssetConstants.digitalWarrantyCardVectorSvg,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.2),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Logo area
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 32,
                    child: SvgPicture.asset(
                      AssetConstants.aeradjustsvg,
                      color: Colors.white,
                      fit: BoxFit.contain,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
                const SizedBox(height: 32), // 👈 important spacing
                // Code
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      splitCode['letters'] ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      splitCode['numbers'] ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.5,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),

                const Spacer(), // 👈 move spacer here
                // Status
                Text(
                  status.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
