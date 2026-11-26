import 'package:clean_architecture/domain/models/app_notification.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/cards/app_card.dart';
import 'package:clean_architecture/ui/core/utils/date_formats.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// One inbox entry: a type icon, title, body, time and an unread dot.
class const NotificationTile({
  super.key,
  required final AppNotification notification,
  required final VoidCallback onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final (icon, color) = switch (notification.type) {
      .welcome => (Symbols.waving_hand_rounded, colors.primaryText),
      .todoCreated => (Symbols.add_task_rounded, colors.secondary),
      .todoCompleted => (Symbols.task_alt_rounded, colors.success),
      .dueToday => (Symbols.today_rounded, colors.warning),
      .overdue => (Symbols.alarm_rounded, colors.error),
    };
    return AppCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: .start,
        spacing: AppSpacing.md,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: AppRadius.mdAll,
            ),
            child: Icon(icon, color: color, fill: 1, size: 22),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: 2,
              children: [
                Text(
                  notification.title,
                  maxLines: 2,
                  overflow: .ellipsis,
                  style: notification.isRead
                      ? context.text.body
                      : context.text.bodyStrong,
                ),
                Text(
                  notification.body,
                  style: context.text.label.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                Text(
                  DateFormats.dateTime(notification.createdAt),
                  style: context.text.caption.copyWith(color: colors.textMuted),
                ),
              ],
            ),
          ),
          if (!notification.isRead)
            Container(
              width: 8,
              height: 8,
              margin: const .only(top: AppSpacing.sm),
              decoration: BoxDecoration(
                color: colors.primaryText,
                shape: .circle,
              ),
            ),
        ],
      ),
    );
  }
}
