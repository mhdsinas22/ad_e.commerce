import 'package:aerstore/core/enums/category.dart';
import 'package:aerstore/features/cart/pages/cart_page.dart';
import 'package:aerstore/features/home/pages/home_page.dart';
import 'package:aerstore/features/imageviewr/pages/image_zoom_screen.dart';
import 'package:aerstore/features/orders/domain/enities/order_item.dart';
import 'package:aerstore/features/orders/domain/enities/orders.dart';
import 'package:aerstore/features/orders/pages/order_details_page.dart';
import 'package:aerstore/features/home/widgets/CategoryListSection/widgets/airdrop_assurcance/pages/assurance_detail_page.dart';
import 'package:aerstore/features/profile/pages/profile_page.dart';
import 'package:aerstore/features/repair/pages/repair_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

// Imports from RouteGenerator
import 'package:aerstore/core/enums/phone_condition.dart';
import 'package:aerstore/core/enums/sub_category.dart';
import 'package:aerstore/features/auth/pages/forgot_password_page.dart';
import 'package:aerstore/features/auth/pages/login_page.dart';
import 'package:aerstore/features/auth/pages/otp_page.dart';
import 'package:aerstore/features/auth/pages/phone_login_page.dart';
import 'package:aerstore/features/auth/pages/reset_password_page.dart';
import 'package:aerstore/features/auth/pages/signup_page.dart';
import 'package:aerstore/features/auth/pages/user_details_page.dart';
import 'package:aerstore/features/auth/pages/email_verification_page.dart';
import 'package:aerstore/features/bottom_navigation/pages/main_shell_page.dart';
import 'package:aerstore/features/checkout/presentation/pages/checkout_page.dart';
import 'package:aerstore/features/checkout/presentation/pages/paymet_page.dart';
import 'package:aerstore/features/home/pages/accesories_categories_page.dart';
import 'package:aerstore/features/home/pages/category_filtred_page.dart';
import 'package:aerstore/features/home/pages/earbuds_catergory_page.dart';
import 'package:aerstore/features/home/pages/laptop_catergories_page.dart';
import 'package:aerstore/features/home/pages/phone_categories_page.dart';
import 'package:aerstore/features/home/pages/tablet_categories_page.dart';
import 'package:aerstore/features/home/pages/wearables_catergory_page.dart';
import 'package:aerstore/features/onboardingStartPage/onboarding_startpage.dart';
import 'package:aerstore/features/orders/pages/orders_page.dart';
import 'package:aerstore/features/product/pages/product_page.dart';
import 'package:aerstore/features/profile/pages/edit_profile_page.dart';
import 'package:aerstore/features/profile/pages/my_account_page.dart';
import 'package:aerstore/features/profile/pages/support_legel_page.dart';
import 'package:aerstore/features/profile/pages/wallet_page.dart';
import 'package:aerstore/features/profile/pages/warranty_page.dart';
import 'package:aerstore/features/search/pages/search_page.dart';
import 'package:aerstore/features/splash/splash_screen.dart';

import 'package:aerstore/app.dart'; // For MyApp.navigatorKey
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
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShellPage(shell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/",
              name: RouteNames.mainShell,
              builder: (context, state) {
                return HomePage(
                  oncCartTap: () {
                    StatefulNavigationShell.of(context).goBranch(1);
                  },
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/${RouteNames.cart}',
              name: RouteNames.cart,
              builder: (context, state) => const CartPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/${RouteNames.orderspage}',
              name: RouteNames.orderspage,
              builder: (context, state) {
                final args = state.extra as Map<String, dynamic>?;
                return OrdersPage(isPushOnly: args?["isPushOnly"] ?? false);
              },
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/${RouteNames.service}",
              name: RouteNames.service,
              builder: (context, state) {
                return RepairPage(
                  onCartTap:
                      () => StatefulNavigationShell.of(context).goBranch(1),
                );
              },
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/${RouteNames.profilepage}",
              name: RouteNames.profilepage,
              builder: (context, state) {
                return ProfilePage();
              },
            ),
          ],
        ),
      ],
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
        final search = state.uri.queryParameters['search'];
        final subCategoryName = state.uri.queryParameters['subcategory'];
        final conditionName = state.uri.queryParameters['condition'];
        final categoryName = state.uri.queryParameters["category"];
        final subCategory = SubCategory.values.firstWhere(
          (e) => e.name == subCategoryName,

          orElse: () => SubCategory.empty,
        );

        final condition = PhoneCondition.values.firstWhere(
          (e) => e.name == conditionName,

          orElse: () => PhoneCondition.empty,
        );
        final category = Category.values.firstWhere(
          (element) => element.name == categoryName,
          orElse: () => Category.empty,
        );
        final isSubCategory =
            state.uri.queryParameters["isSubCategory"] == "true";
        final isFlashSale = state.uri.queryParameters["isFlashSale"] == "true";

        final pricetype = state.uri.queryParameters["priceTYpe"];
        final priceAmount =
            int.tryParse(state.uri.queryParameters["priceAmount"] ?? "") ?? 0;
        final isBestSeller =
            state.uri.queryParameters["isBestSeller"] == "true";
        final onlyphone = state.uri.queryParameters["onlyPhones"] == "true";
        return CategoryFiltredPage(
          search: search,
          condition: condition,
          subCategory: subCategory,
          isSubCategory: isSubCategory,
          isFlashSale: isFlashSale,
          category: category,
          priceTYpe: pricetype,
          priceAmount: priceAmount,
          isBestSeller: isBestSeller,
          onlyPhones: onlyphone,
        );
      },
    ),
    // Profile & Misc
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
      builder: (context, state) => WarrantyPage(),
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
              onPressed: () => context.go("/"),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  },
);
