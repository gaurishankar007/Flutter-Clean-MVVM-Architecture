import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/domain/models/app_notification.dart';
import 'package:clean_architecture/routing/routes.gr.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/ui/base/text/section_header.dart';
import 'package:clean_architecture/ui/features/notifications/providers/notifications/notifications_notifier.dart';
import 'package:clean_architecture/ui/features/notifications/views/notifications/widgets/notification_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// A titled group; hidden when empty. Tapping marks read and opens the task.
class const NotificationGroup({
  super.key,
  required final String title,
  required final List<AppNotification> notifications,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (notifications.isEmpty) {
      return const SizedBox.shrink();
    }
    final notifier = ref.read(notificationsProvider.notifier);
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        SectionHeader(title: title),
        for (final (index, notification) in notifications.indexed) ...[
          if (index > 0) const SizedBox(height: AppSpacing.sm),
          NotificationTile(
            key: ValueKey(notification.id),
            notification: notification,
            onTap: () {
              if (!notification.isRead) {
                notifier.markRead(notification.id);
              }
              if (notification.todoId case final todoId?) {
                context.router.push(TodoDetailRoute(todoId: todoId));
              }
            },
          ),
        ],
      ],
    );
  }
}
