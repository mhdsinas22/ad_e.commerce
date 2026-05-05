import 'package:ad_e_commerce/core/enums/category.dart';
import 'package:ad_e_commerce/features/imageviewr/pages/image_zoom_screen.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/order_item.dart';
import 'package:ad_e_commerce/features/orders/domain/enities/orders.dart';
import 'package:ad_e_commerce/features/orders/pages/order_details_page.dart';
import 'package:ad_e_commerce/features/home/widgets/CategoryListSection/widgets/airdrop_assurcance/pages/assurance_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

// Imports from RouteGenerator
import 'package:ad_e_commerce/core/enums/phone_condition.dart';
import 'package:ad_e_commerce/core/enums/sub_category.dart';
import 'package:ad_e_commerce/features/auth/pages/forgot_password_page.dart';
import 'package:ad_e_commerce/features/auth/pages/login_page.dart';
import 'package:ad_e_commerce/features/auth/pages/otp_page.dart';
import 'package:ad_e_commerce/features/auth/pages/phone_login_page.dart';
import 'package:ad_e_commerce/features/auth/pages/reset_password_page.dart';
import 'package:ad_e_commerce/features/auth/pages/signup_page.dart';
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
import 'package:ad_e_commerce/features/orders/pages/orders_page.dart';
import 'package:ad_e_commerce/features/product/pages/product_page.dart';
import 'package:ad_e_commerce/features/profile/pages/edit_profile_page.dart';
import 'package:ad_e_commerce/features/profile/pages/my_account_page.dart';
import 'package:ad_e_commerce/features/profile/pages/support_legel_page.dart';
import 'package:ad_e_commerce/features/profile/pages/wallet_page.dart';
import 'package:ad_e_commerce/features/profile/pages/warranty_page.dart';
import 'package:ad_e_commerce/features/search/pages/search_page.dart';
import 'package:ad_e_commerce/features/splash/splash_screen.dart';

import 'package:ad_e_commerce/app.dart'; // For MyApp.navigatorKey
import 'route_names.dart';
import 'app_routes.dart';

