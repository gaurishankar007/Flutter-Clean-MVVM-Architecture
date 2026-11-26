import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/ui/base/form/app_text_field.dart';
import 'package:clean_architecture/ui/features/todos/providers/todo_editor/todo_editor_notifier.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// Title and notes, seeded once from the loaded task.
class const TodoTextFields({super.key, final String? todoId})
    extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = todoEditorProvider(todoId);
    final notifier = ref.read(provider.notifier);
    final initial = ref.read(provider);
    final title = useTextEditingController(text: initial.title);
    final notes = useTextEditingController(text: initial.notes);
    final titleError = ref.watch(provider.select((state) => state.titleError));

    return Column(
      crossAxisAlignment: .stretch,
      spacing: AppSpacing.lg,
      children: [
        AppTextField(
          controller: title,
          label: TodoMessages.titleLabel,
          hint: TodoMessages.titleHint,
          errorText: titleError,
          autofocus: todoId == null,
          maxLength: TodoEditorNotifier.maxTitleLength,
          textCapitalization: .sentences,
          textInputAction: .next,
          onChanged: notifier.setTitle,
        ),
        AppTextField(
          controller: notes,
          label: TodoMessages.notesLabel,
          hint: TodoMessages.notesHint,
          minLines: 3,
          maxLines: 8,
          keyboardType: .multiline,
          textCapitalization: .sentences,
          onChanged: notifier.setNotes,
        ),
      ],
    );
  }
}
