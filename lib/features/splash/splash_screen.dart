import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/utils/helpers.dart';
import 'package:ad_e_commerce/features/bottom_navigation/pages/main_shell_page.dart';
import 'package:ad_e_commerce/features/onboardingStartPage/onboarding_StartPage.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final session = Supabase.instance.client.auth.currentSession;
  final user = Supabase.instance.client.auth.currentUser;
  @override
  void initState() {
    super.initState();
    startSplash();
  }

  Future<void> startSplash() async {
    await Helpers.delay(2);
    if (session != null && user != null) {
      // Logged in + Email verified
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return MainShellPage();
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) {
            return OnboardingStartpage();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              AssetConstants.airdropLetterLogo,
              width: 400,

              // ignore: deprecated_member_use
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
