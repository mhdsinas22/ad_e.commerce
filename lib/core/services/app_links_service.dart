import 'dart:async';

import 'package:ad_e_commerce/app.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';

class AppLinksService {
  static final _applinks = AppLinks();
  static StreamSubscription<Uri>? _streamSubscription;
  // static Completer<void> _completer = Completer<void>();
  static String? initialProductId;
  static bool isSplashFinished = false;

  static Future<void> init() async {
    // 1. Initial Link (Cold Start)
    try {
      final initialUri = await _applinks.getInitialLink();
      _processUri(initialUri);
    } catch (e) {
      debugPrint("Failed to get initial link: $e");
    }
    // 2. Stream (App Background or delayed Cold Start on iOS)
    _streamSubscription = _applinks.uriLinkStream.listen((uri) {
      _processUri(uri);
    });
  }

  static void _processUri(Uri? uri) {
    if (uri == null || kIsWeb) return;

    if (uri.path.contains("productpage")) {
      final productId = uri.pathSegments.last;
      if (productId.isNotEmpty) {
        initialProductId = productId;

        // If splash is finished, navigate immediately.
        // Otherwise, SplashScreen will pick up initialProductId and navigate.
        if (isSplashFinished) {
          _navigateToProduct(productId);
        }
      }
    }
  }

  static void _navigateToProduct(String productId) {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (MyApp.navigatorKey.currentState != null) {
        MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          RouteNames.productpage,
          (route) => false,
          arguments: productId,
        );
      }
    });
  }

  static void dispose() {
    _streamSubscription?.cancel();
  }
}
