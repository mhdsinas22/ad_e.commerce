import 'package:aerstore/core/routes/route_names.dart';
import 'package:aerstore/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:aerstore/features/cart/bloc/cart_bloc.dart';
import 'package:aerstore/features/cart/bloc/cart_event.dart';
import 'package:aerstore/features/cart/bloc/cart_state.dart';
import 'package:aerstore/features/product/domain/entites/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCartButtonLogic extends StatelessWidget {
  final Product product;

  const SearchCartButtonLogic({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final isInCart = state.cartitems.any((e) => e.productId == product.id);
        final isLoading = state.loadingProductid == product.id;

        return SizedBox(
          width: 120,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlack,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              padding: EdgeInsets.zero,
            ),
            onPressed: () {
              if (isInCart) {
                context.pushNamed(RouteNames.cart);
              } else {
                context.read<CartBloc>().add(
                  AddToCartEvent(
                    imageUrl: product.imageUrls[0],
                    productid: product.id!,
                    storename: product.storage,
                    price: product.price,
                    noOfRating: product.noofreviews.toString(),
                    rating: product.rating.toString(),
                    modelNumber: product.modelNumber.toString(),
                    title: product.title.toString(),
                    color: product.color,
                    storage: product.storage,
                  ),
                );
              }
            },
            child:
                isLoading
                    ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                    : Text(
                      isInCart ? "View Cart" : "Add to Cart",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
          ),
        );
      },
    );
  }
}
