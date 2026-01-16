import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/home/widgets/FlashSaleSection/flash_sale_product_card.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_bloc.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlashSaleSection extends StatelessWidget {
  const FlashSaleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // ⭐ must for horizontal scroll
      child: SizedBox(
        height: 300,
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state.productStatus == ProductStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.productStatus == ProductStatus.failure) {
              return Center(
                child: AppTexts.regular(
                  state.errorMessage ?? "Something went wrong",
                ),
              );
            }
            if (state.flashSaleProducts.isEmpty) {
              return const Center(child: Text("No flash sale products"));
            }
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: state.flashSaleProducts.length,
              separatorBuilder:
                  (_, __) => const SizedBox(width: 10), // ⭐ exact gap
              itemBuilder: (context, index) {
                return FlashSaleCard(product: state.flashSaleProducts[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
