abstract class NotificationRepository {
  Future<void> saveToken(String token);
  Future<void> attachUser(String token, String userId);
}
