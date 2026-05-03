import 'dart:async';

import 'package:ad_e_commerce/app.dart';
import 'package:ad_e_commerce/core/routes/route_names.dart';
import 'package:app_links/app_links.dart';

class AppLinksService {
  static final _applinks = AppLinks();
  static StreamSubscription<Uri>? _streamSubscription;
  static String? initialProductId;
  static bool isSplashFinished = false;
  // Link vannu ennu Splash-ine ariyikkaan vendi
  static Completer<String?> linkCompleter = Completer<String?>();
  static Future<void> init() async {
    // 1. Initial Link (Cold Start)
    try {
      final initialUri = await _applinks.getInitialLink();
      if (initialUri != null) {
        _processUri(initialUri);
      }
    } catch (e) {
      if (!linkCompleter.isCompleted) linkCompleter.complete(null);
    }
    // 2. Stream (App Background or delayed Cold Start on iOS)
    _streamSubscription = _applinks.uriLinkStream.listen((uri) {
      _processUri(uri);
    });
  }

  static void _processUri(Uri? uri) {
    if (uri == null) return;

    if (uri.path.contains("productpage")) {
      final productId = uri.pathSegments.last;
      if (productId.isNotEmpty) {
        initialProductId = productId;
        if (!linkCompleter.isCompleted) linkCompleter.complete(productId);
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
