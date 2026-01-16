import 'package:ad_e_commerce/core/constants/app_icons.dart';
import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/circular_arrow_button.dart';
import 'package:ad_e_commerce/features/product/domain/entites/product.dart';
import 'package:ad_e_commerce/features/product/widgets/product_image_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ProductImageCarousel(images: product.imageUrls),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircularArrowButton(
                          iconSize: 25,
                          size: 50,
                          needCircle: true,
                          iconColor: AppColors.pureBlack,
                          icon: Icons.arrow_back,
                          backgroundColor: AppColors.lightGrey,
                          onTap: () => Navigator.pop(context),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap:
                              () => Appnavigotor.pushnamed(
                                context,
                                RouteNames.search,
                                {},
                              ),
                          child: SvgPicture.asset(AppIcons.serachucon),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap:
                              () => Appnavigotor.pushnamed(
                                context,
                                RouteNames.cart,
                                {},
                              ),
                          child: SvgPicture.asset(AssetConstants.carticonpng),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
