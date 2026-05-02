import 'package:ad_e_commerce/core/routes/route_generator.dart';
import 'package:ad_e_commerce/core/services/app_links_service.dart';
import 'package:ad_e_commerce/core/theme/app_colors.dart';
import 'package:ad_e_commerce/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    AppLinksService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: MyApp.navigatorKey,
      theme: ThemeData(
        fontFamily: "Manrope",
        scaffoldBackgroundColor: AppColors.pureWhite,
        appBarTheme: AppBarTheme(backgroundColor: AppColors.pureWhite),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generate,
      home: SplashScreen(),
    );
  }
}
