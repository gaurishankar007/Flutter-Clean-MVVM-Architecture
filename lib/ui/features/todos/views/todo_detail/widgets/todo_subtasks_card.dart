import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/cards/app_card.dart';
import 'package:clean_architecture/ui/core/ui/base/progress/gradient_progress_bar.dart';
import 'package:clean_architecture/ui/core/ui/base/text/section_header.dart';
import 'package:clean_architecture/ui/features/todos/widgets/subtask_tile.dart';
import 'package:material_ui/material_ui.dart';

/// Checklist with a progress bar.
class const TodoSubtasksCard({
  super.key,
  required final Todo todo,
  required final ValueChanged<String> onToggle,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final subtasks = todo.subtasks;
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        SectionHeader(
          title: TodoMessages.subtasks,
          trailing: subtasks.isEmpty
              ? null
              : Text(
                  TodoMessages.subtaskProgress(
                    todo.completedSubtasks,
                    subtasks.length,
                  ),
                  style: context.text.numeric.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
        ),
        AppCard(
          padding: const .symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.sm,
          ),
          child: subtasks.isEmpty
              ? Padding(
                  padding: const .all(AppSpacing.sm),
                  child: Text(
                    TodoMessages.noSubtasks,
                    style: context.text.body.copyWith(
                      color: context.colors.textMuted,
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: .stretch,
                  children: [
                    Padding(
                      padding: const .fromLTRB(
                        AppSpacing.sm,
                        AppSpacing.sm,
                        AppSpacing.sm,
                        AppSpacing.xs,
                      ),
                      child: GradientProgressBar(value: todo.progress),
                    ),
                    for (final subtask in subtasks)
                      SubtaskTile(
                        subtask: subtask,
                        onToggle: () => onToggle(subtask.id),
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}
