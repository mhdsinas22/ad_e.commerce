import 'package:aerstore/core/routes/router_confiq.dart';
import 'package:aerstore/core/theme/app_colors.dart';
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
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      theme: ThemeData(
        fontFamily: "Manrope",
        scaffoldBackgroundColor: AppColors.pureWhite,
        appBarTheme: AppBarTheme(backgroundColor: AppColors.pureWhite),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
