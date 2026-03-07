import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/utils/helpers.dart';
import 'package:ad_e_commerce/core/utils/navigator.dart';
import 'package:ad_e_commerce/features/profile/widgets/profile_menu_item.dart';
import 'package:ad_e_commerce/features/profile/widgets/profle_side_appbar.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileSideAppbar(title: "Account"),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              SizedBox(height: 20),
              ProfileMenuItem(
                title: "Profile Settings",
                onTap: () {
                  final supabaseClient = Supabase.instance.client;
                  final user = supabaseClient.auth.currentUser;
                  user == null
                      ? Helpers.showAuthBottomSheet(context)
                      : Appnavigotor.pushnamed(
                        context,
                        RouteNames.profileSetting,
                        [],
                      );
                },
              ),
              SizedBox(height: 10),
              ProfileMenuItem(
                title: "My Address",
                onTap: () {
                  final supabaseClient = Supabase.instance.client;
                  final user = supabaseClient.auth.currentUser;
                  user == null
                      ? Helpers.showAuthBottomSheet(context)
                      : Appnavigotor.pushnamed(context, RouteNames.checkout, {
                        "isMyaddressScreen": true,
                        "isDirectBuy": false,
                        "directProduct": null,
                      });
                },
              ),
              SizedBox(height: 10),
              ProfileMenuItem(
                title: "Support & Legal",
                onTap: () {
                  Appnavigotor.pushnamed(
                    context,
                    RouteNames.supportlegelpage,
                    [],
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
