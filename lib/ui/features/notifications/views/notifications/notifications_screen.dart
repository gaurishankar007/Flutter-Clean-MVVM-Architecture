import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_header.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_scroll_view.dart';
import 'package:clean_architecture/ui/core/ui/base/states/empty_state.dart';
import 'package:clean_architecture/ui/core/ui/base/states/error_state.dart';
import 'package:clean_architecture/ui/core/ui/base/states/shimmer_box.dart';
import 'package:clean_architecture/ui/core/utils/extensions/ref_extension.dart';
import 'package:clean_architecture/ui/features/notifications/providers/notifications/notifications_notifier.dart';
import 'package:clean_architecture/ui/features/notifications/views/notifications/widgets/notification_group.dart';
import 'package:clean_architecture/ui/features/notifications/views/notifications/widgets/notifications_actions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// The Inbox tab.
@RoutePage()
class const NotificationsScreen({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listenMessages(notificationsProvider, context);
    final state = ref.watch(notificationsProvider);
    return ScreenScrollView(
      children: [
        const ScreenHeader(
          title: NotificationMessages.title,
          subtitle: NotificationMessages.subtitle,
        ),
        ...switch (state.status) {
          .loading => const [
            ShimmerBox(height: 72),
            SizedBox(height: 8),
            ShimmerBox(height: 72),
          ],
          .error => [
            ErrorState(message: state.errorText ?? CommonMessages.genericError),
          ],
          _ when state.notifications.isEmpty => const [
            EmptyState(
              icon: Symbols.notifications_off_rounded,
              title: NotificationMessages.emptyTitle,
              body: NotificationMessages.emptyBody,
            ),
          ],
          _ => [
            NotificationsActions(hasUnread: state.unread.isNotEmpty),
            NotificationGroup(
              title: NotificationMessages.sectionNew,
              notifications: state.unread,
            ),
            NotificationGroup(
              title: NotificationMessages.sectionEarlier,
              notifications: state.read,
            ),
          ],
        },
      ],
    );
  }
}
