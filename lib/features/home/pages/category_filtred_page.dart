import 'package:ad_e_commerce/core/common/widgets/shimmer/app_shimmer.dart';
import 'package:ad_e_commerce/core/utils/helpers.dart';
import 'package:ad_e_commerce/core/widgets/app_sliver_app_bar.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_bloc.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_state.dart';
import 'package:ad_e_commerce/features/search/bloc/search_bloc.dart';
import 'package:ad_e_commerce/features/search/bloc/search_state.dart';
import 'package:ad_e_commerce/features/search/widgets/search_bar.dart';
import 'package:ad_e_commerce/features/search/widgets/search_product_grid_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PhoneCondition { brandNew, preOwned, empty }

enum Category { wearables, tablet, phones, laptop, earbuds, accessories, empty }

enum SubCategory {
  macbook,
  windows,
  appleipad,
  tab,
  applewatch,
  smartwatch,
  appleairpods,
  earbuds,
  casescover,
  mobilechargers,
  speaker,
  audio,
  powerbank,
  bag,
  empty,
}

class CategoryFiltredPage extends StatelessWidget {
  final PhoneCondition condition;
  final SubCategory subCategory;
  final Category category;
  final bool isSubCategory;
  final bool isFlashSale;
  final bool isBestSeller;
  final String? priceTYpe;
  final int? priceAmount;
  final bool onlyPhones;
  const CategoryFiltredPage({
    super.key,
    required this.condition,
    required this.subCategory,
    this.isSubCategory = false,
    this.isFlashSale = false,
    this.isBestSeller = false,
    this.priceAmount,
    this.priceTYpe,
    this.onlyPhones = false,
    this.category = Category.empty,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => SearchBloc(productBloc: context.read<ProductBloc>()),
        ),
      ],
      child: LayoutBuilder(
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
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                AppSliverAppBar(),

                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SearchBarw(),
                      BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (state.productStatus == ProductStatus.loading) {
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
                          if (state.productStatus == ProductStatus.success) {
                            final baseFilteredList =
                                state.products.where((product) {
                                  final matchCondition =
                                      condition == PhoneCondition.empty ||
                                      product.condition ==
                                          Helpers.conditionToString(condition);
                                  final matchCategory =
                                      category == Category.empty ||
                                      product.category ==
                                          Helpers.categoryToString(category);
                                  final matchSubCategory =
                                      !isSubCategory ||
                                      product.subCategory ==
                                          Helpers.subCategoryToString(
                                            subCategory,
                                          );
                                  final matchFlashSale =
                                      !isFlashSale ||
                                      product.tag == "Flash Sale";
                                  final matchBestSeller =
                                      !isBestSeller ||
                                      product.tag == "Best Seller";
                                  final matchpricebestsellter =
                                      priceAmount == null
                                          ? true
                                          : priceTYpe == "Under"
                                          ? product.price <= priceAmount!
                                          : product.price >= priceAmount!;
                                  final matchPhoneCategory =
                                      !onlyPhones ||
                                      product.category == "Phones";

                                  return matchCondition &&
                                      matchSubCategory &&
                                      matchFlashSale &&
                                      matchPhoneCategory &&
                                      matchBestSeller &&
                                      matchpricebestsellter &&
                                      matchCategory;
                                }).toList();

                            return BlocBuilder<SearchBloc, SearchState>(
                              builder: (context, state) {
                                final query = state.query.toLowerCase();
                                final finallist =
                                    baseFilteredList.where((product) {
                                      if (query.isEmpty) return true;
                                      return product.title
                                              .toLowerCase()
                                              .contains(query) ||
                                          product.price
                                              .toString()
                                              .toLowerCase()
                                              .contains(query);
                                    }).toList();
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
                                            "Result: ${finallist.length} Items Found",
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
                                                  crossAxisCount:
                                                      crossAxisCount,
                                                  mainAxisSpacing: 16,
                                                  crossAxisSpacing: 16,
                                                  childAspectRatio:
                                                      childAspectRatio,
                                                  mainAxisExtent:
                                                      screenWidth < 600
                                                          ? 320
                                                          : 360,
                                                ),
                                            itemCount: finallist.length,
                                            itemBuilder: (context, index) {
                                              final product = finallist[index];

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
                              },
                            );
                          }
                          if (state.productStatus == ProductStatus.failure) {
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
                                  child: Center(child: Text("sorryy")),
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
            ),
          );
        },
      ),
    );
  }
}
