import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/features/product/bloc/productimagesilder/product_image_silder_bloc.dart';
import 'package:ad_e_commerce/features/product/bloc/productimagesilder/product_image_silder_state.dart';
import 'package:ad_e_commerce/features/product/bloc/productimagesilder/product_image_slider_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductImageCarousel extends StatelessWidget {
  final List<String> images;
  const ProductImageCarousel({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductImageSilderBloc(imagecount: images.length),
      child: ProductImageCarouselUi(images: images),
    );
  }
}

class ProductImageCarouselUi extends StatefulWidget {
  final List<String> images;
  const ProductImageCarouselUi({super.key, required this.images});

  @override
  State<ProductImageCarouselUi> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarouselUi> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    context.read<ProductImageSilderBloc>().add(StartAutoSlide());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductImageSilderBloc, ProductImageSilderState>(
      listener: (context, state) {
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            state.currentIndex,
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 420,
              width: double.infinity,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.images.length,
                onPageChanged: (index) {
                  context.read<ProductImageSilderBloc>().add(
                    SliderChangedEvent(index: index),
                  );
                },
                itemBuilder: (context, index) {
                  return Image.network(widget.images[index], fit: BoxFit.cover);
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<ProductImageSilderBloc, ProductImageSilderState>(
            builder: (context, state) {
              final count = context.read<ProductImageSilderBloc>().imagecount;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  count,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 12,
                    width: state.currentIndex == index ? 10 : 5,
                    decoration: BoxDecoration(
                      color:
                          state.currentIndex == index
                              ? AppColors.primaryBlue
                              : AppColors.grayColor,

                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          BlocBuilder<ProductImageSilderBloc, ProductImageSilderState>(
            builder: (context, state) {
              final count = context.read<ProductImageSilderBloc>().imagecount;
              return Row(
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
                                ? AppColors.primaryBlue
                                : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(7),
                      // color:
                      //     state.currentIndex == index
                      //         ? AppColors.primaryBlue
                      //         : AppColors.grayColor,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        context.read<ProductImageSilderBloc>().add(
                          SliderChangedEvent(index: index),
                        );
                      },
                      child: Image.network(
                        widget.images[index],
                        fit: BoxFit.cover,
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
