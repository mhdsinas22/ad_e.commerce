import 'package:ad_e_commerce/core/common/widgets/shimmer/app_shimmer.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';

import 'package:ad_e_commerce/core/widgets/app_sliver_app_bar.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/app_text_form_field.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_bloc.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_event.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_state.dart';

import 'package:ad_e_commerce/features/home/data/category_data.dart';
import 'package:ad_e_commerce/features/home/widgets/category_card.dart';
import 'package:ad_e_commerce/features/home/widgets/category_grid.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_bloc.dart';
import 'package:ad_e_commerce/features/search/bloc/search_bloc.dart';
import 'package:ad_e_commerce/features/search/bloc/search_event.dart';
import 'package:ad_e_commerce/features/search/bloc/search_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(productBloc: context.read<ProductBloc>()),
      child: const _SearchPage(),
    );
  }
}

class _SearchPage extends StatelessWidget {
  const _SearchPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;

          // Responsive Grid Count
          int crossAxisCount = 2;
          if (screenWidth > 1200) {
            crossAxisCount = 5;
          } else if (screenWidth > 900) {
            crossAxisCount = 4;
          } else if (screenWidth > 600) {
            crossAxisCount = 3;
          }

          // Responsive Aspect Ratio to prevent overflow
          double childAspectRatio = 0.68;
          if (screenWidth > 600) childAspectRatio = 0.75;
          if (screenWidth > 1200) childAspectRatio = 0.8;

          return CustomScrollView(
            slivers: [
              AppSliverAppBar(showBack: true),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    // Search Bar
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 800),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: AppTextFormField(
                          onChanged: (value) {
                            context.read<SearchBloc>().add(
                              SerachTextChanged(query: value),
                            );
                          },
                          width: double.infinity,
                          borderradiusno: 12,
                          hintText: "Search...",
                          suffixIcon: const Icon(
                            Icons.search,
                            color: AppColors.grayColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        if (state.status == SearchStatus.loading) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    mainAxisSpacing: 16,
                                    crossAxisSpacing: 16,
                                    childAspectRatio: childAspectRatio,
                                    mainAxisExtent:
                                        screenWidth < 600 ? 320 : 360,
                                  ),
                              itemCount: 8,
                              itemBuilder: (context, index) {
                                return AppShimmer.productCard();
                              },
                            ),
                          );
                        }
                        if (state.status == SearchStatus.loaded) {
                          return Center(
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 1200),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 10.0,
                                    ),
                                    child: AppTexts.medium(
                                      "Result: ${state.product.length} Items Found",
                                      color: Colors.grey.shade700,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    child: GridView.builder(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: crossAxisCount,
                                            mainAxisSpacing: 16,
                                            crossAxisSpacing: 16,
                                            childAspectRatio: childAspectRatio,
                                            mainAxisExtent:
                                                screenWidth < 600 ? 320 : 360,
                                          ),
                                      itemCount: state.product.length,
                                      itemBuilder: (context, index) {
                                        final product = state.product[index];

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Image Card
                                            Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: const Color(
                                                  0xFFF3F4F6,
                                                ), // Light gray bg
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: AspectRatio(
                                                aspectRatio: 1,
                                                child: Image.network(
                                                  product.imageUrls.isNotEmpty
                                                      ? product.imageUrls.first
                                                      : '',
                                                  fit: BoxFit.contain,
                                                  errorBuilder:
                                                      (c, o, s) => const Icon(
                                                        Icons
                                                            .image_not_supported,
                                                        color: Colors.grey,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),

                                            // Title and Rating Row
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    product.title,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontFamily: "Manrope",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      color:
                                                          AppColors.grayColor,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 4),
                                                const Icon(
                                                  Icons.star_rounded,
                                                  color: Colors.amber,
                                                  size: 20,
                                                ),
                                                const SizedBox(width: 2),
                                                AppTexts.medium(
                                                  "4.9",
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),

                                            // Price
                                            AppTexts.semiBold(
                                              // Simple formatting for comma separation
                                              "₹ ${product.price.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                            const SizedBox(height: 8),

                                            // Action Button
                                            SizedBox(
                                              height: 38,
                                              child:
                                                  product.isActive
                                                      ? BlocBuilder<
                                                        CartBloc,
                                                        CartState
                                                      >(
                                                        builder: (
                                                          context,
                                                          state,
                                                        ) {
                                                          final isInCart = state
                                                              .cartitems
                                                              .any(
                                                                (element) =>
                                                                    element
                                                                        .productId ==
                                                                    product.id,
                                                              );
                                                          if (state.status ==
                                                              CartStatus
                                                                  .loading) {
                                                            return const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            );
                                                          }
                                                          if (isInCart) {
                                                            return SizedBox(
                                                              width: 120,
                                                              child: ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor:
                                                                      const Color(
                                                                        0xFF0055FF,
                                                                      ), // Design Blue
                                                                  foregroundColor:
                                                                      Colors
                                                                          .white,
                                                                  elevation: 0,
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          100,
                                                                        ),
                                                                  ),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                ),
                                                                onPressed: () {
                                                                  Appnavigotor.pushnamed(
                                                                    context,
                                                                    RouteNames
                                                                        .cart,
                                                                    [],
                                                                  );
                                                                },
                                                                child: const Text(
                                                                  " View Cart",
                                                                  style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          return SizedBox(
                                                            width: 120,
                                                            child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    const Color(
                                                                      0xFF0055FF,
                                                                    ), // Design Blue
                                                                foregroundColor:
                                                                    Colors
                                                                        .white,
                                                                elevation: 0,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        100,
                                                                      ),
                                                                ),
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                              ),
                                                              onPressed: () {
                                                                context.read<CartBloc>().add(
                                                                  AddToCartEvent(
                                                                    productid:
                                                                        product
                                                                            .id!,
                                                                    storename:
                                                                        product
                                                                            .storageName,
                                                                    price:
                                                                        product
                                                                            .price,
                                                                  ),
                                                                );
                                                              },
                                                              child: const Text(
                                                                "Add to Cart",
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      )
                                                      : Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                              top: 4,
                                                            ),
                                                        child:
                                                            AppTexts.semiBold(
                                                              "Out of Stock",
                                                              color:
                                                                  AppColors
                                                                      .purered,
                                                              fontSize: 12,
                                                            ),
                                                      ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        if (state.status == SearchStatus.empty) {
                          return const Padding(
                            padding: EdgeInsets.all(30),
                            child: Center(child: Text("No products found")),
                          );
                        }
                        // Initial State
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 22,
                              ),
                              child: Center(
                                child: Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 1200,
                                  ),
                                  width: double.infinity,
                                  child: AppTexts.medium(
                                    "Select a Category to Browse",
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 1200,
                                ),
                                child: CategoryGrid(
                                  categories: CategoryData.categories,
                                  layout: CategoryCardLayout.horizontal,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
