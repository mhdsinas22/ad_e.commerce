import 'package:ad_e_commerce/features/notification/data/datasource/notification_remote_datasource.dart';
import 'package:ad_e_commerce/features/notification/domain/repositories/notification_repository.dart';

class NotificationRepoImpl implements NotificationRepository {
  final NotificationRemoteDatasource remoteDatasource;
  NotificationRepoImpl(this.remoteDatasource);
  @override
  Future<void> saveToken(String token) {
    return remoteDatasource.saveToken(token);
  }

  @override
  Future<void> attachUser(String token, String userId) {
    return remoteDatasource.attachUser(token, userId);
  }
}
