import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/services/app_links_service.dart';
import 'package:ad_e_commerce/core/services/notification_service.dart';
import 'package:ad_e_commerce/features/notification/data/datasource/notification_remote_datasourceimpl.dart';
import 'package:ad_e_commerce/features/notification/data/repositories/notification_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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
    // iOS gets link little slower sometimes, wait briefly for stream to provide it
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      await Future.delayed(Duration(milliseconds: 500));
    }

    if (!mounted) return;

    // Mark splash as finished so AppLinksService handles future links directly
    AppLinksService.isSplashFinished = true;

    String? productId = AppLinksService.initialProductId;

    // PRIORITY 1.5: Flutter Native Initial Route Check (Reliable for iOS Cold Starts fallback)
    if (productId == null) {
      final nativeInitialRoute = PlatformDispatcher.instance.defaultRouteName;
      if (nativeInitialRoute.contains("productpage")) {
        final uri = Uri.parse(nativeInitialRoute);
        if (uri.pathSegments.isNotEmpty) {
          productId = uri.pathSegments.last;
        }
      }
    }

    // PRIORITY 2: Web-ilo iOS direct URL-ilo link undo ennu nokkunnu fallback
    if (productId == null) {
      final currentPath = Uri.base.path;
      if (currentPath.contains("productpage")) {
        final uri = Uri.base;
        if (uri.pathSegments.isNotEmpty) {
          productId = uri.pathSegments.last;
        }
      }
    }

    // --- NAVIGATION LOGIC ---
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

    // Remove the native splash screen since we are navigating to the final screen
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
