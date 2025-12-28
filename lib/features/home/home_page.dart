import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/app_text_form_field.dart';
import 'package:ad_e_commerce/core/widgets/category_card.dart';
import 'package:ad_e_commerce/features/home/widgets/FlashSaleSection/flash_sale_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite, // same bg
      body: CustomScrollView(
        slivers: [
          // 🔹 APP BAR
          SliverAppBar(
            elevation: 0,
            pinned: true,
            centerTitle: true,

            expandedHeight: 80, // ⭐ important
            backgroundColor: AppColors.pureWhite,

            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final top = constraints.biggest.height;

                return Container(
                  color:
                      top <= kToolbarHeight + 10
                          ? AppColors
                              .pureWhite // scroll cheythappol
                          : Colors.white, // top il
                );
              },
            ),

            title: Image.asset(
              AssetConstants.airdropLetterLogo,
              width: 125,
              height: 57,
            ),

            actions: [
              InkWell(
                onTap: () => Navigator.pushNamed(context, RouteNames.cart),
                child: SvgPicture.asset(AssetConstants.carticonpng, height: 24),
              ),
              const SizedBox(width: 10),
            ],
          ),

          // 🔹 BODY CONTENT
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // Search
                  Center(
                    child: AppTextFormField(
                      width: 380,
                      borderradiusno: 10,
                      hintText: "Search...",
                      suffixIcon: Icon(
                        Icons.search,
                        color: AppColors.grayColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Banner
                  Image.asset(AssetConstants.demoimage),

                  const SizedBox(height: 10),

                  // Categories row 1
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CategoryCard(
                        title: "Phone",
                        image: AssetConstants.phone,
                        fontsize: 12,
                      ),
                      CategoryCard(
                        title: "Accesories",
                        image: AssetConstants.accesories,
                        fontsize: 12,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Categories row 2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CategoryCard(
                        width: 78,
                        height: 80,
                        title: "Laptop",
                        image: AssetConstants.laptop,
                        fontsize: 8,
                      ),
                      CategoryCard(
                        width: 78,
                        height: 80,
                        title: "Tablet",
                        image: AssetConstants.tablet,
                        fontsize: 8,
                      ),
                      CategoryCard(
                        width: 78,
                        height: 80,
                        title: "Wearable",
                        image: AssetConstants.warables,
                        fontsize: 8,
                      ),
                      CategoryCard(
                        width: 78,
                        height: 80,
                        title: "Earbuds",
                        image: AssetConstants.earbuds,
                        fontsize: 8,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Flash sale header
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTexts.medium("Flash Sale", fontSize: 18),
                        AppTexts.medium(
                          "View All",
                          fontSize: 12,
                          color: AppColors.primaryBlue,
                        ),
                      ],
                    ),
                  ),

                  // Flash sale section
                  FlashSaleSection(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
