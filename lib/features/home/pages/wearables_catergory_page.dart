import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_sliver_app_bar.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/common_option_card.dart';
import 'package:ad_e_commerce/features/home/pages/category_filtred_page.dart';

import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_bloc.dart';
import 'package:ad_e_commerce/features/search/bloc/search_bloc.dart';
import 'package:ad_e_commerce/features/search/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WearablesCatergoryPage extends StatelessWidget {
  const WearablesCatergoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productBloc = context.read<ProductBloc>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchBloc(productBloc: productBloc)),
      ],
      child: WearablesCatergoryPageUi(),
    );
  }
}

class WearablesCatergoryPageUi extends StatelessWidget {
  const WearablesCatergoryPageUi({super.key});

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
                  SearchBarw(),
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
                              "SubCategory": SubCategory.applewatch,
                              "isSubCategory": true,
                              "isFlashSale": false,
                            },
                          );
                        },
                        title: "Apple Watch",
                        imagePath: AssetConstants.applewatchpng,
                      ),
                      OptionCard(
                        onTap: () {
                          Appnavigotor.pushnamed(
                            context,
                            RouteNames.categoryfiltredpage,
                            {
                              "condition": PhoneCondition.empty,
                              "SubCategory": SubCategory.smartwatch,
                              "isSubCategory": true,
                              "isFlashSale": false,
                            },
                          );
                        },
                        title: "Smart Watch",
                        imagePath: AssetConstants.smartwatch,
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
