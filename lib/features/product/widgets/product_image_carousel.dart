import 'package:go_router/go_router.dart';
import 'package:aerstore/core/routes/route_names.dart';
import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/core/widgets/app_cached_image.dart';
import 'package:aerstore/features/product/bloc/productimagesilder/product_image_silder_bloc.dart';
import 'package:aerstore/features/product/bloc/productimagesilder/product_image_silder_state.dart';
import 'package:aerstore/features/product/bloc/productimagesilder/product_image_slider_event.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ProductImageCarousel extends StatelessWidget {
  final bool isNeedBanner;
  final List<String> images;
  const ProductImageCarousel({
    super.key,
    required this.images,
    this.isNeedBanner = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductImageSilderBloc(imagecount: images.length),
      child: ProductImageCarouselUi(images: images, isNeedBanner: isNeedBanner),
    );
  }
}

class ProductImageCarouselUi extends StatefulWidget {
  final List<String> images;
  final bool isNeedBanner;
  const ProductImageCarouselUi({
    super.key,
    required this.images,
    this.isNeedBanner = false,
  });

  @override
  State<ProductImageCarouselUi> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarouselUi> {
  late PageController _pageController;
  late ScrollController _thumbnailScrollController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _thumbnailScrollController = ScrollController();
    context.read<ProductImageSilderBloc>().add(StartAutoSlide());
  }

  @override
  void dispose() {
    _pageController.dispose();
    _thumbnailScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double getResponsiveAspectRatio() {
      if (widget.isNeedBanner) {
        if (width >= 1024) {
          return 16 / 4.0; // Modern desktop banner (Amazon/Flipkart style)
        }
        if (width >= 600) return 16 / 6.0; // Tablet banner
        return 16 / 9.0; // Mobile banner untouched (perfect working)
      } else {
        // Keep existing behavior for Product details images intact
        return 1; // simple square
      }
    }

    return BlocListener<ProductImageSilderBloc, ProductImageSilderState>(
      listener: (context, state) {
        if (_pageController.hasClients) {
          final currentpage = _pageController.page?.round();
          if (currentpage != state.currentIndex) {
            _pageController.animateToPage(
              state.currentIndex,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        }
        if (_thumbnailScrollController.hasClients) {
          final double itemWidth =
              88.0; // width (80) + horizontal margins (4+4)
          final double screenWidth = MediaQuery.of(context).size.width;
          final double targetOffset =
              (state.currentIndex * itemWidth) +
              (itemWidth / 2) -
              (screenWidth / 2);

          _thumbnailScrollController.animateTo(
            targetOffset.clamp(
              0.0,
              _thumbnailScrollController.position.maxScrollExtent,
            ),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      },
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              widget.isNeedBanner
                  ? null
                  : context.pushNamed(
                    RouteNames.imageZoom,
                    extra: {"image": widget.images},
                  );
            },
            child: SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: AspectRatio(
                  aspectRatio: getResponsiveAspectRatio(),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.images.length,
                    onPageChanged: (index) {
                      context.read<ProductImageSilderBloc>().add(
                        SliderChangedEvent(index: index),
                      );
                    },
                    itemBuilder: (context, index) {
                      return AppCachedImage(
                        imageUrl: widget.images[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          // const SizedBox(height: 16),
          // BlocBuilder<ProductImageSilderBloc, ProductImageSilderState>(
          //   builder: (context, state) {
          //     final count = context.read<ProductImageSilderBloc>().imagecount;
          //     return Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: List.generate(
          //         count,
          //         (index) => AnimatedContainer(
          //           duration: const Duration(milliseconds: 300),
          //           margin: const EdgeInsets.symmetric(horizontal: 4),
          //           height: 12,
          //           width: state.currentIndex == index ? 10 : 5,
          //           decoration: BoxDecoration(
          //             color:
          //                 state.currentIndex == index
          //                     ? AppColors.primaryBlack
          //                     : AppColors.grayColor,

          //             shape: BoxShape.circle,
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
          // const SizedBox(height: 10),
          widget.isNeedBanner
              ? SizedBox()
              : BlocBuilder<ProductImageSilderBloc, ProductImageSilderState>(
                builder: (context, state) {
                  final count =
                      context.read<ProductImageSilderBloc>().imagecount;
                  return SingleChildScrollView(
                    controller: _thumbnailScrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        count,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  state.currentIndex == index
                                      ? AppColors.primaryBlack
                                      : Colors.transparent,
                            ),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              context.read<ProductImageSilderBloc>().add(
                                SliderChangedEvent(index: index),
                              );
                            },
                            child: CachedNetworkImage(
                              imageUrl: widget.images[index],
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(color: Colors.white),
                                  ),
                              errorWidget:
                                  (context, url, error) =>
                                      Icon(Icons.broken_image),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
        ],
      ),
    );
  }
}
