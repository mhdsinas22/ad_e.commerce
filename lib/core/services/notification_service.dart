import 'package:ad_e_commerce/core/utils/app_logger.dart';
import 'package:ad_e_commerce/features/notification/domain/repositories/notification_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final NotificationRepository repository;
  NotificationService(this.repository);
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  String? currentToken;
  // 1 Initialize notification system
  Future<void> initialize() async {
    await requestPermission();
    // 🔥 IMPORTANT: Trigger APNS registration

    // 🔥 Trigger APNS
    await _messaging.getToken();

    String? apns;

    // 🔁 retry (important for iOS delay)
    for (int i = 0; i < 5; i++) {
      await Future.delayed(Duration(seconds: 1));
      apns = await _messaging.getAPNSToken();
      if (apns != null) break;
    }

    AppLogger.info("APNS TOKEN: $apns");

    await getToken();

    if (apns == null) {
      AppLogger.error("APNS still null ❌ (rare case)");
    }
    listenTokenRefresh();
    listenForeground();
  }

  // 2 Request notification permission
  Future<void> requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    AppLogger.info("Notification Permission: ${settings.authorizationStatus}");
  }

  // 3  Get FCM token
  Future<void> getToken() async {
    try {
      currentToken = await _messaging.getToken();
      AppLogger.info("FCM TOKEN: $currentToken");
      if (currentToken != null) {
        await repository.saveToken(currentToken!);
      }
    } catch (e) {
      AppLogger.error("FCM TOKEN: $e");
    }
  }

  // 4  Listen token refresh
  void listenTokenRefresh() {
    _messaging.onTokenRefresh.listen((newToken) async {
      currentToken = newToken;
      await repository.saveToken(newToken);
    });
  }

  // if User is Loggined
  Future<void> attachUser(String userId) async {
    try {
      AppLogger.info("User ID For Attach User: $userId");
      currentToken ??= await _messaging.getToken();
      if (currentToken == null) {
        AppLogger.error("Current token is Null");
        return;
      }
      await repository.attachUser(currentToken!, userId);
    } catch (e) {
      AppLogger.error("Attach User Error:-${e.toString()}");
    }
  }

  void listenForeground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AppLogger.info("Foreground Notification: ${message.notification?.title}");
    });
  }
}
