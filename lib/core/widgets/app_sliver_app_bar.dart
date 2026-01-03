import 'package:ad_e_commerce/core/constants/app_icons.dart';
import 'package:ad_e_commerce/core/widgets/circular_arrow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/asset_constants.dart';
import '../routes/route_names.dart';
import '../theme/app_colors.dart';

class AppSliverAppBar extends StatelessWidget {
  final bool showCart;
  final VoidCallback? onCartTap;
  final double expandedHeight;
  final bool showBack;

  const AppSliverAppBar({
    super.key,
    this.showCart = true,
    this.onCartTap,
    this.expandedHeight = 60,
    this.showBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading:
          showBack
              ? CircularArrowButton(
                needCircle: true,
                iconColor: AppColors.pureBlack,
                icon: Icons.arrow_back,
                backgroundColor: AppColors.lightGrey,
                onTap: () => Navigator.pop(context),
              )
              : null,
      elevation: 0,
      pinned: true,
      centerTitle: true,
      expandedHeight: expandedHeight,
      backgroundColor: AppColors.pureWhite,
      surfaceTintColor: AppColors.pureWhite,

      title: Image.asset(
        AssetConstants.airdropLetterLogo,
        width: 120,
        height: 50,
        fit: BoxFit.contain,
      ),

      actions:
          showCart
              ? [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(AppIcons.serachucon),
                ),
                InkWell(
                  onTap:
                      onCartTap ??
                      () => Navigator.pushNamed(context, RouteNames.cart),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SvgPicture.asset(
                      AssetConstants.carticonpng,
                      height: 40,
                    ),
                  ),
                ),
              ]
              : null,
    );
  }
}
