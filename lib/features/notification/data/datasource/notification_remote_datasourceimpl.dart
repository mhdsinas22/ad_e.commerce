import 'dart:io';
import 'package:aerstore/core/utils/app_logger.dart';
import 'package:aerstore/features/notification/data/datasource/notification_remote_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationRemoteDatasourceimpl implements NotificationRemoteDatasource {
  final SupabaseClient supabase = Supabase.instance.client;
  @override
  Future<void> saveToken(String token) async {
    try {
      final deviceType = Platform.isAndroid ? "android" : "ios";

      await supabase.from("device_tokens").upsert({
        "token": token,
        "user_id": null,
        "device_type": deviceType,
        "role": "user",
      });
    } catch (e) {
      AppLogger.error("Save Token Error:-${e.toString()}");
      throw Exception("Failed to save token");
    }
  }

  @override
  Future<void> attachUser(String token, String userId) async {
    final deviceType = Platform.isAndroid ? "android" : "ios";
    try {
      await supabase
          .from("device_tokens")
          .update({"user_id": userId, "device_type": deviceType})
          .eq("token", token);
    } catch (e) {
      AppLogger.error("AttachUser Error:-${e.toString()}");
    }
  }
}
