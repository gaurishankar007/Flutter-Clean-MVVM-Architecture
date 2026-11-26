import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/routing/routes.gr.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/gradient_button.dart';
import 'package:clean_architecture/ui/core/ui/base/dialog/confirm_dialog.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_back_button.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_header.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_scroll_view.dart';
import 'package:clean_architecture/ui/core/ui/base/states/shimmer_box.dart';
import 'package:clean_architecture/ui/core/utils/extensions/ref_extension.dart';
import 'package:clean_architecture/ui/core/utils/toast_util.dart';
import 'package:clean_architecture/ui/features/todos/providers/todo_editor/todo_editor_notifier.dart';
import 'package:clean_architecture/ui/features/todos/views/todo_editor/widgets/category_picker.dart';
import 'package:clean_architecture/ui/features/todos/views/todo_editor/widgets/due_date_picker.dart';
import 'package:clean_architecture/ui/features/todos/views/todo_editor/widgets/priority_picker.dart';
import 'package:clean_architecture/ui/features/todos/views/todo_editor/widgets/subtasks_editor.dart';
import 'package:clean_architecture/ui/features/todos/views/todo_editor/widgets/todo_text_fields.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// Creates a task, or edits one when [todoId] is set.
@RoutePage()
class const TodoEditorScreen({
  super.key,
  @QueryParam('id') final String? todoId,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = todoEditorProvider(todoId);
    ref.listenMessages(provider, context);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);

    Future<void> save() async {
      final router = context.router;
      final savedId = await notifier.save();
      if (savedId == null || !context.mounted) {
        return;
      }
      ToastUtil.showSuccess(
        context,
        state.isNew ? TodoMessages.created_ : TodoMessages.saved,
      );
      // A new task opens its detail; an edit returns to where it came from.
      if (state.isNew) {
        await router.replace(TodoDetailRoute(todoId: savedId));
      } else {
        await router.maybePop();
      }
    }

    Future<void> confirmDiscard() async {
      final discard = await showConfirmDialog(
        context,
        title: TodoMessages.discardTitle,
        body: TodoMessages.discardBody,
        confirmLabel: TodoMessages.discard,
        destructive: true,
      );
      if (discard && context.mounted) {
        Navigator.of(context).pop();
      }
    }

    return PopScope(
      canPop: !state.hasChanges,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          confirmDiscard();
        }
      },
      child: Scaffold(
        body: ScreenScrollView(
          bottomAction: GradientButton(
            label: CommonMessages.save,
            icon: Symbols.check_rounded,
            expand: true,
            onPressed: state.status == .loaded && !state.isSaving ? save : null,
          ),
          children: [
            const ScreenBackButton(),
            ScreenHeader(
              title: todoId == null
                  ? TodoMessages.newTask
                  : TodoMessages.editTask,
            ),
            if (state.status == .loading)
              const ShimmerBox(height: 200)
            else ...[
              TodoTextFields(todoId: todoId),
              PriorityPicker(
                selected: state.priority,
                onSelected: notifier.setPriority,
              ),
              CategoryPicker(
                selected: state.category,
                onSelected: notifier.setCategory,
              ),
              DueDatePicker(todoId: todoId),
              SubtasksEditor(todoId: todoId),
            ],
          ],
        ),
      ),
    );
  }
}
