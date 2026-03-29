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

class WearablesCatergoryPage extends StatelessWidget {
  const WearablesCatergoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productBloc = context.read<ProductBloc>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchBloc(productBloc: productBloc)),
      ],
      child: const WearablesCatergoryPageUi(),
    );
  }
}

class WearablesCatergoryPageUi extends StatelessWidget {
  const WearablesCatergoryPageUi({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> cards = [
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
