import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/form/app_text_field.dart';
import 'package:clean_architecture/ui/core/ui/base/text/section_header.dart';
import 'package:clean_architecture/ui/features/todos/providers/todo_editor/todo_editor_notifier.dart';
import 'package:clean_architecture/ui/features/todos/widgets/subtask_tile.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// The checklist with remove buttons and a field to add items.
class const SubtasksEditor({super.key, final String? todoId})
    extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = todoEditorProvider(todoId);
    final subtasks = ref.watch(provider.select((state) => state.subtasks));
    final notifier = ref.read(provider.notifier);
    final controller = useTextEditingController();
    final focusNode = useFocusNode();

    void add() {
      notifier.addSubtask(controller.text);
      controller.clear();
      focusNode.requestFocus();
    }

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const SectionHeader(title: TodoMessages.subtasks),
        for (final subtask in subtasks)
          SubtaskTile(
            key: ValueKey(subtask.id),
            subtask: subtask,
            onToggle: () => notifier.toggleSubtask(subtask.id),
            onRemove: () => notifier.removeSubtask(subtask.id),
          ),
        const SizedBox(height: AppSpacing.sm),
        AppTextField(
          controller: controller,
          focusNode: focusNode,
          hint: TodoMessages.addSubtask,
          icon: Symbols.add_task_rounded,
          textCapitalization: .sentences,
          textInputAction: .done,
          onSubmitted: (_) => add(),
          trailing: IconButton(
            tooltip: TodoMessages.addSubtask,
            onPressed: add,
            icon: Icon(Symbols.add_rounded, color: context.colors.primaryText),
          ),
        ),
      ],
    );
  }
}
