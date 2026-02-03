import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';

import 'package:ad_e_commerce/features/profile/widgets/profile_menu_item.dart';
import 'package:ad_e_commerce/features/profile/widgets/profle_side_appbar.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupportLegelPage extends StatelessWidget {
  const SupportLegelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileSideAppbar(title: "Support & Legal"),
      body: Column(
        children: [
          SizedBox(height: 20),

          ProfileMenuItem(title: "Help & Support", onTap: () {}),
          SizedBox(height: 10),
          ProfileMenuItem(
            title: "Terms & Conditions / Privacy Policy",
            onTap: () {},
          ),
          SizedBox(height: 10),
          ProfileMenuItem(
            isneedChangedbuttoncolor: true,
            buttoncolor: AppColors.purered,
            title: "Log Out",
            onTap: () {
              showModalBottomSheet(
                backgroundColor: AppColors.pureWhite,
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(AssetConstants.logoutpngtemp),
                        ),
                        SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.pureWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    Appnavigotor.pop(context);
                                  },
                                  child: AppTexts.semiBold("Cancel"),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.purered,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () async {
                                    final supbase = Supabase.instance.client;
                                    await supbase.auth.signOut();
                                    Appnavigotor.pushNamedAndRemoveUntil(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      RouteNames.login,
                                    );
                                  },
                                  child: AppTexts.semiBold(
                                    "LogOut",
                                    color: AppColors.pureWhite,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
