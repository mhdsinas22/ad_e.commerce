import 'package:aerstore/core/constants/app_icons.dart';
import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/features/bottom_navigation/bloc/bottom_nav_bloc.dart';
import 'package:aerstore/features/bottom_navigation/bloc/bottom_nav_state.dart';
import 'package:aerstore/features/orders/bloc/order_bloc.dart';
import 'package:aerstore/features/orders/bloc/order_event.dart';
import 'package:aerstore/features/cart/bloc/cart_bloc.dart';
import 'package:aerstore/features/cart/bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainShellPage extends StatelessWidget {
  final StatefulNavigationShell shell;
  const MainShellPage({super.key, required this.shell});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColors.primaryBlack,
            selectedLabelStyle: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            showUnselectedLabels: false,
            showSelectedLabels: true,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.pureWhite,
            onTap: (index) {
              shell.goBranch(index);
              if (index == 2) {
                final user = Supabase.instance.client.auth.currentUser;
                if (user != null) {
                  context.read<OrderBloc>().add(
                    LoadOrdersEvent(userid: user.id),
                  );
                }
              }
            },
            currentIndex: shell.currentIndex,
            items: [
              BottomNavigationBarItem(
                activeIcon: Column(
                  children: [
                    SvgPicture.asset(
                      AppIcons.shopIcon,
                      color: AppColors.primaryBlack,
                    ),
                    // SizedBox(height: 5),
                    // AnimatedContainer(
                    //   duration: const Duration(milliseconds: 200),
                    //   curve: Curves.easeInOut,
                    //   width: 18,
                    //   height: 3,
                    //   decoration: BoxDecoration(
                    //     color: AppColors.grayColor,
                    //     borderRadius: BorderRadius.circular(2),
                    //   ),
                    // ),
                  ],
                ),
                icon: SvgPicture.asset(
                  AppIcons.shopIcon,
                  color: AppColors.grayColor,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                activeIcon: Column(
                  children: [
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        return Badge(
                          label: Text('${state.cartitems.length}'),
                          isLabelVisible: state.cartitems.isNotEmpty,
                          backgroundColor: AppColors.primaryBlack,
                          child: SvgPicture.asset(
                            AppIcons.categoriesIcon,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primaryBlack,
                              BlendMode.srcIn,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                icon: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return Badge(
                      label: Text('${state.cartitems.length}'),
                      isLabelVisible: state.cartitems.isNotEmpty,
                      backgroundColor: AppColors.primaryBlack,
                      child: SvgPicture.asset(
                        AppIcons.categoriesIcon,
                        colorFilter: const ColorFilter.mode(
                          AppColors.grayColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    );
                  },
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                activeIcon: Column(
                  children: [
                    SvgPicture.asset(
                      AppIcons.cartIcon,
                      // ignore: deprecated_member_use
                      color: AppColors.primaryBlack,
                    ),
                    // SizedBox(height: 5),
                    // AnimatedContainer(
                    //   duration: const Duration(milliseconds: 200),
                    //   curve: Curves.easeInOut,
                    //   width: 18,
                    //   height: 3,
                    //   decoration: BoxDecoration(
                    //     color: AppColors.grayColor,
                    //     borderRadius: BorderRadius.circular(2),
                    //   ),
                    // ),
                  ],
                ),
                icon: SvgPicture.asset(
                  AppIcons.cartIcon,
                  color: AppColors.grayColor,
                ),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                activeIcon: Column(
                  children: [
                    SvgPicture.asset(
                      AppIcons.supportIcon,
                      color: AppColors.primaryBlack,
                    ),
                    // SizedBox(height: 5),
                    // AnimatedContainer(
                    //   duration: const Duration(milliseconds: 200),
                    //   curve: Curves.easeInOut,
                    //   width: 18,
                    //   height: 3,
                    //   decoration: BoxDecoration(
                    //     color: AppColors.grayColor,
                    //     borderRadius: BorderRadius.circular(2),
                    //   ),
                    // ),
                  ],
                ),
                icon: SvgPicture.asset(
                  AppIcons.supportIcon,
                  color: AppColors.grayColor,
                ),
                label: 'Service',
              ),
              BottomNavigationBarItem(
                activeIcon: Column(
                  children: [
                    SvgPicture.asset(
                      AppIcons.profileIcon,
                      // ignore: deprecated_member_use
                      color: AppColors.primaryBlack,
                    ),
                    SizedBox(height: 5),
                    // AnimatedContainer(
                    //   duration: const Duration(milliseconds: 200),
                    //   curve: Curves.easeInOut,
                    //   width: 18,
                    //   height: 3,
                    //   decoration: BoxDecoration(
                    //     color: AppColors.grayColor,
                    //     borderRadius: BorderRadius.circular(2),
                    //   ),
                    // ),
                  ],
                ),
                icon: SvgPicture.asset(
                  AppIcons.profileIcon,
                  color: AppColors.grayColor,
                ),
                label: 'Profile',
              ),
            ],
          ),
          body: shell,
        );
      },
    );
  }
}
