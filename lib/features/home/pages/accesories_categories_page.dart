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

class AccesoriesCategoriesPage extends StatelessWidget {
  const AccesoriesCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productBloc = context.read<ProductBloc>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchBloc(productBloc: productBloc)),
      ],
      child: const AccesoriesCategoriesPageUi(),
    );
  }
}

class AccesoriesCategoriesPageUi extends StatelessWidget {
  const AccesoriesCategoriesPageUi({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> cards = [
      OptionCard(
        isVertical: true,
        onTap: () {
          context.push(
            '/${RouteNames.categoryfiltredpage}?'
            'subcategory=${SubCategory.casescover.name}'
            '&condition=${PhoneCondition.empty.name}'
            '&isSubCategory=true'
            '&isFlashSale=false'
            '&search=',
          );
        },
        title: "Cases&\n Cover",
        imagePath: AssetConstants.bestsellingCasespng,
      ),
      OptionCard(
        isVertical: true,
        onTap: () {
          context.push(
            '/${RouteNames.categoryfiltredpage}?'
            'subcategory=${SubCategory.mobilechargers.name}'
            '&condition=${PhoneCondition.empty.name}'
            '&isSubCategory=true'
            '&isFlashSale=false'
            '&search=',
          );
        },
        title: "Mobile\nChargers",
        imagePath: AssetConstants.mobilecharger,
      ),
      OptionCard(
        isVertical: true,
        onTap: () {
          context.push(
            '/${RouteNames.categoryfiltredpage}?'
            'subcategory=${SubCategory.speaker.name}'
            '&condition=${PhoneCondition.empty.name}'
            '&isSubCategory=true'
            '&isFlashSale=false'
            '&search=',
          );
        },
        title: "Speaker",
        imagePath: AssetConstants.boatspeakerpng,
      ),
      OptionCard(
        isVertical: true,
        onTap: () {
          context.push(
            '/${RouteNames.categoryfiltredpage}?'
            'subcategory=${SubCategory.audio.name}'
            '&condition=${PhoneCondition.empty.name}'
            '&isSubCategory=true'
            '&isFlashSale=false'
            '&search=',
          );
        },
        title: "Audio",
        imagePath: AssetConstants.headset,
      ),
      OptionCard(
        isVertical: true,
        onTap: () {
          context.push(
            '/${RouteNames.categoryfiltredpage}?'
            'subcategory=${SubCategory.powerbank.name}'
            '&condition=${PhoneCondition.empty.name}'
            '&isSubCategory=true'
            '&isFlashSale=false'
            '&search=',
          );
        },
        title: "Power Bank",
        imagePath: AssetConstants.powerbank,
      ),
      OptionCard(
        isVertical: true,
        onTap: () {
          context.push(
            '/${RouteNames.categoryfiltredpage}?'
            'subcategory=${SubCategory.bag.name}'
            '&condition=${PhoneCondition.empty.name}'
            '&isSubCategory=true'
            '&isFlashSale=false'
            '&search=',
          );
        },
        title: "Bag",
        imagePath: AssetConstants.bagpng,
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
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.25,
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
