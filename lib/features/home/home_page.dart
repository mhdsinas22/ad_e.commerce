import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_sliver_app_bar.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/home/bloc/testmonialsbloc/testimonial_bloc.dart';
import 'package:ad_e_commerce/features/home/bloc/testmonialsbloc/testimonial_event.dart';
import 'package:ad_e_commerce/features/home/bloc/testmonialsbloc/testimonial_state.dart';
import 'package:ad_e_commerce/features/home/data/category_data.dart';
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
              (context) => ProductBloc(
                getproductUsecase,
                GetFlashsaleProductUsecase(
                  ProductRepositoryImpl(ProductRemoteDatasourceImpl(supabase)),
                ),
              )..add(LoadFlashSaleProductsEvent()),
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
      ],
      child: HomePageUi(),
    );
  }
}

class HomePageUi extends StatelessWidget {
  const HomePageUi({super.key});

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
                    const SizedBox(height: 10),

                    // Search
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                        child: BlocBuilder<BannerBloc, BannerState>(
                          builder: (context, state) {
                            if (state.status == BannerStatus.loading) {
                              return const SizedBox(
                                height: 180,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
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
                    // const SizedBox(height: 20),

                    // Categories row 1
                    CategoryGrid(
                      categories: CategoryData.categories,
                      layout: CategoryCardLayout.vertical,
                    ),
                    const SizedBox(height: 16),

                    // Categories row 2
                    // 🔹 RESPONSIVE: Prevent overflow on small screens & huge gaps on large screens
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BlocBuilder<BannerBloc, BannerState>(
                              builder: (context, state) {
                                if (state.status == BannerStatus.loading) {
                                  return const SizedBox(
                                    height: 180,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
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

                    const SizedBox(height: 20),

                    // Happy Customers
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTexts.medium("Our Happy Customers", fontSize: 18),
                          const SizedBox(height: 10),
                          BlocBuilder<TestimonialBloc, TestimonialState>(
                            builder: (context, state) {
                              return SizedBox(
                                height: 270, // 🔥 enough for card + name
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      state
                                          .testmonial
                                          .length, // testimonials.length
                                  itemBuilder: (context, index) {
                                    final data = state.testmonial[index];
                                    return Container(
                                      width: 260, // 🔥 card width
                                      margin: const EdgeInsets.only(right: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // CARD
                                          Container(
                                            width: 167,
                                            height: 180,
                                            decoration: BoxDecoration(
                                              color: AppColors.brightBlue,
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            padding: const EdgeInsets.all(16),
                                            child: Center(
                                              child: Text(
                                                data.content,
                                                textAlign: TextAlign.center,
                                                maxLines: 5,
                                                style: const TextStyle(
                                                  fontFamily: 'Manrope',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.pureWhite,
                                                  height: 1.2,
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 10),

                                          AppTexts.medium(
                                            "Customer",
                                            color: AppColors.grayColor,
                                            fontSize: 12,
                                          ),
                                          const SizedBox(height: 4),
                                          AppTexts.semiBold(
                                            data.username,
                                            fontSize: 12,
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
