import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/enums/phone_condition.dart';
import 'package:ad_e_commerce/core/enums/sub_category.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_sliver_app_bar.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/common_option_card.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_bloc.dart';
import 'package:ad_e_commerce/features/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabletCategoriesPage extends StatelessWidget {
  const TabletCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productBloc = context.read<ProductBloc>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchBloc(productBloc: productBloc)),
      ],
      child: TabletCategoriesPageUi(),
    );
  }
}

class TabletCategoriesPageUi extends StatelessWidget {
  const TabletCategoriesPageUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: [
            AppSliverAppBar(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,

                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 20,
                      ),
                      child: AppTexts.medium(
                        "Select your Preferences",
                        fontSize: 18,
                      ),
                    ),
                  ),
                  GridView.count(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1,
                    children: [
                      OptionCard(
                        onTap: () {
                          Appnavigotor.pushnamed(
                            context,
                            RouteNames.categoryfiltredpage,
                            {
                              "condition": PhoneCondition.empty,
                              "SubCategory": SubCategory.appleipad,
                              "isSubCategory": true,
                              "isFlashSale": false,
                            },
                          );
                        },
                        title: "Apple iPad",
                        imagePath: AssetConstants.appleipadpng,
                      ),
                      OptionCard(
                        onTap: () {
                          Appnavigotor.pushnamed(
                            context,
                            RouteNames.categoryfiltredpage,
                            {
                              "condition": PhoneCondition.empty,
                              "SubCategory": SubCategory.tab,
                              "isSubCategory": true,
                              "isFlashSale": false,
                            },
                          );
                        },
                        title: "Tab",
                        imagePath: AssetConstants.tabletpng,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
