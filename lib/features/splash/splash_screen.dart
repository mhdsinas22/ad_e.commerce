import 'package:ad_e_commerce/core/constants/asset_constants.dart';
import 'package:ad_e_commerce/core/routes/app_routes.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/core/services/notification_service.dart';
import 'package:ad_e_commerce/features/notification/data/datasource/notification_remote_datasourceimpl.dart';
import 'package:ad_e_commerce/features/notification/data/repositories/notification_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  String? productId;
  @override
  void initState() {
    super.initState();

    notificationRepo = NotificationRepoImpl(NotificationRemoteDatasourceimpl());
    notificationService = NotificationService(notificationRepo);
    notificationService.initialize();
    startSplash();
  }

  Future<void> startSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    // Ippo nilvile state full aayi edukuka
    final routerState = GoRouterState.of(context);
    final String path =
        routerState.uri.path; // Ithu '/productpage/ID' mathrame tharu

    // Path empty aanel allenkil splash aanel mathram Home-lekk viduka
    if (path == "/" || path.isEmpty || path == AppRoutes.splashpage) {
      context.goNamed(RouteNames.mainShell);
    } else {
      // Deep link path ippo GoRouter automatically handle cheytholum.
      // Ivide extra `context.go` vilikkenda aavashyamilla, logic mathram thടanjal mathi.
      debugPrint("Deep link detected on path: $path");
    }
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
