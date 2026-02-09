import 'package:ad_e_commerce/features/profile/widgets/wallet/transaction_item_card.dart';
import 'package:flutter/material.dart';

class TransactionHistoryList extends StatelessWidget {
  const TransactionHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock Data based on the image
    final transactions = [
      {
        'title': 'Refund',
        'amount': '+80,000',
        'isCredit': true,
        'icon': Icons.arrow_forward,
      },
      {
        'title': 'Phone Purchase',
        'amount': '-80,000',
        'isCredit': false,
        'icon': Icons.arrow_back,
      },
      {
        'title': 'Refund',
        'amount': '+80,000',
        'isCredit': true,
        'icon': Icons.arrow_forward,
      },
      {
        'title': 'Phone Purchase',
        'amount': '-80,000',
        'isCredit': false,
        'icon': Icons.arrow_back,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Transaction History",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black, // Or AppColors.pureBlack
          ),
        ),
        const SizedBox(height: 16),
        ...transactions.map((tx) {
          return TransactionItemCard(
            title: tx['title'] as String,
            amount: tx['amount'] as String,
            isCredit: tx['isCredit'] as bool,
            iconInfo: tx['icon'] as IconData,
          );
        }),
      ],
    );
  }
}
