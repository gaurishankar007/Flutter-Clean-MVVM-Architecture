import 'package:clean_architecture/core/clients/database/app_database.dart';
import 'package:clean_architecture/domain/models/app_notification.dart';
import 'package:drift/drift.dart';

extension NotificationRowMapper on NotificationLocalData {
  AppNotification toDomain() => AppNotification(
    id: id,
    type: NotificationType.values.asNameMap()[type] ?? .welcome,
    title: title,
    body: body,
    todoId: todoId,
    isRead: isRead,
    createdAt: createdAt,
  );
}

extension NotificationCompanionMapper on AppNotification {
  NotificationLocalCompanion toCompanion() => NotificationLocalCompanion(
    id: Value(id),
    type: Value(type.name),
    title: Value(title),
    body: Value(body),
    todoId: Value(todoId),
    isRead: Value(isRead),
    createdAt: Value(createdAt),
  );
}
