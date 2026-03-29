import 'package:ad_e_commerce/core/constants/app_icons.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/circular_arrow_button.dart';
import 'package:ad_e_commerce/features/search/widgets/search_bar.dart';
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
  final bool showSearchIcon;
  final bool removeLogo;
  final bool isDesktop;
  final bool isNeedSearchWidget;
  const AppSliverAppBar({
    super.key,
    this.showCart = true,
    this.onCartTap,
    this.expandedHeight = 60,
    this.showBack = false,
    this.showSearchIcon = false,
    this.removeLogo = false,
    this.isDesktop = false,
    this.isNeedSearchWidget = false,
  });

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = isDesktop ? 80 : 56;
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
      centerTitle: isDesktop ? false : false,
      toolbarHeight: appBarHeight,
      expandedHeight: appBarHeight + 10,
      backgroundColor: AppColors.pureWhite,
      surfaceTintColor: AppColors.pureWhite,

      title:
          isDesktop
              ? Stack(
                children: [
                  removeLogo
                      ? const SizedBox.shrink()
                      : Align(
                        alignment: AlignmentGeometry.centerLeft,
                        child: SvgPicture.asset(
                          AssetConstants.aerprimarylogo,
                          width: 120,
                          height: 40,
                          fit: BoxFit.contain,
                        ),
                      ),
                  const SizedBox(width: 20),
                  isNeedSearchWidget
                      ? SearchBarw()
                      : Padding(
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
                            child: Center(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                      ),
                ],
              )
              : removeLogo
              ? null
              : SvgPicture.asset(
                AssetConstants.aerprimarylogo,
                width: 120,
                height: 40,
                fit: BoxFit.contain,
              ),

      actions:
          showCart
              ? [
                if (showSearchIcon)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.search);
                      },
                      child: SvgPicture.asset(AppIcons.serachucon),
                    ),
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
