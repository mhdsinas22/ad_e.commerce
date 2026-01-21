import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_bloc.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_event.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_state.dart';
import 'package:ad_e_commerce/features/cart/data/datasources/cart_remote_datasourceimpl.dart';
import 'package:ad_e_commerce/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ad_e_commerce/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:ad_e_commerce/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:ad_e_commerce/features/cart/presentation/widgets/cart_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final cartRepository = CartRepositoryImpl(
      CartRemoteDatasourceimpl(supabase),
    );
    final addtoCartusecase = AddToCartUsecase(cartRepository);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  CartBloc(addtoCartusecase, cartRepository)
                    ..add(GetCartItemsEvent()),
        ),
      ],
      child: _CartPage(),
    );
  }
}

class _CartPage extends StatelessWidget {
  const _CartPage();

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
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.status == CartStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == CartStatus.error) {
          return Center(child: Text(state.error ?? "Something went wrong"));
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Items List
          // Expanded(
          //   flex: 2,
          //   child: ListView.separated(
          //     itemCount: CartDummyData.items.length,
          //     separatorBuilder: (context, index) => const SizedBox(height: 16),
          //     itemBuilder: (context, index) {
          //       return CartItemWidget(item: CartDummyData.items[index]);
          //     },
          //   ),
          // ),
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
