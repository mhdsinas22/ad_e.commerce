import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_sliver_app_bar.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/app_text_form_field.dart';
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
    final products = context.read<ProductBloc>().state.products;
    return BlocProvider(
      create: (context) => SearchBloc(products: products),
      child: _SearchPage(),
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
                SizedBox(height: 10),
                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state.status == SearchStatus.loading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state.status == SearchStatus.loaded) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.product.length,
                        itemBuilder: (context, index) {
                          final product = state.product[index];
                          return ListTile(
                            title: Text(product.title),
                            subtitle: Text(product.category),
                          );
                        },
                      );
                    }
                    return CategoryGrid(
                      categories: CategoryData.categories,
                      layout: CategoryCardLayout.horizontal,
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
