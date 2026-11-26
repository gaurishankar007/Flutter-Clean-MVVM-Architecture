import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// `2/5` with a checklist icon.
class const SubtaskCount({super.key, required final Todo todo})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = context.colors.textSecondary;
    return Row(
      mainAxisSize: .min,
      spacing: AppSpacing.xs,
      children: [
        Icon(Symbols.checklist_rounded, size: 14, color: color),
        Text(
          TodoMessages.subtaskProgress(
            todo.completedSubtasks,
            todo.subtasks.length,
          ),
          style: context.text.numeric.copyWith(color: color, fontSize: 12),
        ),
      ],
    );
  }
}
