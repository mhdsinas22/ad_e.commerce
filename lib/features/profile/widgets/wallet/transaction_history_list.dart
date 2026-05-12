import 'package:aerstore/features/profile/domain/enitites/wallet/wallet_transaction.dart';
import 'package:aerstore/features/profile/widgets/wallet/transaction_item_card.dart';
import 'package:flutter/material.dart';

class TransactionHistoryList extends StatelessWidget {
  final List<WalletTransaction> transaction;
  const TransactionHistoryList({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    // Mock Data based on the image

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
        ...transaction.map((tx) {
          final isCredit = tx.type == 'credit';
          return TransactionItemCard(
            title: tx.reason,
            amount: tx.amount.toString(),
            isCredit: isCredit,
            iconInfo: isCredit ? Icons.arrow_forward : Icons.arrow_back,
          );
        }),
      ],
    );
  }
}
