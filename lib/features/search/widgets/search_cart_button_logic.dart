import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_bloc.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_event.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_state.dart';
import 'package:ad_e_commerce/features/product/domain/entites/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCartButtonLogic extends StatelessWidget {
  final Product product;

  const SearchCartButtonLogic({required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final isInCart = state.cartitems.any((e) => e.productId == product.id);

        if (state.status == CartStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SizedBox(
          width: 120,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0055FF),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              padding: EdgeInsets.zero,
            ),
            onPressed: () {
              if (isInCart) {
                Appnavigotor.pushnamed(context, RouteNames.cart, []);
              } else {
                context.read<CartBloc>().add(
                  AddToCartEvent(
                    productid: product.id!,
                    storename: product.storage,
                    price: product.price,
                  ),
                );
              }
            },
            child: Text(
              isInCart ? "View Cart" : "Add to Cart",
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        );
      },
    );
  }
}
