import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/utils/helpers.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/profile/widgets/profile_menu_item.dart';
import 'package:ad_e_commerce/features/profile/widgets/store_card.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      final supabaseClient = Supabase.instance.client;
                      final user = supabaseClient.auth.currentUser;
                      user == null
                          ? Helpers.showAuthBottomSheet(
                            context,
                            redirectRoute: RouteNames.mainShell,
                            redirectArgs: {"index": 0},
                          )
                          : Appnavigotor.pushnamed(
                            context,
                            RouteNames.orderspage,
                            {"isPushOnly": true},
                          );
                    },
                  ),
                  SizedBox(height: 10),
                  ProfileMenuItem(
                    title: "My Wallet",
                    onTap: () {
                      final supabaseClient = Supabase.instance.client;
                      final user = supabaseClient.auth.currentUser;
                      user == null
                          ? Helpers.showAuthBottomSheet(
                            context,
                            redirectRoute: RouteNames.mainShell,
                            redirectArgs: {"index": 0},
                          )
                          : Appnavigotor.pushnamed(
                            context,
                            RouteNames.wallet,
                            [],
                          );
                    },
                  ),
                  SizedBox(height: 10),
                  ProfileMenuItem(
                    title: "My Warranty",
                    onTap: () {
                      final supabaseClient = Supabase.instance.client;
                      final user = supabaseClient.auth.currentUser;
                      user == null
                          ? Helpers.showAuthBottomSheet(
                            context,
                            redirectRoute: RouteNames.mainShell,
                            redirectArgs: {"index": 0},
                          )
                          : Appnavigotor.pushnamed(
                            context,
                            RouteNames.warranty,
                            [],
                          );
                    },
                  ),
                  SizedBox(height: 10),
                  ProfileMenuItem(
                    title: "My Account",
                    onTap: () {
                      final supabaseClient = Supabase.instance.client;
                      final user = supabaseClient.auth.currentUser;
                      user == null
                          ? Helpers.showAuthBottomSheet(
                            context,
                            redirectRoute: RouteNames.mainShell,
                            redirectArgs: {"index": 0},
                          )
                          : Appnavigotor.pushnamed(
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      height: 330,
                      child: Row(
                        children: [
                          StoreCard(
                            image: AssetConstants.malappuramstorephonto,
                            title: "Malappuram Airdrop Store",
                            phone: "+919048551457",
                            onLocationTap: () {
                              Helpers.openStoreLocation(
                                "https://www.google.com/maps/dir//AIRDROP+APPLE+STORE+MALAPPURAM,+Kottappady,+Malappuram,+Kerala+676519/@11.051098,76.0739995,15z/data=!4m8!4m7!1m0!1m5!1m1!1s0x3ba64b005b6bd737:0x25505417b6c7b639!2m2!1d76.0749375!2d11.0466875?entry=ttu&g_ep=EgoyMDI2MDIxMS4wIKXMDSoASAFQAw%3D%3D",
                              );
                            },
                            onWhatsappTap: () {
                              Helpers.openWhatsapp("+919048551457");
                            },
                            onCallTap: () {
                              Helpers.makePhoneCall("+919048551457");
                            },
                          ),

                          const SizedBox(width: 20), // 🔥 horizontal spacing

                          StoreCard(
                            image: AssetConstants.kozhikodestorephonto,
                            title: "Kozhikode Airdrop Store",
                            phone: "+917034266250",
                            onLocationTap: () {
                              Helpers.openStoreLocation(
                                "https://www.google.com/maps/dir/11.040885,76.068161/HiLITE+Business+Park,+State+Highway+28,+Palazhi,+Kozhikode,+Pantheeramkavu,+Kerala+673014/@11.1364003,75.7935015,11z/data=!3m1!4b1!4m9!4m8!1m1!4e1!1m5!1m1!1s0x3ba6597c304c1f3b:0xbb7abc23c1ea8a!2m2!1d75.8339138!2d11.2478476?entry=ttu&g_ep=EgoyMDI2MDIxNi4wIKXMDSoASAFQAw%3D%3D",
                              );
                            },
                            onWhatsappTap: () {
                              Helpers.openWhatsapp("+917034266250");
                            },
                            onCallTap: () {
                              Helpers.makePhoneCall("+917034266250");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
