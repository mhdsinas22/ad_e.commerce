import 'package:ad_e_commerce/core/constants/app_icons.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/features/bottom_navigation/bloc/bottom_nav_bloc.dart';
import 'package:ad_e_commerce/features/bottom_navigation/bloc/bottom_nav_event.dart';
import 'package:ad_e_commerce/features/bottom_navigation/bloc/bottom_nav_state.dart';
import 'package:ad_e_commerce/features/cart/cart_page.dart';
import 'package:ad_e_commerce/features/home/home_page.dart';
import 'package:ad_e_commerce/features/orders/orders_page.dart';
import 'package:ad_e_commerce/features/profile/profile_page.dart';
import 'package:ad_e_commerce/features/repair/repair_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainShellPage extends StatelessWidget {
  const MainShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBloc(),
      child: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: false,
              showSelectedLabels: false,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.pureWhite,
              onTap: (index) {
                context.read<BottomNavBloc>().add(
                  BottomNavChanged(index: index),
                );
              },
              currentIndex: state.selectedIndex,
              items: [
                BottomNavigationBarItem(
                  activeIcon: Column(
                    children: [
                      SvgPicture.asset(AppIcons.shopIcon),
                      SizedBox(height: 5),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        width: 18,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                  icon: SvgPicture.asset(
                    AppIcons.shopIcon,
                    // ignore: deprecated_member_use
                    color: AppColors.primaryBlue,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  activeIcon: Column(
                    children: [
                      SvgPicture.asset(
                        AppIcons.categoriesIcon,
                        // ignore: deprecated_member_use
                        color: AppColors.pureBlack,
                      ),
                      SizedBox(height: 5),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        width: 18,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                  icon: SvgPicture.asset(AppIcons.categoriesIcon),
                  label: 'Orders',
                ),
                BottomNavigationBarItem(
                  activeIcon: Column(
                    children: [
                      SvgPicture.asset(
                        AppIcons.cartIcon,
                        // ignore: deprecated_member_use
                        color: AppColors.pureBlack,
                      ),
                      SizedBox(height: 5),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        width: 18,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                  icon: SvgPicture.asset(AppIcons.cartIcon),
                  label: 'Repair',
                ),
                BottomNavigationBarItem(
                  activeIcon: Column(
                    children: [
                      SvgPicture.asset(
                        AppIcons.supportIcon,
                        // ignore: deprecated_member_use
                        color: AppColors.pureBlack,
                      ),
                      SizedBox(height: 5),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        width: 18,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                  icon: SvgPicture.asset(AppIcons.supportIcon),
                  label: 'Service',
                ),
                BottomNavigationBarItem(
                  activeIcon: Column(
                    children: [
                      SvgPicture.asset(
                        AppIcons.profileIcon,
                        // ignore: deprecated_member_use
                        color: AppColors.pureBlack,
                      ),
                      SizedBox(height: 5),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        width: 18,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                  icon: SvgPicture.asset(AppIcons.profileIcon),
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
      ),
    );
  }
}
