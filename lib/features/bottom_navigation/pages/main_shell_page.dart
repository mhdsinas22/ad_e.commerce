import 'package:aerstore/core/constants/app_icons.dart';
import 'package:aerstore/core/theme/app_colors.dart';
import 'package:aerstore/features/bottom_navigation/bloc/bottom_nav_bloc.dart';
import 'package:aerstore/features/bottom_navigation/bloc/bottom_nav_event.dart';
import 'package:aerstore/features/bottom_navigation/bloc/bottom_nav_state.dart';
import 'package:aerstore/features/cart/pages/cart_page.dart';
import 'package:aerstore/features/home/pages/home_page.dart';
import 'package:aerstore/features/orders/pages/orders_page.dart';
import 'package:aerstore/features/profile/pages/profile_page.dart';
import 'package:aerstore/features/repair/pages/repair_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainShellPage extends StatelessWidget {
  final int index;
  const MainShellPage({super.key, this.index = 0});

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
              context.read<BottomNavBloc>().add(BottomNavChanged(index: index));
            },
            currentIndex: state.selectedIndex,
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
                    SvgPicture.asset(
                      AppIcons.categoriesIcon,
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
                  AppIcons.categoriesIcon,
                  color: AppColors.grayColor,
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
          body: IndexedStack(
            index: state.selectedIndex,
            children: [
              HomePage(),
              CartPage(),
              OrdersPage(),
              RepairPage(),
              ProfilePage(),
            ],
          ),
        );
      },
    );
  }
}
