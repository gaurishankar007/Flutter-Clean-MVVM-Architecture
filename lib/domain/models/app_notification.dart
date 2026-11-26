import 'package:equatable/equatable.dart';

enum NotificationType { welcome, todoCreated, todoCompleted, dueToday, overdue }

/// An inbox entry.
final class const AppNotification({
  required final String id,
  required final NotificationType type,
  required final String title,
  required final String body,
  required final DateTime createdAt,
  final String? todoId,
  final bool isRead = false,
}) extends Equatable {
  AppNotification markRead() => AppNotification(
    id: id,
    type: type,
    title: title,
    body: body,
    createdAt: createdAt,
    todoId: todoId,
    isRead: true,
  );

  @override
  List<Object?> get props => [id, type, title, body, createdAt, todoId, isRead];
}
