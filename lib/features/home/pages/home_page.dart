import 'package:ad_e_commerce/core/common/widgets/shimmer/app_shimmer.dart';
import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_sliver_app_bar.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/cart/bloc/cart_bloc.dart';
import 'package:ad_e_commerce/features/cart/data/datasources/cart_remote_datasourceimpl.dart';
import 'package:ad_e_commerce/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ad_e_commerce/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:ad_e_commerce/features/home/bloc/testmonialsbloc/testimonial_bloc.dart';
import 'package:ad_e_commerce/features/home/bloc/testmonialsbloc/testimonial_event.dart';
import 'package:ad_e_commerce/features/home/bloc/testmonialsbloc/testimonial_state.dart';
import 'package:ad_e_commerce/features/home/data/category_data.dart';
import 'package:ad_e_commerce/features/home/pages/category_filtred_page.dart';
import 'package:ad_e_commerce/features/home/widgets/BestSellerSection/best_seller_section.dart';
import 'package:ad_e_commerce/features/home/widgets/category_card.dart';
import 'package:ad_e_commerce/features/home/widgets/CategoryListSection/category_list_section.dart';
import 'package:ad_e_commerce/features/home/widgets/FlashSaleSection/flash_sale_section.dart';
import 'package:ad_e_commerce/features/home/widgets/category_grid.dart';
import 'package:ad_e_commerce/features/home/bloc/banners/banner_bloc.dart';
import 'package:ad_e_commerce/features/home/bloc/banners/banner_event.dart';
import 'package:ad_e_commerce/features/home/bloc/banners/banner_state.dart';
import 'package:ad_e_commerce/features/product/bloc/productimagesilder/product_image_silder_bloc.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_bloc.dart';
import 'package:ad_e_commerce/features/product/bloc/proudctbloc/product_event.dart';
import 'package:ad_e_commerce/features/home/data/datasource/airdropbenfites_remote_datasoureimpl.dart';
import 'package:ad_e_commerce/features/home/data/datasource/banner_remote_datasoureimpl.dart';
import 'package:ad_e_commerce/features/product/data/datasources/product_remote_datasourcimpl.dart';
import 'package:ad_e_commerce/features/home/data/datasource/testimonial_remote_datasoureimpl.dart';
import 'package:ad_e_commerce/features/home/data/repository/airdropbenfits_repository_impl.dart';
import 'package:ad_e_commerce/features/home/data/repository/banner_repository_impl.dart';
import 'package:ad_e_commerce/features/product/data/repositories/product_repository_impl.dart';
import 'package:ad_e_commerce/features/home/data/repository/testmonial_repositoryimpl.dart';
import 'package:ad_e_commerce/features/product/domain/usecases/get_flashsale_product_usecase.dart';
import 'package:ad_e_commerce/features/product/domain/usecases/get_product_usecase.dart';
import 'package:ad_e_commerce/features/product/widgets/product_image_carousel.dart';
import 'package:ad_e_commerce/features/profile/data/datasource/wallet_remote_datasource_impl.dart';
import 'package:ad_e_commerce/features/profile/data/repositories/wallet_repo_impl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SupabaseClient supabase = Supabase.instance.client;

    final bannerRepository = BannerRepositoryImpl(
      remoteDataSource: BannerRemoteDataSourceImpl(client: supabase),
    );

    final getproductUsecase = GetProductUsecase(
      ProductRepositoryImpl(ProductRemoteDatasourceImpl(supabase)),
    );
    final testimonialRepository = TestmonialRepositoryimpl(
      remote: TestimonialRemoteDatasoureimpl(supabase: supabase),
    );
    final airdropbenfitsRepository = AirdropbenfitsRepositoryImpl(
      remoteDataSource: AirdropbenfitesRemoteDatasoureimpl(client: supabase),
    );
    final cartRepository = CartRepositoryImpl(
      CartRemoteDatasourceimpl(supabase),
    );
    final addtoCartUsecase = AddToCartUsecase(cartRepository);
    final walletrepo = WalletRepoImpl(WalletRemoteDatasourceImpl(supabase));
    List<String> images = [];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  BannerBloc(bannerRepository, airdropbenfitsRepository)
                    ..add(LoadBannerEvent())
                    ..add(LoadAirdropBannerEvent()),
        ),
        BlocProvider(
          create:
              (context) =>
                  ProductBloc(
                      getproductUsecase,
                      GetFlashsaleProductUsecase(
                        ProductRepositoryImpl(
                          ProductRemoteDatasourceImpl(supabase),
                        ),
                      ),
                    )
                    ..add(LoadProductsEvent())
                    ..add(LoadFlashSaleProductsEvent()),
        ),
        BlocProvider(
          create:
              (context) => ProductImageSilderBloc(imagecount: images.length),
        ),
        BlocProvider(
          create:
              (context) =>
                  TestimonialBloc(testimonialRepository)
                    ..add(LoadTestimonialEvent()),
        ),
        BlocProvider(
          create:
              (context) =>
                  CartBloc(addtoCartUsecase, cartRepository, walletrepo),
        ),
      ],
      child: HomePageUi(supabase: supabase),
    );
  }
}

