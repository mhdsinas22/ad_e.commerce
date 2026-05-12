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

class EarbudsCatergoryPage extends StatelessWidget {
  const EarbudsCatergoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productBloc = context.read<ProductBloc>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchBloc(productBloc: productBloc)),
      ],
      child: const EarbudsCatergoryPageUi(),
    );
  }
}

class EarbudsCatergoryPageUi extends StatelessWidget {
  const EarbudsCatergoryPageUi({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> cards = [
      OptionCard(
        onTap: () {
          context.pushNamed(
            RouteNames.categoryfiltredpage,
            extra: {
              "condition": PhoneCondition.empty,
              "subCategory": SubCategory.appleairpods,
              "isSubCategory": true,
              "isFlashSale": false,
            },
          );
        },
        title: "Apple Airpods",
        imagePath: AssetConstants.appleairpod,
      ),
      OptionCard(
        onTap: () {
          context.pushNamed(
            RouteNames.categoryfiltredpage,
            extra: {
              "condition": PhoneCondition.empty,
              "subCategory": SubCategory.earbuds,
              "isSubCategory": true,
              "isFlashSale": false,
            },
          );
        },
        title: "Earbuds",
        imagePath: AssetConstants.earbudspng,
      ),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AppSliverAppBar(removeLogo: true),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18.0,
                        vertical: 20,
                      ),
                      child: AppTexts.medium(
                        "Select your Preferences",
                        fontSize: 18,
                      ),
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = 2;
                        if (constraints.maxWidth > 600) crossAxisCount = 3;
                        if (constraints.maxWidth > 800) crossAxisCount = 4;
                        return GridView.count(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1,
                          children: cards,
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
  }
}
