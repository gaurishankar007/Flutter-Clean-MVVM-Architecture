import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/features/todos/widgets/category_tag.dart';
import 'package:clean_architecture/ui/features/todos/widgets/due_label.dart';
import 'package:clean_architecture/ui/features/todos/widgets/priority_tag.dart';
import 'package:material_ui/material_ui.dart';

/// Title and tags.
class const TodoDetailHeader({super.key, required final Todo todo})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .only(top: AppSpacing.lg, bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: .start,
        spacing: AppSpacing.md,
        children: [
          Text(
            todo.title,
            style: context.text.screenTitle.copyWith(
              decoration: todo.isCompleted ? .lineThrough : null,
              color: todo.isCompleted ? context.colors.textMuted : null,
            ),
          ),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            crossAxisAlignment: .center,
            children: [
              PriorityTag(priority: todo.priority),
              CategoryTag(category: todo.category),
              if (todo.dueAt case final due?)
                DueLabel(dueAt: due, overdue: todo.isOverdue()),
            ],
          ),
        ],
      ),
    );
  }
}
