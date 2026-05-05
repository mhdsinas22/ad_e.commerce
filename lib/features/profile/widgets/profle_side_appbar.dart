import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/circular_arrow_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileSideAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const ProfileSideAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          onTap: () => context.pop(),
        ),
      ),
      title: AppTexts.extraBold(title, fontSize: 16),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
