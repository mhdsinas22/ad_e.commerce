import 'package:ad_e_commerce/features/auth/pages/forgot_password_page.dart';
import 'package:ad_e_commerce/features/auth/pages/login_page.dart';
import 'package:ad_e_commerce/features/auth/pages/otp_page.dart';
import 'package:ad_e_commerce/features/auth/pages/reset_password_page.dart';
import 'package:ad_e_commerce/features/auth/pages/signup_page.dart';
import 'package:ad_e_commerce/features/auth/pages/user_details_page.dart';
import 'package:ad_e_commerce/features/auth/pages/email_verification_page.dart';
import 'package:ad_e_commerce/features/home/home_page.dart';

import 'package:flutter/material.dart';
import 'route_names.dart';

class RouteGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case RouteNames.otp:
        final phone = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => OtpPage(phone: phone));

      case RouteNames.signup:
        return MaterialPageRoute(builder: (_) => const SignupPage());

      case RouteNames.userDetails:
        return MaterialPageRoute(
          builder: (_) => const UserDetailsPage(phone: ""),
        );

      case RouteNames.emailVerification:
        return MaterialPageRoute(builder: (_) => const EmailVerificationPage());

      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RouteNames.restPassword:
        return MaterialPageRoute(builder: (context) => ResetPasswordPage());
      case RouteNames.forgotPassword:
        return MaterialPageRoute(builder: (context) => ForgotPasswordPage());
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
