import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/circular_arrow_button.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

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
        title: AppTexts.extraBold("Profile", fontSize: 16),
      ),
    );
  }
}
