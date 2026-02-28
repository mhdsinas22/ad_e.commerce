import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/profile/bloc/wallet/wallet_bloc.dart';
import 'package:ad_e_commerce/features/profile/bloc/wallet/wallet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletCreditCard extends StatelessWidget {
  const WalletCreditCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Gradient Section
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 38, 74, 114), // Lighter blue/cyan
                    Color(0xFF2E7BFF), // Mid blue
                    Color(0xFF8DA4FF), // Light purple hint
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Custom Icon (Top Left)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.dashboard_customize_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      // Contactless Icon
                      const Icon(
                        Icons.contactless_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTexts.semiBold("NAME", color: AppColors.pureWhite),
                          const SizedBox(height: 4),
                          BlocBuilder<WalletBloc, WalletState>(
                            builder: (context, state) {
                              return AppTexts.semiBold(
                                state.username,
                                fontSize: 18,
                                color: AppColors.pureWhite,
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          AppTexts.regular(
                            "NUMBER",
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 12,
                          ),
                          const SizedBox(height: 4),
                          BlocBuilder<WalletBloc, WalletState>(
                            builder: (context, state) {
                              return Text(
                                state.walletNumber,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Bottom Solid Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: AppColors.primaryBlue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<WalletBloc, WalletState>(
                        builder: (context, state) {
                          return Text(
                            "₹ ${state.balance}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Balance",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  // AirDrop Logo Placeholder
                  Row(
                    children: [
                      // A styled text for "AirDrop"
                      // Since we don't have the specific logo asset, we recreate the text style
                      // "Air" normal, "Drop" with a specific look, or just the text
                      // The image has a logo. I'll simulate it with text and icon.
                      const Icon(Icons.air, color: Colors.white, size: 20),
                      const SizedBox(width: 4),
                      const Text(
                        "AirDrop",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
