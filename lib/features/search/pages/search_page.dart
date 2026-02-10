import 'package:ad_e_commerce/core/common/widgets/shimmer/app_shimmer.dart';
import 'package:ad_e_commerce/core/widgets/app_sliver_app_bar.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/home/data/category_data.dart';
import 'package:ad_e_commerce/features/home/widgets/category_card.dart';
import 'package:ad_e_commerce/features/home/widgets/category_grid.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_bloc.dart';
import 'package:ad_e_commerce/features/search/bloc/search_bloc.dart';
import 'package:ad_e_commerce/features/search/bloc/search_state.dart';
import 'package:ad_e_commerce/features/search/widgets/search_bar.dart';
import 'package:ad_e_commerce/features/search/widgets/search_product_grid_item.dart';

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
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        // Search Bar
                        SearchBarw(),
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
                                  constraints: const BoxConstraints(
                                    maxWidth: 1200,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                childAspectRatio:
                                                    childAspectRatio,
                                                mainAxisExtent:
                                                    screenWidth < 600
                                                        ? 320
                                                        : 360,
                                              ),
                                          itemCount: state.product.length,
                                          itemBuilder: (context, index) {
                                            final product =
                                                state.product[index];
                                            return SearchProductGridItem(
                                              product: product,
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
