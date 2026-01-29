import 'package:ad_e_commerce/features/auth/pages/forgot_password_page.dart';
import 'package:ad_e_commerce/features/auth/pages/login_page.dart';
import 'package:ad_e_commerce/features/auth/pages/otp_page.dart';
import 'package:ad_e_commerce/features/auth/pages/reset_password_page.dart';
import 'package:ad_e_commerce/features/auth/pages/user_details_page.dart';
import 'package:ad_e_commerce/features/auth/pages/email_verification_page.dart';
import 'package:ad_e_commerce/features/bottom_navigation/pages/main_shell_page.dart';
import 'package:ad_e_commerce/features/cart/pages/cart_page.dart';
import 'package:ad_e_commerce/features/checkout/presentation/pages/checkout_page.dart';
import 'package:ad_e_commerce/features/checkout/presentation/pages/paymet_page.dart';
import 'package:ad_e_commerce/features/home/pages/accesories_categories_page.dart';
import 'package:ad_e_commerce/features/home/pages/category_filtred_page.dart';
import 'package:ad_e_commerce/features/home/pages/earbuds_catergory_page.dart';
import 'package:ad_e_commerce/features/home/pages/home_page.dart';
import 'package:ad_e_commerce/features/home/pages/laptop_catergories_page.dart';
import 'package:ad_e_commerce/features/home/pages/phone_categories_page.dart';
import 'package:ad_e_commerce/features/home/pages/tablet_categories_page.dart';
import 'package:ad_e_commerce/features/home/pages/wearables_catergory_page.dart';
import 'package:ad_e_commerce/features/onboardingStartPage/onboarding_startpage.dart';
import 'package:ad_e_commerce/features/product/pages/product_page.dart';
import 'package:ad_e_commerce/features/profile/pages/warranty_page.dart';
import 'package:ad_e_commerce/features/search/pages/search_page.dart';

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
        return MaterialPageRoute(
          builder: (_) => const UserDetailsPage(phone: ""),
        );

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
      case RouteNames.onboardingstartpage:
        return MaterialPageRoute(builder: (context) => OnboardingStartpage());
      case RouteNames.mainShell:
        return MaterialPageRoute(builder: (context) => MainShellPage());
      case RouteNames.search:
        return MaterialPageRoute(builder: (context) => SearchPage());
      case RouteNames.productpage:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ProductPage(product: args["product"]),
        );
      case RouteNames.cart:
        return MaterialPageRoute(builder: (context) => CartPage());
      case RouteNames.checkout:
        return MaterialPageRoute(builder: (context) => CheckoutPage());
      case RouteNames.paymentpage:
        return MaterialPageRoute(builder: (context) => PaymetPage());
      case RouteNames.warranty:
        return MaterialPageRoute(builder: (context) => WarrantyPage());
      case RouteNames.phonecategories:
        return MaterialPageRoute(builder: (context) => PhoneCategoriesPage());
      case RouteNames.accessoriescategories:
        return MaterialPageRoute(
          builder: (context) => AccesoriesCategoriesPage(),
        );
      case RouteNames.laptopcategories:
        return MaterialPageRoute(builder: (context) => LaptopCatergoriesPage());
      case RouteNames.earbudsCategories:
        return MaterialPageRoute(builder: (context) => EarbudsCatergoryPage());
      case RouteNames.wearablescategories:
        return MaterialPageRoute(
          builder: (context) => WearablesCatergoryPage(),
        );
      case RouteNames.tabletcategories:
        return MaterialPageRoute(builder: (context) => TabletCategoriesPage());
      case RouteNames.categoryfiltredpage:
        final condition = settings.arguments as PhoneCondition;
        return MaterialPageRoute(
          builder: (context) => CategoryFiltredPage(condition: condition),
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
