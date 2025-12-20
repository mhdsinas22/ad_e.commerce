import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:ad_e_commerce/features/auth/pages/reset_password_page.dart';
import 'package:flutter/material.dart';
import '../../features/auth/pages/login_page.dart';
import '../../features/auth/pages/otp_page.dart';
import '../../features/auth/pages/signup_page.dart';
import '../../features/auth/pages/user_details_page.dart';
import '../../features/home/home_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    RouteNames.login: (_) => const LoginPage(),
    RouteNames.otp: (_) => const OtpPage(),
    RouteNames.signup: (_) => const SignupPage(),
    RouteNames.userDetails: (_) => const UserDetailsPage(phone: ""),
    RouteNames.home: (_) => const HomePage(),
    RouteNames.restPassword: (_) => const ResetPasswordPage(),
  };
}
