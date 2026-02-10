import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_sliver_app_bar.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/common_option_card.dart';
import 'package:ad_e_commerce/features/home/pages/category_filtred_page.dart';

import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_bloc.dart';
import 'package:ad_e_commerce/features/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccesoriesCategoriesPage extends StatelessWidget {
  const AccesoriesCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productBloc = context.read<ProductBloc>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchBloc(productBloc: productBloc)),
      ],
      child: AccesoriesCategoriesPageUi(),
    );
  }
}

class AccesoriesCategoriesPageUi extends StatelessWidget {
  const AccesoriesCategoriesPageUi({super.key});

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
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.25,
                    children: [
                      OptionCard(
                        isVertical: true,
                        onTap: () {
                          Appnavigotor.pushnamed(
                            context,
                            RouteNames.categoryfiltredpage,
                            {
                              "condition": PhoneCondition.empty,
                              "SubCategory": SubCategory.casescover,
                              "isSubCategory": true,
                              "isFlashSale": false,
                            },
                          );
                        },
                        title: "Cases&\n Cover",
                        imagePath: AssetConstants.casepng,
                      ),
                      OptionCard(
                        isVertical: true,
                        onTap: () {
                          Appnavigotor.pushnamed(
                            context,
                            RouteNames.categoryfiltredpage,
                            {
                              "condition": PhoneCondition.empty,
                              "SubCategory": SubCategory.mobilechargers,
                              "isSubCategory": true,
                              "isFlashSale": false,
                            },
                          );
                        },
                        title: "Mobile\nChargers",
                        imagePath: AssetConstants.mobilecharger,
                      ),
                      OptionCard(
                        isVertical: true,
                        onTap: () {
                          Appnavigotor.pushnamed(
                            context,
                            RouteNames.categoryfiltredpage,
                            {
                              "condition": PhoneCondition.empty,
                              "SubCategory": SubCategory.speaker,
                              "isSubCategory": true,
                              "isFlashSale": false,
                            },
                          );
                        },
                        title: "Speaker",
                        imagePath: AssetConstants.boatspeakerpng,
                      ),
                      OptionCard(
                        isVertical: true,
                        onTap: () {
                          Appnavigotor.pushnamed(
                            context,
                            RouteNames.categoryfiltredpage,
                            {
                              "condition": PhoneCondition.empty,
                              "SubCategory": SubCategory.audio,
                              "isSubCategory": true,
                              "isFlashSale": false,
                            },
                          );
                        },
                        title: "Audio",
                        imagePath: AssetConstants.headset,
                      ),
                      OptionCard(
                        isVertical: true,
                        onTap: () {
                          Appnavigotor.pushnamed(
                            context,
                            RouteNames.categoryfiltredpage,
                            {
                              "condition": PhoneCondition.empty,
                              "SubCategory": SubCategory.powerbank,
                              "isSubCategory": true,
                              "isFlashSale": false,
                            },
                          );
                        },
                        title: "Power Bank",
                        imagePath: AssetConstants.powerbank,
                      ),
                      OptionCard(
                        isVertical: true,
                        onTap: () {
                          Appnavigotor.pushnamed(
                            context,
                            RouteNames.categoryfiltredpage,
                            {
                              "condition": PhoneCondition.empty,
                              "SubCategory": SubCategory.bag,
                              "isSubCategory": true,
                              "isFlashSale": false,
                            },
                          );
                        },
                        title: "Bag",
                        imagePath: AssetConstants.bagpng,
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
