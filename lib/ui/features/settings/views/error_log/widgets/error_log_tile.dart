import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/models/error_log_entry.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/badges/tag_chip.dart';
import 'package:clean_architecture/ui/core/ui/base/cards/app_card.dart';
import 'package:clean_architecture/ui/core/utils/date_formats.dart';
import 'package:material_ui/material_ui.dart';

class const ErrorLogTile({super.key, required final ErrorLogEntry entry})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppCard(
      child: Column(
        crossAxisAlignment: .start,
        spacing: AppSpacing.xs,
        children: [
          Row(
            spacing: AppSpacing.sm,
            children: [
              Expanded(
                child: Text(
                  DateFormats.dateTime(entry.createdAt),
                  style: context.text.caption.copyWith(color: colors.textMuted),
                ),
              ),
              if (entry.shown)
                TagChip(label: ErrorLogMessages.shown, color: colors.warning),
            ],
          ),
          Text(entry.message, style: context.text.bodyStrong),
          if (entry.action case final action?)
            Text(
              action,
              style: context.text.numeric.copyWith(color: colors.primaryText),
            ),
          if (entry.error case final error?)
            SelectableText(
              error,
              maxLines: 4,
              style: context.text.caption.copyWith(color: colors.textSecondary),
            ),
        ],
      ),
    );
  }
}
