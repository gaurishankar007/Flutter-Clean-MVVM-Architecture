import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/cards/app_card.dart';
import 'package:clean_architecture/ui/core/ui/base/form/app_checkbox.dart';
import 'package:clean_architecture/ui/features/todos/models/todo_presentation.dart';
import 'package:clean_architecture/ui/features/todos/widgets/category_tag.dart';
import 'package:clean_architecture/ui/features/todos/widgets/due_label.dart';
import 'package:clean_architecture/ui/features/todos/widgets/subtask_count.dart';
import 'package:material_ui/material_ui.dart';

/// A task in the list: check, title, notes preview, tags, due day and
/// subtask count. A priority stripe marks the left edge.
class const TodoCard({
  super.key,
  required final Todo todo,
  required final VoidCallback onTap,
  required final ValueChanged<bool> onCompletedChanged,
  final VoidCallback? onLongPress,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final done = todo.isCompleted;
    return GestureDetector(
      onLongPress: onLongPress,
      child: AppCard(
        onTap: onTap,
        padding: .zero,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: .stretch,
            children: [
              Container(width: 4, color: todo.priority.color(colors)),
              Padding(
                padding: const .only(left: AppSpacing.xs, top: AppSpacing.xs),
                child: Align(
                  alignment: .topCenter,
                  child: AppCheckbox(
                    value: done,
                    label: done
                        ? TodoMessages.markNotDone
                        : TodoMessages.markDone,
                    ringColor: todo.priority.color(colors),
                    onChanged: onCompletedChanged,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const .fromLTRB(
                    0,
                    AppSpacing.md + 2,
                    AppSpacing.lg,
                    AppSpacing.md,
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: AppSpacing.xs + 2,
                    children: [
                      Text(
                        todo.title,
                        maxLines: 2,
                        overflow: .ellipsis,
                        style: context.text.bodyStrong.copyWith(
                          color: done ? colors.textMuted : colors.textPrimary,
                          decoration: done ? .lineThrough : null,
                        ),
                      ),
                      if (todo.notes.isNotEmpty)
                        Text(
                          todo.notes,
                          maxLines: 1,
                          overflow: .ellipsis,
                          style: context.text.label.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      Wrap(
                        spacing: AppSpacing.md,
                        runSpacing: AppSpacing.xs,
                        crossAxisAlignment: .center,
                        children: [
                          CategoryTag(category: todo.category),
                          if (todo.dueAt case final due?)
                            DueLabel(dueAt: due, overdue: todo.isOverdue()),
                          if (todo.subtasks.isNotEmpty)
                            SubtaskCount(todo: todo),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
