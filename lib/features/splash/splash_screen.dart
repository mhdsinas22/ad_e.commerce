import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/services/app_links_service.dart';
import 'package:ad_e_commerce/core/services/notification_service.dart';
import 'package:ad_e_commerce/features/notification/data/datasource/notification_remote_datasourceimpl.dart';
import 'package:ad_e_commerce/features/notification/data/repositories/notification_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

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
    // iOS cold start-il link varaan max 2 seconds wait cheyyu,
    // athinu mumpu link ethiyaal udane response kittum.
    String? productId;

    try {
      productId = await AppLinksService.linkCompleter.future.timeout(
        const Duration(milliseconds: 2500),
      );
    } catch (e) {
      productId = AppLinksService.initialProductId;
    }

    if (!mounted) return;
    AppLinksService.isSplashFinished = true;

    // Final check: product ID undo ennu nokkuka
    productId ??= AppLinksService.initialProductId;

    if (productId != null && productId.isNotEmpty) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.productpage,
        (route) => false,
        arguments: productId,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.mainShell,
        (route) => false,
      );
    }
    FlutterNativeSplash.remove();
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
