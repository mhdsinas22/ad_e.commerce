import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/features/profile/widgets/wallet/transaction_history_list.dart';
import 'package:ad_e_commerce/features/profile/widgets/wallet/wallet_credit_card.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        title: const Text(
          "Wallet",
          style: TextStyle(
            color: AppColors.pureBlack,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.veryLightGrey,
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.pureBlack,
                size: 20,
              ),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive width for larger screens (e.g., tablet/web)
          final isLargeScreen = constraints.maxWidth > 600;
          final contentWidth = isLargeScreen ? 600.0 : double.infinity;

          return Center(
            child: SizedBox(
              width: contentWidth,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const WalletCreditCard(),
                    const SizedBox(height: 32),
                    const TransactionHistoryList(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
