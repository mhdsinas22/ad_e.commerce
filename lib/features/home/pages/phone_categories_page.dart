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

class PhoneCategoriesPage extends StatelessWidget {
  const PhoneCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productBloc = context.read<ProductBloc>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchBloc(productBloc: productBloc)),
      ],
      child: PhoneCategoriesPageUi(),
    );
  }
}

class PhoneCategoriesPageUi extends StatelessWidget {
  const PhoneCategoriesPageUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: [
            AppSliverAppBar(removeLogo: true),
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
                              "SubCategory": SubCategory.fresh,
                              "isSubCategory": true,
                              "isFlashSale": false,
                            },
                          );
                        },
                        title: "Brand new",
                        imagePath: AssetConstants.phone,
                      ),
                      OptionCard(
                        onTap: () {
                          Appnavigotor.pushnamed(
                            context,
                            RouteNames.categoryfiltredpage,
                            {
                              "condition": PhoneCondition.empty,
                              "SubCategory": SubCategory.second,
                              "isSubCategory": true,
                              "isFlashSale": false,
                            },
                          );
                        },
                        title: "Pre-Owned",
                        imagePath: AssetConstants.singlephonepng,
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
