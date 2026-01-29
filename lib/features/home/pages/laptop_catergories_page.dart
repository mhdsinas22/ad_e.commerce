import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/widgets/app_sliver_app_bar.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/common_option_card.dart';

import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_bloc.dart';
import 'package:ad_e_commerce/features/search/bloc/search_bloc.dart';
import 'package:ad_e_commerce/features/search/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaptopCatergoriesPage extends StatelessWidget {
  const LaptopCatergoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productBloc = context.read<ProductBloc>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SearchBloc(productBloc: productBloc)),
      ],
      child: LaptopCatergoriesPageUi(),
    );
  }
}

class LaptopCatergoriesPageUi extends StatelessWidget {
  const LaptopCatergoriesPageUi({super.key});

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
                        onTap: () {},
                        title: "Apple Macbook",
                        imagePath: AssetConstants.phone,
                      ),
                      OptionCard(
                        onTap: () {},
                        title: "Windows",
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
