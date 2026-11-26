import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/gradient_button.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/tonal_button.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_scroll_view.dart';
import 'package:clean_architecture/ui/core/ui/base/states/error_state.dart';
import 'package:clean_architecture/ui/core/ui/base/states/shimmer_box.dart';
import 'package:clean_architecture/ui/core/utils/extensions/ref_extension.dart';
import 'package:clean_architecture/ui/features/todos/providers/todo_detail/todo_detail_notifier.dart';
import 'package:clean_architecture/ui/features/todos/views/todo_detail/widgets/todo_detail_header.dart';
import 'package:clean_architecture/ui/features/todos/views/todo_detail/widgets/todo_detail_top_bar.dart';
import 'package:clean_architecture/ui/features/todos/views/todo_detail/widgets/todo_info_card.dart';
import 'package:clean_architecture/ui/features/todos/views/todo_detail/widgets/todo_notes_card.dart';
import 'package:clean_architecture/ui/features/todos/views/todo_detail/widgets/todo_subtasks_card.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

@RoutePage()
class const TodoDetailScreen({
  super.key,
  @PathParam('todoId') required final String todoId,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = todoDetailProvider(todoId);
    ref.listenMessages(provider, context);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final todo = state.todo;

    return Scaffold(
      body: ScreenScrollView(
        bottomAction: todo == null
            ? null
            : todo.isCompleted
            ? TonalButton(
                label: TodoMessages.markNotDone,
                icon: Symbols.undo_rounded,
                expand: true,
                onPressed: notifier.toggleCompleted,
              )
            : GradientButton(
                label: TodoMessages.markDone,
                icon: Symbols.check_rounded,
                expand: true,
                onPressed: notifier.toggleCompleted,
              ),
        children: [
          TodoDetailTopBar(todoId: todoId, canEdit: todo != null),
          ...switch ((state.status, todo)) {
            (_, final todo?) => [
              TodoDetailHeader(todo: todo),
              TodoNotesCard(notes: todo.notes),
              TodoSubtasksCard(todo: todo, onToggle: notifier.toggleSubtask),
              TodoInfoCard(todo: todo),
            ],
            (.error, _) => [
              ErrorState(
                message: state.errorText ?? CommonMessages.genericError,
              ),
            ],
            _ => const [SizedBox(height: 24), ShimmerBox(height: 120)],
          },
        ],
      ),
    );
  }
}
