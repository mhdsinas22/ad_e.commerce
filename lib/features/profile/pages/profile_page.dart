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
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isDesktop = constraints.maxWidth > 1024;
                      if (isDesktop) {
                        // Desktop: show cards side by side in a centered Row
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: StoreCard(
                                  image: AssetConstants.malappuramstorephonto,
                                  title: "Malappuram Airdrop Store",
                                  phone: "+917510506060",
                                  onLocationTap: () {
                                    Helpers.openStoreLocation(
                                      "https://maps.app.goo.gl/R6YSRrtZd3qWMcse6?g_st=ic",
                                    );
                                  },
                                  onWhatsappTap: () {
                                    Helpers.openWhatsapp("+917510506060");
                                  },
                                  onCallTap: () {
                                    Helpers.makePhoneCall("+917510506060");
                                  },
                                ),
                              ),
                              const SizedBox(width: 20),
                              Flexible(
                                child: StoreCard(
                                  image: AssetConstants.kozhikodestorephonto,
                                  title: "Kozhikode AER Store",
                                  phone: "+917511166623",
                                  onLocationTap: () async {
                                    final place =
                                        await Supabase.instance.client
                                            .from("places")
                                            .select();
                                    final mapLink = place[0]['map_link'];
                                    Helpers.openStoreLocation(mapLink.toString());
                                  },
                                  onWhatsappTap: () {
                                    Helpers.openWhatsapp("+917511166623");
                                  },
                                  onCallTap: () {
                                    Helpers.makePhoneCall("+917511166623");
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      // Mobile/Tablet: horizontal scrollable list (unchanged)
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          height: 330,
                          child: Row(
                            children: [
                              StoreCard(
                                image: AssetConstants.malappuramstorephonto,
                                title: "Malappuram Airdrop Store",
                                phone: "+917510506060",
                                onLocationTap: () {
                                  Helpers.openStoreLocation(
                                    "https://maps.app.goo.gl/R6YSRrtZd3qWMcse6?g_st=ic",
                                  );
                                },
                                onWhatsappTap: () {
                                  Helpers.openWhatsapp("+917510506060");
                                },
                                onCallTap: () {
                                  Helpers.makePhoneCall("+917510506060");
                                },
                              ),
                              const SizedBox(width: 20),
                              StoreCard(
                                image: AssetConstants.kozhikodestorephonto,
                                title: "Kozhikode AER Store",
                                phone: "+917511166623",
                                onLocationTap: () async {
                                  final place =
                                      await Supabase.instance.client
                                          .from("places")
                                          .select();
                                  final mapLink = place[0]['map_link'];
                                  Helpers.openStoreLocation(mapLink.toString());
                                },
                                onWhatsappTap: () {
                                  Helpers.openWhatsapp("+917511166623");
                                },
                                onCallTap: () {
                                  Helpers.makePhoneCall("+917511166623");
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
