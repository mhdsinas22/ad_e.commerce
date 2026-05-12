import 'package:aerstore/core/constants/asset_constants.dart';
import 'package:aerstore/core/enums/phone_condition.dart';
import 'package:aerstore/core/enums/sub_category.dart';
import 'package:aerstore/core/routes/route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:aerstore/core/widgets/app_sliver_app_bar.dart';
import 'package:aerstore/core/widgets/app_text.dart';
import 'package:aerstore/core/widgets/common_option_card.dart';

import 'package:aerstore/features/product/bloc/proudctbloc/product_bloc.dart';
import 'package:aerstore/features/search/bloc/search_bloc.dart';
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
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
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
                      LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount = 2;
                          if (constraints.maxWidth > 600) {
                            crossAxisCount = 3;
                          }
                          if (constraints.maxWidth > 900) {
                            crossAxisCount = 4;
                          }
                          return GridView.count(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            shrinkWrap: true,
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1,
                            children: [
                              OptionCard(
                                onTap: () {
                                  context.pushNamed(
                                    RouteNames.categoryfiltredpage,
                                    extra: {
                                      "condition": PhoneCondition.empty,
                                      "subCategory": SubCategory.fresh,
                                      "isSubCategory": true,
                                      "isFlashSale": false,
                                    },
                                  );
                                },
                                title: "Brand new",
                                imagePath: AssetConstants.bestsellingmobilepng,
                              ),
                              OptionCard(
                                onTap: () {
                                  context.pushNamed(
                                    RouteNames.categoryfiltredpage,
                                    extra: {
                                      "condition": PhoneCondition.empty,
                                      "subCategory": SubCategory.second,
                                      "isSubCategory": true,
                                      "isFlashSale": false,
                                    },
                                  );
                                },
                                title: "Pre-Owned",
                                imagePath: AssetConstants.singlephonepng,
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
      ),
    );
  }
}
