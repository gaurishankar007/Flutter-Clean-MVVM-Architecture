import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/ghost_button.dart';
import 'package:clean_architecture/ui/core/ui/base/dialog/confirm_dialog.dart';
import 'package:clean_architecture/ui/features/notifications/providers/notifications/notifications_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// Mark all read and Clear all.
class const NotificationsActions({super.key, required final bool hasUnread})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(notificationsProvider.notifier);
    return Row(
      mainAxisAlignment: .end,
      children: [
        if (hasUnread)
          GhostButton(
            label: NotificationMessages.markAllRead,
            icon: Symbols.done_all_rounded,
            onPressed: notifier.markAllRead,
          ),
        GhostButton(
          label: NotificationMessages.clearAll,
          icon: Symbols.delete_sweep_rounded,
          destructive: true,
          onPressed: () async {
            final confirmed = await showConfirmDialog(
              context,
              title: NotificationMessages.clearAllTitle,
              body: NotificationMessages.clearAllBody,
              confirmLabel: NotificationMessages.clearAll,
              destructive: true,
            );
            if (confirmed) {
              await notifier.clearAll();
            }
          },
        ),
      ],
    );
  }
}
