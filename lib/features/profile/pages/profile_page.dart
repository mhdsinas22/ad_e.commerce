import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';

import 'package:ad_e_commerce/features/profile/widgets/profile_menu_item.dart';

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: AppTexts.bold("Profile", fontSize: 50),
              ),
            ),
            SizedBox(height: 20),
            ProfileMenuItem(
              title: "My Orders",
              onTap: () {
                Appnavigotor.pushnamed(context, RouteNames.orderspage, {
                  "isPushOnly": true,
                });
              },
            ),
            SizedBox(height: 10),
            ProfileMenuItem(title: "My Wallet", onTap: () {}),
            SizedBox(height: 10),
            ProfileMenuItem(
              title: "My Warranty",
              onTap: () {
                Appnavigotor.pushnamed(context, RouteNames.warranty, []);
              },
            ),
            SizedBox(height: 10),
            ProfileMenuItem(
              title: "My Account",
              onTap: () {
                Appnavigotor.pushnamed(context, RouteNames.myaccountpage, []);
              },
            ),
          ],
        ),
      ),
    );
  }
}
