import 'package:clean_architecture/domain/models/app_notification.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';

final class const NotificationsState({
  super.status = .loading,
  super.message,
  final List<AppNotification> notifications = const [],
  final String? errorText,
}) extends BaseState {
  List<AppNotification> get unread => [
    for (final n in notifications)
      if (!n.isRead) n,
  ];

  List<AppNotification> get read => [
    for (final n in notifications)
      if (n.isRead) n,
  ];

  NotificationsState copyWith({
    StateStatus? status,
    StateMessage? message,
    List<AppNotification>? notifications,
    String? errorText,
  }) => NotificationsState(
    status: status ?? this.status,
    message: message,
    notifications: notifications ?? this.notifications,
    errorText: errorText ?? this.errorText,
  );

  @override
  List<Object?> get props => [...super.props, notifications, errorText];
}
