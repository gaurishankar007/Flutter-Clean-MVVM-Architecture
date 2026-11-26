import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/routing/routes.gr.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/dialog/confirm_dialog.dart';
import 'package:clean_architecture/ui/core/ui/base/sheets/action_sheet.dart';
import 'package:clean_architecture/ui/core/ui/base/text/section_header.dart';
import 'package:clean_architecture/ui/features/todos/models/todo_presentation.dart';
import 'package:clean_architecture/ui/features/todos/models/todo_section.dart';
import 'package:clean_architecture/ui/features/todos/providers/todos/todos_notifier.dart';
import 'package:clean_architecture/ui/features/todos/widgets/todo_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// A section title with its count, and its task cards.
class const TodoListSection({super.key, required final TodoSection section})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(todosProvider.notifier);

    Future<void> showActions(Todo todo) => showActionSheet(
      context,
      title: todo.title,
      actions: [
        (
          icon: Symbols.edit_rounded,
          label: CommonMessages.edit,
          destructive: false,
          onTap: () => context.router.push(TodoEditorRoute(todoId: todo.id)),
        ),
        (
          icon: Symbols.delete_rounded,
          label: CommonMessages.delete,
          destructive: true,
          onTap: () async {
            final confirmed = await showConfirmDialog(
              context,
              title: TodoMessages.deleteTitle,
              body: TodoMessages.deleteBody,
              confirmLabel: CommonMessages.delete,
              destructive: true,
            );
            if (confirmed) {
              await notifier.delete(todo);
            }
          },
        ),
      ],
    );

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        SectionHeader(
          title: section.kind.label,
          trailing: Text(
            '${section.todos.length}',
            style: context.text.numeric.copyWith(
              color: context.colors.textMuted,
            ),
          ),
        ),
        for (final (index, todo) in section.todos.indexed) ...[
          if (index > 0) const SizedBox(height: AppSpacing.sm),
          TodoCard(
            key: ValueKey(todo.id),
            todo: todo,
            onTap: () => context.router.push(TodoDetailRoute(todoId: todo.id)),
            onCompletedChanged: (completed) =>
                notifier.setCompleted(todo, completed),
            onLongPress: () => showActions(todo),
          ),
        ],
      ],
    );
  }
}