class HomePageUi extends StatelessWidget {
  final SupabaseClient supabase;
  const HomePageUi({super.key, required this.supabase});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      // 🔹 RESPONSIVE: Center layout and constrain width for large screens (Web/Tablet)
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 1200,
          ), // Increased for better desktop use
          child: CustomScrollView(
            slivers: [
              // 🔹 APP BAR
              AppSliverAppBar(),
              CupertinoSliverRefreshControl(
                builder: (
                  context,
                  refreshState,
                  pulledExtent,
                  refreshTriggerPullDistance,
                  refreshIndicatorExtent,
                ) {
                  return Center(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.primaryBlue, // 🔵 brand color
                      ),
                    ),
                  );
                },
                onRefresh: () async {
                  context.read<BannerBloc>().add(LoadBannerEvent());
                  context.read<ProductBloc>().add(LoadFlashSaleProductsEvent());
                  await Future.delayed(const Duration(milliseconds: 600));
                },
              ),

              // 🔹 BODY CONTENT
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24), // Standardized spacing
                    // Search
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Appnavigotor.pushnamed(
                              context,
                              RouteNames.search,
                              {},
                            );
                          },
                          child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 500,
                            ), // Responsive max width
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(width: 16),
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
                                const SizedBox(width: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Banner
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BlocBuilder<BannerBloc, BannerState>(
                          builder: (context, state) {
                            if (state.status == BannerStatus.loading) {
                              return AppShimmer.banner();
                            }
                            if (state.status == BannerStatus.success) {
                              return ProductImageCarousel(
                                isNeedBanner: true,
                                images:
                                    state.images
                                        .expand(
                                          (e) => e.imageUrl,
                                        ) // BannerEntity → images
                                        .toList(),
                              );
                            }
                            return const SizedBox(height: 180);
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Categories row 1
                    CategoryGrid(
                      categories: CategoryData.categories,
                      layout: CategoryCardLayout.vertical,
                    ),

                    // Categories row 2 - Removed as per original, keeping spacing consistent
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
                              Appnavigotor.pushnamed(
                                context,
                                RouteNames.categoryfiltredpage,
                                {
                                  "condition": PhoneCondition.empty,
                                  "SubCategory": SubCategory.empty,
                                  "isSubCategory": false,
                                  "isFlashSale": true,
                                },
                              );
                            },
                            child: AppTexts.medium(
                              "View All",
                              fontSize: 14, // Increased for better tap area
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Flash sale section
                    FlashSaleSection(),

                    const SizedBox(height: 24),

                    // Best Sellers Grids
                    BestSellersSection(),

                    const SizedBox(height: 24),

                    // Best Selling Lists
                    CategoryListSection(),

                    const SizedBox(height: 24),

                    // AirDrop Assurance
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTexts.medium("AIRDROP Assurance", fontSize: 18),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.asset(
                                  AssetConstants.aIRDROPAssuranceimg1,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Image.asset(
                                  AssetConstants.aIRDROPAssuranceimg2,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.asset(
                                  AssetConstants.aIRDROPAssuranceimg3,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(width: 16),
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

                    const SizedBox(height: 24),

                    // Benefits
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTexts.medium("AIRDROP Benefits", fontSize: 18),
                          const SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BlocBuilder<BannerBloc, BannerState>(
                              builder: (context, state) {
                                if (state.status == BannerStatus.loading) {
                                  return AppShimmer.banner();
                                }
                                if (state.status == BannerStatus.success) {
                                  return ProductImageCarousel(
                                    isNeedBanner: true,
                                    images:
                                        state.airdropbenfites
                                            .expand(
                                              (e) => e.imageUrl,
                                            ) // BannerEntity → images
                                            .toList(),
                                  );
                                }
                                return const SizedBox(height: 180);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Happy Customers
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTexts.medium("Our Happy Customers", fontSize: 18),
                          const SizedBox(height: 16),
                          BlocBuilder<TestimonialBloc, TestimonialState>(
                            builder: (context, state) {
                              return SizedBox(
                                height:
                                    280, // Slightly increased to prevent cut-off
                                width: double.infinity,
                                child:
                                    state.status == TestimonialStatus.loading
                                        ? ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 3,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: const EdgeInsets.only(
                                                right: 16,
                                              ),
                                              child: AppShimmer.rect(
                                                width: 280,
                                                height: 280,
                                                radius: 18,
                                              ),
                                            );
                                          },
                                        )
                                        : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state.testmonial.length,
                                          itemBuilder: (context, index) {
                                            final data =
                                                state.testmonial[index];
                                            return Container(
                                              width: 280,
                                              margin: const EdgeInsets.only(
                                                right: 16,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // CARD
                                                  Container(
                                                    width: 280,
                                                    height: 190,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.brightBlue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            18,
                                                          ),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                          20,
                                                        ),
                                                    child: Center(
                                                      child: Text(
                                                        data.content,
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 5,
                                                        style: const TextStyle(
                                                          fontFamily: 'Manrope',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w500, // Slightly lighter for readability
                                                          color:
                                                              AppColors
                                                                  .pureWhite,
                                                          height:
                                                              1.4, // Improved line height
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  const SizedBox(height: 12),

                                                  Center(
                                                    child: AppTexts.medium(
                                                      "Customer",
                                                      color:
                                                          AppColors.grayColor,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Center(
                                                    child: AppTexts.semiBold(
                                                      data.username,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    // Footer (Warranty & Why AirDrop)
                    const SizedBox(height: 24),
                    AspectRatio(
                      aspectRatio: 375 / 367, // use SVG design size
                      child: SvgPicture.asset(
                        AssetConstants.howtoClaimwarrntysvg,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 40), // Bottom padding
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
