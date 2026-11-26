import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/data/models/mappers/notification_mapper.dart';
import 'package:clean_architecture/data/services/local/notification_local_service.dart';
import 'package:clean_architecture/domain/models/app_notification.dart';
import 'package:clean_architecture/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: NotificationRepository)
final class NotificationRepositoryImpl({
  required final NotificationLocalService _local,
}) implements NotificationRepository {
  @override
  StreamData<List<AppNotification>> watchNotifications() =>
      _local.watchAll().map(
        (state) =>
            state.mapData((rows) => rows.map((r) => r.toDomain()).toList()),
      );

  @override
  Stream<int> watchUnreadCount() => _local.watchUnreadCount();

  @override
  FutureVoid add(AppNotification notification) =>
      _local.insertIfAbsent(notification.toCompanion());

  @override
  FutureVoid markRead(String id) => _local.markRead(id);

  @override
  FutureVoid markAllRead() => _local.markRead(null);

  @override
  FutureVoid clearAll() => _local.deleteAll();
}
