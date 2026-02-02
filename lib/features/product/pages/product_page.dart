import 'package:ad_e_commerce/core/constants/app_icons.dart';
import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/circular_arrow_button.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_bloc.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_event.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_state.dart';
import 'package:ad_e_commerce/features/product/domain/entites/product.dart';
import 'package:ad_e_commerce/features/product/widgets/product_image_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return _ProductPage(product: product);
  }
}

class _ProductPage extends StatelessWidget {
  final Product product;
  const _ProductPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ProductImageCarousel(images: product.imageUrls),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircularArrowButton(
                            iconSize: 25,
                            size: 50,
                            needCircle: true,
                            iconColor: AppColors.pureBlack,
                            icon: Icons.arrow_back,
                            backgroundColor:
                                Colors.white, // Changed to white as per image
                            onTap: () => Navigator.pop(context),
                          ),
                          // Spacer removed to group right icons
                          Row(
                            children: [
                              GestureDetector(
                                onTap:
                                    () => Appnavigotor.pushnamed(
                                      context,
                                      RouteNames.search,
                                      {},
                                    ),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: SvgPicture.asset(AppIcons.serachucon),
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap:
                                    () => Appnavigotor.pushnamed(
                                      context,
                                      RouteNames.cart,
                                      {},
                                    ),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: SvgPicture.asset(
                                    AssetConstants.carticonpng,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating Row
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        "${product.rating}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "(${product.noofreviews}) Reviews",
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Title
                  product.storage.isEmpty || product.ram.isEmpty
                      ? Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      )
                      : Text(
                        "${product.title}  (${product.storage})-${product.ram}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                  const SizedBox(height: 4),
                  // Model
                  Text(
                    "Model: ${product.modelNumber}",
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 16),
                  // Price
                  Row(
                    children: [
                      Text(
                        "₹ ${product.price.toStringAsFixed(0)}", // Assuming typical formatting
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      AppTexts.bold(
                        "₹ ${product.originalPrice?.toStringAsFixed(0)}", // Assuming typical formatting
                        fontSize: 20,
                        color: AppColors.purered,
                        isOffer: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Key Features",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AppTexts.medium(
                          "${product.description}",
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                  // Key Features Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "View All",
                          style: TextStyle(
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Placeholder for features list
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTexts.medium("AIRDROP Assurance", fontSize: 18),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          AssetConstants.aIRDROPAssuranceimg1,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Image.asset(
                          AssetConstants.aIRDROPAssuranceimg2,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          AssetConstants.aIRDROPAssuranceimg3,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Image.asset(
                          AssetConstants.aIRDROPAssuranceimg4,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: BlocListener<CartBloc, CartState>(
                    listenWhen: (previous, current) {
                      return previous.isAdding &&
                          !current.isAdding &&
                          previous.cartitems.length < current.cartitems.length;
                    },
                    listener: (context, state) {
                      if (state.status == CartStatus.loaded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Item Added To Cart"),
                            backgroundColor: AppColors.pureBlack,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                      if (state.status == CartStatus.error) {
                        // ❌ ERROR SNACKBAR
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.error ?? "Something went wrong",
                            ),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        final isInCart = state.cartitems.any(
                          (element) => element.productId == product.id,
                        );
                        // ⏳ Loading
                        if (state.status == CartStatus.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (isInCart) {
                          return OutlinedButton(
                            onPressed: () {
                              Appnavigotor.pushnamed(
                                context,
                                RouteNames.cart,
                                {},
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.black),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: const Text(
                              "View Cart",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          );
                        }
                        // ➕ Default → ADD TO CART
                        return OutlinedButton(
                          onPressed: () {
                            context.read<CartBloc>().add(
                              AddToCartEvent(
                                productid: product.id!,
                                storename: "",
                                price: product.price,
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Text(
                            "Add to cart",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.primaryBlue, // Approximate Blue from image
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Buy Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
