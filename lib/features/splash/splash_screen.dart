import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/services/notification_service.dart';
import 'package:ad_e_commerce/core/utils/helpers.dart';
import 'package:ad_e_commerce/features/bottom_navigation/pages/main_shell_page.dart';
import 'package:ad_e_commerce/features/notification/data/datasource/notification_remote_datasourceimpl.dart';
import 'package:ad_e_commerce/features/notification/data/repositories/notification_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final session = Supabase.instance.client.auth.currentSession;
  final user = Supabase.instance.client.auth.currentUser;
  late NotificationRepoImpl notificationRepo;
  late NotificationService notificationService;
  @override
  void initState() {
    super.initState();

    notificationRepo = NotificationRepoImpl(NotificationRemoteDatasourceimpl());
    notificationService = NotificationService(notificationRepo);
    notificationService.initialize();
    startSplash();
  }

  Future<void> startSplash() async {
    await Helpers.delay(2);
    // Logged in + Email verified
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) {
          return MainShellPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(AssetConstants.aerprimarylogo, width: 200),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