final Logger _logger = Logger();

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger.i('didPush: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger.i('didPop: ${route.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger.i('didRemove: ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _logger.i('didReplace: ${newRoute?.settings.name}');
  }
}

final goRouter = GoRouter(
  navigatorKey: MyApp.navigatorKey,
  initialLocation: AppRoutes.splashpage,
  debugLogDiagnostics: true,
  observers: [GoRouterObserver()],
  routes: [
    // Splash Route
    GoRoute(
      path: AppRoutes.splashpage,
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),

    // Root/Home Path mapping to MainShell
    GoRoute(
      path: AppRoutes.mainshellpage,
      name: RouteNames.mainShell,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final index = extra?["index"] ?? 0;
        return MainShellPage(index: index);
      },
    ),

    // Auth Routes
    GoRoute(
      path: '/${RouteNames.login}',
      name: RouteNames.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/${RouteNames.phoneLogin}',
      name: RouteNames.phoneLogin,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>?;
        return PhoneLoginPage(
          redirectRoute: args?['redirectRoute'],
          redirectArgs: args?['redirectArgs'],
        );
      },
    ),
    GoRoute(
      path: '/${RouteNames.otp}',
      name: RouteNames.otp,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>?;
        return OtpPage(
          phone: args?["phone"] ?? "",
          name: args?["name"] ?? "",
          redirectRoute: args?['redirectRoute'],
          redirectArgs: args?['redirectArgs'],
        );
      },
    ),
    GoRoute(
      path: '/${RouteNames.signup}',
      name: RouteNames.signup,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>?;
        return SignupPage(
          redirectRoute: args?['redirectRoute'],
          redirectArgs: args?['redirectArgs'],
        );
      },
    ),
    GoRoute(
      path: '/${RouteNames.userDetails}',
      name: RouteNames.userDetails,
      builder: (context, state) => const UserDetailsPage(phone: ""),
    ),
    GoRoute(
      path: '/${RouteNames.emailVerification}',
      name: RouteNames.emailVerification,
      builder: (context, state) => const EmailVerificationPage(),
    ),
    GoRoute(
      path: '/${RouteNames.forgotPassword}',
      name: RouteNames.forgotPassword,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/${RouteNames.restPassword}',
      name: RouteNames.restPassword,
      builder: (context, state) => const ResetPasswordPage(),
    ),

    // Home & Categories
    GoRoute(
      path: '/home-page', // Distinct from root shell
      name: RouteNames.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/${RouteNames.onboardingstartpage}',
      name: RouteNames.onboardingstartpage,
      builder: (context, state) => const OnboardingStartpage(),
    ),
    GoRoute(
      path: '/${RouteNames.search}',
      name: RouteNames.search,
      builder: (context, state) => const SearchPage(),
    ),

    // Product Details with Deep Linking support
    GoRoute(
      path: "/productpage/:id",
      name: RouteNames.productpage,
      builder: (context, state) {
        final id = state.pathParameters["id"] ?? "";
        final extra = state.extra;

        if (extra is Map<String, dynamic>) {
          return ProductPage(
            product: extra["product"],
            productId: extra["productId"] ?? id,
          );
        }

        return ProductPage(productId: id, product: null);
      },
    ),

    // Cart & Checkout
    GoRoute(
      path: '/${RouteNames.cart}',
      name: RouteNames.cart,
      builder: (context, state) => const CartPage(),
    ),
    GoRoute(
      path: '/${RouteNames.checkout}',
      name: RouteNames.checkout,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return CheckoutPage(
          isMyaddressScreen: args["isMyaddressScreen"],
          isDirectBuy: args["isDirectBuy"],
          directProduct: args["directProduct"],
        );
      },
    ),
    GoRoute(
      path: '/${RouteNames.paymentpage}',
      name: RouteNames.paymentpage,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return PaymetPage(
          selectedAddress: args["selectedAddress"],
          isDirectBuy: args["isDirectBuy"] ?? false,
          directProduct: args["directProduct"],
        );
      },
    ),

    // Category Pages
    GoRoute(
      path: '/${RouteNames.phonecategories}',
      name: RouteNames.phonecategories,
      builder: (context, state) => const PhoneCategoriesPage(),
    ),
    GoRoute(
      path: '/${RouteNames.accessoriescategories}',
      name: RouteNames.accessoriescategories,
      builder: (context, state) => const AccesoriesCategoriesPage(),
    ),
    GoRoute(
      path: '/${RouteNames.laptopcategories}',
      name: RouteNames.laptopcategories,
      builder: (context, state) => const LaptopCatergoriesPage(),
    ),
    GoRoute(
      path: '/${RouteNames.earbudsCategories}',
      name: RouteNames.earbudsCategories,
      builder: (context, state) => const EarbudsCatergoryPage(),
    ),
    GoRoute(
      path: '/${RouteNames.wearablescategories}',
      name: RouteNames.wearablescategories,
      builder: (context, state) => const WearablesCatergoryPage(),
    ),
    GoRoute(
      path: '/${RouteNames.tabletcategories}',
      name: RouteNames.tabletcategories,
      builder: (context, state) => const TabletCategoriesPage(),
    ),
    GoRoute(
      path: '/${RouteNames.categoryfiltredpage}',
      name: RouteNames.categoryfiltredpage,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return CategoryFiltredPage(
          condition:
              args["condition"] as PhoneCondition? ?? PhoneCondition.empty,
          subCategory:
              (args["subCategory"] ?? args["SubCategory"]) as SubCategory? ??
              SubCategory.empty,
          isSubCategory: args["isSubCategory"] ?? false,
          isFlashSale: args["isFlashSale"] ?? false,
          category: args["category"] as Category? ?? Category.empty,
          priceTYpe: args["priceTYpe"],
          priceAmount: args["priceAmount"],
          isBestSeller: args["isBestSeller"] ?? false,
        );
      },
    ),

    // Profile & Misc
    GoRoute(
      path: '/${RouteNames.orderspage}',
      name: RouteNames.orderspage,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>?;
        return OrdersPage(isPushOnly: args?["isPushOnly"] ?? false);
      },
    ),
    GoRoute(
      path: '/${RouteNames.orderDetails}',
      name: RouteNames.orderDetails,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return OrderDetailsPage(
          order: args["order"] as Orders,
          orderItem: args["orderItem"] as OrderItem,
        );
      },
    ),
    GoRoute(
      path: '/${RouteNames.assuranceDetail}',
      name: RouteNames.assuranceDetail,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return AssuranceDetailPage(
          title: args["title"] as String,
          subtitle: args["subtitle"] as String,
          points: args["points"] as List<String>,
        );
      },
    ),
    GoRoute(
      path: '/${RouteNames.profileSetting}',
      name: RouteNames.profileSetting,
      builder: (context, state) => const EditProfilePage(),
    ),
    GoRoute(
      path: '/${RouteNames.myaccountpage}',
      name: RouteNames.myaccountpage,
      builder: (context, state) => const MyAccountPage(),
    ),
    GoRoute(
      path: '/${RouteNames.supportlegelpage}',
      name: RouteNames.supportlegelpage,
      builder: (context, state) => const SupportLegelPage(),
    ),
    GoRoute(
      path: '/${RouteNames.wallet}',
      name: RouteNames.wallet,
      builder: (context, state) => const WalletPage(),
    ),
    GoRoute(
      path: '/${RouteNames.warranty}',
      name: RouteNames.warranty,
      builder: (context, state) => const WarrantyPage(),
    ),
    GoRoute(
      path: "/${RouteNames.imageZoom}",
      name: RouteNames.imageZoom,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>;
        return ImageZoomScreen(images: args["image"] as List<String>);
      },
    ),
  ],
  errorBuilder: (context, state) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Oops! Page not found.',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(state.error.toString(), textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.mainshellpage),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  },
);
