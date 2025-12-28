import 'package:ad_e_commerce/features/home/widgets/FlashSaleSection/flash_sale_product_card.dart';
import 'package:flutter/material.dart';

class FlashSaleSection extends StatelessWidget {
  const FlashSaleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // ⭐ must for horizontal scroll
      child: SizedBox(
        height: 300,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: 6,
          separatorBuilder: (_, __) => const SizedBox(width: 10), // ⭐ exact gap
          itemBuilder: (context, index) {
            return const FlashSaleCard();
          },
        ),
      ),
    );
  }
}
