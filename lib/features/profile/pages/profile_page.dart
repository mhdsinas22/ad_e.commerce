import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/helpers.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/core/widgets/primary_button.dart';

import 'package:ad_e_commerce/features/profile/widgets/profile_menu_item.dart';

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
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
                ProfileMenuItem(
                  title: "My Wallet",
                  onTap: () {
                    Appnavigotor.pushnamed(context, RouteNames.wallet, []);
                  },
                ),
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
                    Appnavigotor.pushnamed(
                      context,
                      RouteNames.myaccountpage,
                      [],
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: AppTexts.medium("Our Stores", fontSize: 22),
                  ),
                ),
                SizedBox(
                  width: 360,
                  child: Card(
                    color: AppColors.pureWhite,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 🔹 IMAGE
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              AssetConstants.malappuramstorephonto,
                              height: 190,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(height: 12),

                          /// 🔹 TITLE
                          AppTexts.medium(
                            "Malappuram Airdrop Store",
                            fontSize: 16,
                          ),

                          const SizedBox(height: 16),

                          /// 🔹 BUTTON ROW
                          Row(
                            children: [
                              Expanded(
                                child: PrimaryButton(
                                  fontsize: 13,
                                  text: "Call",
                                  height: 40,
                                  onPressed: () {
                                    Helpers.makePhoneCall("+919048551457");
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: PrimaryButton(
                                  fontsize: 13,
                                  text: "Location",
                                  height: 40,
                                  onPressed: () {
                                    Helpers.openStoreLocation();
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: PrimaryButton(
                                  fontsize: 13,
                                  text: "Whatsapp",
                                  height: 40,
                                  onPressed: () {
                                    Helpers.openWhatsapp("+919048551457");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
