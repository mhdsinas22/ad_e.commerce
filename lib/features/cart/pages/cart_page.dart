import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/cart/presentation/dummy/cart_dummy_data.dart';
import 'package:ad_e_commerce/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:ad_e_commerce/features/cart/presentation/widgets/cart_summary_widget.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CircleAvatar(
            backgroundColor: AppColors.offWhite,
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        title: AppTexts.bold("My Carts", fontSize: 18),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isDesktop = constraints.maxWidth > 800;

            if (isDesktop) {
              return _buildDesktopLayout();
            } else {
              return _buildMobileLayout();
            }
          },
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: CartDummyData.items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return CartItemWidget(item: CartDummyData.items[index]);
            },
          ),
        ),
        const CartSummaryWidget(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Items List
          Expanded(
            flex: 2,
            child: ListView.separated(
              itemCount: CartDummyData.items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return CartItemWidget(item: CartDummyData.items[index]);
              },
            ),
          ),
          const SizedBox(width: 40),
          // Summary Side
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.lightGrey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const CartSummaryWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
