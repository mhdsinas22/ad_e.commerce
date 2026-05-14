import 'package:aerstore/core/common/widgets/shimmer/app_shimmer.dart';
import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/core/widgets/app_text.dart';
import 'package:aerstore/features/cart/bloc/cart_bloc.dart';
import 'package:aerstore/features/cart/bloc/cart_state.dart';
import 'package:aerstore/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:aerstore/features/cart/presentation/widgets/cart_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _CartPage();
  }
}

class _CartPage extends StatefulWidget {
  const _CartPage();

  @override
  State<_CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<_CartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        leading:
            context.canPop()
                ? Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: CircleAvatar(
                      backgroundColor: AppColors.offWhite,
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                )
                : null,
        title: AppTexts.bold("My Carts", fontSize: 18),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
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
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state.actionError != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.actionError!)));
        }
      },
      builder: (context, state) {
        if (state.status == CartStatus.loading) {
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: 4,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return AppShimmer.listTile(hasImage: true);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: AppShimmer.rect(
                  width: double.infinity,
                  height: 150,
                  radius: 12,
                ),
              ),
            ],
          );
        }
        if (state.cartitems.isEmpty) {
          return const Center(child: Text("Cart is empty"));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: state.cartitems.length,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return CartItemWidget(item: state.cartitems[index]);
                },
              ),
            ),
            const CartSummaryWidget(),
          ],
        );
      },
    );
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state.status == CartStatus.error && state.actionError != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.actionError!)));
          }
        },
        builder: (context, state) {
          if (state.status == CartStatus.loading) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Items List
                Expanded(
                  flex: 2,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: 4,
                    separatorBuilder:
                        (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return AppShimmer.listTile(hasImage: true);
                    },
                  ),
                ),
                const SizedBox(width: 40),
                // Summary Side
                Expanded(
                  flex: 1,
                  child: AppShimmer.rect(
                    width: double.infinity,
                    height: 300,
                    radius: 12,
                  ),
                ),
              ],
            );
          }
          if (state.status == CartStatus.error) {
            return Center(child: Text(state.error ?? "Something went wrong"));
          }
          if (state.cartitems.isEmpty) {
            return const Center(child: Text("Cart is empty"));
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Items List
              Expanded(
                flex: 2,
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: state.cartitems.length,
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return CartItemWidget(item: state.cartitems[index]);
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
          );
        },
      ),
    );
  }
}
