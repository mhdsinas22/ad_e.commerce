import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/aligned_padded_text.dart';
import 'package:ad_e_commerce/core/widgets/app_sliver_app_bar.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/app_text_form_field.dart';
import 'package:ad_e_commerce/core/widgets/primary_button.dart';
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
      body: CustomScrollView(
        slivers: [
          AppSliverAppBar(showBack: true),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Search
                Padding(
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
                const SizedBox(height: 5),

                SizedBox(height: 10),
                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state.status == SearchStatus.loading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state.status == SearchStatus.loaded) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10.0,
                            ),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: AppTexts.medium(
                                "Result: ${state.product.length} Items Found ",
                              ),
                            ),
                          ),
                          GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shrinkWrap:
                                true, // 🔥 IMPORTANT if inside Column / ScrollView
                            physics:
                                const NeverScrollableScrollPhysics(), // parent scroll handle cheyyum
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // ✅ 2 columns
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio:
                                      0.72, // screenshot pole card shape
                                ),
                            itemCount: state.product.length,
                            itemBuilder: (context, index) {
                              final product = state.product[index];

                              return Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 167,
                                      height: 172,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Center(
                                        child: Image.network(
                                          product.imageUrls.first,
                                          fit: BoxFit.contain,
                                          width: 107,
                                          height: 123,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    // TITLE
                                    AlignedPaddedText(
                                      child: AppTexts.medium(
                                        product.title,
                                        fontSize: 12,
                                        color: AppColors.grayColor,
                                      ),
                                    ),

                                    // PRICE
                                    AlignedPaddedText(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: 5,
                                      ),
                                      child: AppTexts.semiBold(
                                        "₹${product.price.toString()}",
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    product.isActive
                                        ? AlignedPaddedText(
                                          child: PrimaryButton(
                                            width: 100,
                                            height: 25,
                                            text: "Add to Cart",
                                            fontsize: 10,
                                            onPressed: () {},
                                          ),
                                        )
                                        : AlignedPaddedText(
                                          child: AppTexts.semiBold(
                                            "Out ofStock",
                                            color: AppColors.purered,
                                            fontSize: 10,
                                          ),
                                        ),

                                    //  Row(
                                    //                                         children: const [
                                    //                                           Icon(
                                    //                                             Icons.star,
                                    //                                             color: Colors.amber,
                                    //                                             size: 16,
                                    //                                           ),
                                    //                                           SizedBox(width: 4),
                                    //                                           Text("4.9"),
                                    //                                         ],
                                    //                                       ),
                                    // RATING + STOCK
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     if (!product.isActive)
                                    //       const Text(
                                    //         "Out of Stock",
                                    //         style: TextStyle(
                                    //           color: Colors.red,
                                    //           fontSize: 12,
                                    //           fontWeight: FontWeight.w600,
                                    //         ),
                                    //       ),
                                    //     if (product.isActive)
                                    //       SizedBox(
                                    //         width: double.infinity,
                                    //         height: 32,
                                    //         child: ElevatedButton(
                                    //           onPressed: () {},
                                    //           child: const Text(
                                    //             "Add to Cart",
                                    //             style: TextStyle(fontSize: 12),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    }
                    if (state.status == SearchStatus.empty) {
                      print("empty");
                      return const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(child: Text("No products found")),
                      );
                    }
                    // initial
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 22,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: AppTexts.medium(
                              "Select a Category to Browse",
                              fontSize: 18,
                            ),
                          ),
                        ),
                        CategoryGrid(
                          categories: CategoryData.categories,
                          layout: CategoryCardLayout.horizontal,
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
  }
}
