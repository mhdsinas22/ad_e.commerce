import 'package:ad_e_commerce/core/enums/category.dart';
import 'package:ad_e_commerce/core/enums/phone_condition.dart';
import 'package:ad_e_commerce/core/enums/sub_category.dart';
import 'package:ad_e_commerce/core/services/product_filter_service.dart';
import 'package:ad_e_commerce/core/widgets/app_sliver_app_bar.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/shimmer_product_grid.dart';
import 'package:ad_e_commerce/features/home/widgets/CategoryListSection/widgets/filter_dropdown_section.dart';
import 'package:ad_e_commerce/features/home/widgets/product_grid_section.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_bloc.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_event.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_state.dart';
import 'package:ad_e_commerce/features/search/bloc/search_bloc.dart';
import 'package:ad_e_commerce/features/search/bloc/search_state.dart';
import 'package:ad_e_commerce/features/search/widgets/search_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductBloc>().add(ResetProductFilters());
    });
    final bool showConditionDropdown =
        subCategory != SubCategory.bag &&
        subCategory != SubCategory.audio &&
        subCategory != SubCategory.powerbank &&
        subCategory != SubCategory.casescover &&
        subCategory != SubCategory.mobilechargers &&
        subCategory != SubCategory.speaker &&
        subCategory != SubCategory.fresh &&
        subCategory != SubCategory.second;
    final bool showWarrantyDropdown =
        subCategory == SubCategory.fresh || subCategory == SubCategory.second;
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
                AppSliverAppBar(removeLogo: true),

                SliverToBoxAdapter(
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Column(
                        children: [
                          SearchBarw(),
                          BlocBuilder<ProductBloc, ProductState>(
                            builder: (context, state) {
                              if (state.productStatus ==
                                  ProductStatus.loading) {
                                return ShimmerProductGrid(
                                  crossAxisCount: crossAxisCount,
                                  childAspectRatio: childAspectRatio,
                                );
                              }
                              if (state.productStatus ==
                                  ProductStatus.success) {
                                final basefilteredlist =
                                    ProductFilterService.applyFilters(
                                      products: state.products,
                                      condition: condition,
                                      subCategory: subCategory,
                                      category: category,
                                      isSubCategory: isSubCategory,
                                      isFlashSale: isFlashSale,
                                      isBestSeller: isBestSeller,
                                      priceAmount: priceAmount,
                                      priceType: priceTYpe,
                                      onlyPhones: onlyPhones,
                                      state: state,
                                      query: "",
                                    );
                                return BlocBuilder<SearchBloc, SearchState>(
                                  builder: (context, state) {
                                    final query = state.query.toLowerCase();
                                    final finallist =
                                        basefilteredlist.where((product) {
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
                                            FilterDropdownSection(
                                              showConditionDropdown:
                                                  showConditionDropdown,
                                              showWarrantyDropdown:
                                                  showWarrantyDropdown,
                                              finallistLength: finallist.length,
                                            ),
                                            ProductGridSection(
                                              products: finallist,
                                              crossAxisCount: crossAxisCount,
                                              childAspectRatio:
                                                  childAspectRatio,
                                              screenWidth: screenWidth,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                              if (state.productStatus ==
                                  ProductStatus.failure) {
                                return const Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Center(
                                    child: Text("No products found"),
                                  ),
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
            ),
          );
        },
      ),
    );
  }
}
