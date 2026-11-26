import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/utils/date_formats.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// A task's due day (and time), in `error` when overdue.
class const DueLabel({
  super.key,
  required final DateTime dueAt,
  final bool overdue = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = overdue ? context.colors.error : context.colors.textSecondary;
    return Row(
      mainAxisSize: .min,
      spacing: AppSpacing.xs,
      children: [
        Icon(Symbols.event_rounded, size: 14, color: color),
        Text(
          DateFormats.relativeDay(
            dueAt,
            today: TodoMessages.dueToday,
            tomorrow: TodoMessages.dueTomorrow,
            yesterday: TodoMessages.dueYesterday,
          ),
          style: context.text.caption.copyWith(color: color),
        ),
      ],
    );
  }
}
