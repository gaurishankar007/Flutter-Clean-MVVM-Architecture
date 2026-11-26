import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/domain/models/app_notification.dart';

abstract interface class NotificationRepository {
  StreamData<List<AppNotification>> watchNotifications();

  Stream<int> watchUnreadCount();

  /// Adds [notification] unless one with its id exists (reminders are
  /// idempotent per task and day).
  FutureVoid add(AppNotification notification);

  FutureVoid markRead(String id);

  FutureVoid markAllRead();

  FutureVoid clearAll();
}
