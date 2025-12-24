import 'package:ad_e_commerce/features/bottom_navigation/bloc/bottom_nav_bloc.dart';
import 'package:ad_e_commerce/features/bottom_navigation/bloc/bottom_nav_event.dart';
import 'package:ad_e_commerce/features/bottom_navigation/bloc/bottom_nav_state.dart';
import 'package:ad_e_commerce/features/cart/cart_page.dart';
import 'package:ad_e_commerce/features/home/home_page.dart';
import 'package:ad_e_commerce/features/orders/orders_page.dart';
import 'package:ad_e_commerce/features/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              onTap: (index) {
                context.read<BottomNavBloc>().add(
                  BottomNavChanged(index: index),
                );
              },
              currentIndex: state.selectedIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt),
                  label: 'Orders',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.build),
                  label: 'Repair',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
            body: IndexedStack(
              index: state.selectedIndex,
              children: [HomePage(), CartPage(), OrdersPage(), ProfilePage()],
            ),
          );
        },
      ),
    );
  }
}
