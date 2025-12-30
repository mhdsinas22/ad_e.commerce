import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_sliver_app_bar.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/home/data/category_data.dart';
import 'package:ad_e_commerce/features/home/widgets/category_card.dart';
import 'package:ad_e_commerce/features/home/widgets/CategoryListSection/category_list_section.dart';
import 'package:ad_e_commerce/features/home/widgets/FlashSaleSection/flash_sale_section.dart';
import 'package:ad_e_commerce/features/home/widgets/category_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      // 🔹 RESPONSIVE: Center layout and constrain width for large screens (Web/Tablet)
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: CustomScrollView(
            slivers: [
              // 🔹 APP BAR
              AppSliverAppBar(),
              // 🔹 BODY CONTENT
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // Search
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Appnavigotor.pushnamed(context, RouteNames.search);
                          },
                          child: Container(
                            width: 344,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(width: 10),
                                Expanded(
                                  child: AppTexts.regular(
                                    "Search...",
                                    color: AppColors.grayColor,
                                  ),
                                ),
                                const Icon(
                                  Icons.search,
                                  color: AppColors.grayColor,
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Banner
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          AssetConstants.demoimage,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // const SizedBox(height: 20),

                    // Categories row 1
                    CategoryGrid(
                      categories: CategoryData.categories,
                      layout: CategoryCardLayout.vertical,
                    ),
                    const SizedBox(height: 16),
                    // Categories row 2
                    // 🔹 RESPONSIVE: Prevent overflow on small screens & huge gaps on large screens
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SizedBox(
                              width:
                                  420, // Fixed ideal width (4 items * 80 = 320 + gaps)
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // CategoryCard(
                                  //   width: 80,
                                  //   height: 85,
                                  //   title: "Laptop",
                                  //   image: AssetConstants.laptop,
                                  //   fontsize: 10,
                                  // ),
                                  // CategoryCard(
                                  //   width: 80,
                                  //   height: 85,
                                  //   title: "Tablet",
                                  //   image: AssetConstants.tablet,
                                  //   fontsize: 10,
                                  // ),
                                  // CategoryCard(
                                  //   width: 80,
                                  //   height: 85,
                                  //   title: "Wearable",
                                  //   image: AssetConstants.warables,
                                  //   fontsize: 10,
                                  // ),
                                  // CategoryCard(
                                  //   width: 80,
                                  //   height: 85,
                                  //   title: "Earbuds",
                                  //   image: AssetConstants.earbuds,
                                  //   fontsize: 10,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Flash sale header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTexts.medium("Flash Sale", fontSize: 18),
                          GestureDetector(
                            onTap: () {
                              // Handle View All tap
                            },
                            child: AppTexts.medium(
                              "View All",
                              fontSize: 12,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Flash sale section
                    FlashSaleSection(),

                    const SizedBox(height: 20),

                    // Best Sellers Grids
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  AssetConstants.under10png,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Image.asset(
                                  AssetConstants.under30kpng,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  AssetConstants.under50kpng,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Image.asset(
                                  AssetConstants.under50kkpng,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Best Selling Lists
                    CategoryListSection(),

                    const SizedBox(height: 20),

                    // AirDrop Assurance
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTexts.medium("AIRDROP Assurance", fontSize: 18),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  AssetConstants.aIRDROPAssuranceimg1,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Image.asset(
                                  AssetConstants.aIRDROPAssuranceimg2,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  AssetConstants.aIRDROPAssuranceimg3,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Image.asset(
                                  AssetConstants.aIRDROPAssuranceimg4,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Benefits
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTexts.medium("AIRDROP Benefits", fontSize: 18),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 160,
                            decoration: BoxDecoration(
                              color: AppColors.brightBlue,
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Happy Customers
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTexts.medium("Our Happy Customers", fontSize: 18),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 214,
                                  decoration: BoxDecoration(
                                    color: AppColors.brightBlue,
                                    borderRadius: BorderRadius.circular(18),
                                    // 🔹 Note: Keeping fixed height as per design, Expanded handles width scaling.
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Center(
                                    child: Text(
                                      "AIRDROP has always been my first option for the past 5 years",
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.pureWhite,
                                        height: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 5,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  height: 214,
                                  decoration: BoxDecoration(
                                    color: AppColors.brightBlue,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Center(
                                    child: Text(
                                      "AIRDROP has always been my first option for the past 5 years",
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.pureWhite,
                                        height: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Customer Names
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTexts.medium(
                                      "Customer",
                                      color: AppColors.grayColor,
                                      fontSize: 12,
                                    ),
                                    const SizedBox(height: 4),
                                    AppTexts.semiBold(
                                      "MR. MOHAMMED SHAHAM CK",
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTexts.medium(
                                      "Customer",
                                      color: AppColors.grayColor,
                                      fontSize: 12,
                                    ),
                                    const SizedBox(height: 4),
                                    AppTexts.semiBold(
                                      "MR. MOHAMMED SHAHAM CK",
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Footer (Warranty & Why AirDrop)
                    // 🔹 RESPONSIVE: Use double.infinity instead of MediaQuery width to respect constraints
                    AspectRatio(
                      aspectRatio: 375 / 367, // use SVG design size
                      child: SvgPicture.asset(
                        AssetConstants.howtoClaimwarrntysvg,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
