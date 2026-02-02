import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/circular_arrow_button.dart';
import 'package:ad_e_commerce/features/profile/widgets/profile_menu_item.dart';
import 'package:flutter/material.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Center(
          child: CircularArrowButton(
            iconSize: 20,
            size: 40,
            needCircle: true,
            iconColor: AppColors.pureBlack,
            icon: Icons.arrow_back,
            backgroundColor: AppColors.lightGrey,
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: AppTexts.extraBold("Account", fontSize: 16),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          ProfileMenuItem(title: "Profile Settings", onTap: () {}),
          SizedBox(height: 10),
          ProfileMenuItem(title: "Forgotten password", onTap: () {}),
          SizedBox(height: 10),
          ProfileMenuItem(title: "My Address", onTap: () {}),
          SizedBox(height: 10),
          ProfileMenuItem(title: "Support & Legal", onTap: () {}),
        ],
      ),
    );
  }
}
