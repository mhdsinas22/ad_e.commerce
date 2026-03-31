import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/core/widgets/app_text.dart';
import 'package:ad_e_commerce/features/legal/data/policy_content.dart';
import 'package:ad_e_commerce/features/legal/widgets/policy_viewer_sheet.dart';

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
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              SizedBox(height: 20),

              ProfileMenuItem(
                title: "Privacy Policy",
                onTap:
                    () => showPolicySheet(context, PolicyContent.privacyPolicy),
              ),
              SizedBox(height: 10),
              ProfileMenuItem(
                title: "Terms of Service",
                onTap: () {
                  showPolicySheet(context, PolicyContent.termsOfService);
                },
              ),
              SizedBox(height: 10),
              ProfileMenuItem(
                title: "Refund & Return Policy",
                onTap: () {
                  showPolicySheet(context, PolicyContent.refundReturnPolicy);
                },
              ),
              SizedBox(height: 10),
              ProfileMenuItem(
                title: "Shipping Policy",
                onTap: () {
                  showPolicySheet(context, PolicyContent.shippingPolicy);
                },
              ),
              SizedBox(height: 10),
              ProfileMenuItem(
                title: "Warranty Policy",
                onTap: () {
                  showPolicySheet(context, PolicyContent.warrantyPolicy);
                },
              ),
              SizedBox(height: 10),
              ProfileMenuItem(
                title: "Contact information",
                onTap: () {
                  showPolicySheet(context, PolicyContent.contactInformation);
                },
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
                        height: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Center(
                              child: Image.asset(
                                AssetConstants.logoutpngtemp,
                                height: 80,
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                          255,
                                          221,
                                          219,
                                          219,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
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
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        final supbase =
                                            Supabase.instance.client;
                                        await supbase.auth.signOut();
                                        Appnavigotor.pushNamedAndRemoveUntil(
                                          // ignore: use_build_context_synchronously
                                          context,
                                          RouteNames.phoneLogin,
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
              SizedBox(height: 10),
              ProfileMenuItem(
                isneedChangedbuttoncolor: true,
                buttoncolor: AppColors.purered,
                title: "Delete Account",
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: AppColors.pureWhite,
                    context: context,
                    builder: (context) {
                      bool isLoading = false;
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return SizedBox(
                            height: 250,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                Center(
                                  child: AppTexts.bold(
                                    "Delete Account",
                                    fontSize: 20,
                                    color: AppColors.purered,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Text(
                                    "Are you sure you want to permanently delete your account?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      isLoading
                                          ? Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.purered,
                                            ),
                                          )
                                          : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                          255,
                                                          221,
                                                          219,
                                                          219,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Appnavigotor.pop(context);
                                                  },
                                                  child: AppTexts.semiBold(
                                                    "Cancel",
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.purered,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10,
                                                          ),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    setState(() {
                                                      isLoading = true;
                                                    });
                                                    try {
                                                      final supabase =
                                                          Supabase
                                                              .instance
                                                              .client;
                                                      final userId =
                                                          supabase
                                                              .auth
                                                              .currentUser
                                                              ?.id;

                                                      if (userId != null) {
                                                        final supabase =
                                                            Supabase
                                                                .instance
                                                                .client;

                                                        // Call RPC with param
                                                        await supabase.rpc(
                                                          'delete_user',
                                                          params: {
                                                            'uid': userId,
                                                          },
                                                        );

                                                        // Logout
                                                        await supabase.auth
                                                            .signOut();
                                                      }

                                                      if (context.mounted) {
                                                        Appnavigotor.pushNamedAndRemoveUntil(
                                                          context,
                                                          RouteNames.phoneLogin,
                                                        );
                                                      }
                                                    } catch (e) {
                                                      if (context.mounted) {
                                                        Appnavigotor.pop(
                                                          context,
                                                        );
                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              'Failed to delete account. Please try again.:${e.toString()}',
                                                            ),
                                                            backgroundColor:
                                                                AppColors
                                                                    .purered,
                                                          ),
                                                        );
                                                      }
                                                    } finally {
                                                      if (context.mounted) {
                                                        setState(() {
                                                          isLoading = false;
                                                        });
                                                      }
                                                    }
                                                  },
                                                  child: AppTexts.semiBold(
                                                    "Delete",
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
