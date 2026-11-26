import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/routing/routes.gr.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/gradient_button.dart';
import 'package:clean_architecture/ui/core/ui/base/states/empty_state.dart';
import 'package:clean_architecture/ui/core/ui/base/states/error_state.dart';
import 'package:clean_architecture/ui/features/todos/providers/todos/todos_notifier.dart';
import 'package:clean_architecture/ui/features/todos/views/todos/widgets/todo_list_section.dart';
import 'package:clean_architecture/ui/features/todos/views/todos/widgets/todo_list_skeleton.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// The grouped list, or its loading, error and empty states.
class const TodoListBody({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(todosProvider);
    if (state.status == .loading) {
      return const TodoListSkeleton();
    }
    if (state.status == .error && state.todos.isEmpty) {
      return ErrorState(
        message: state.errorText ?? CommonMessages.genericError,
        onRetry: ref.read(todosProvider.notifier).sync,
      );
    }
    if (state.todos.isEmpty) {
      return EmptyState(
        icon: Symbols.task_alt_rounded,
        title: TodoMessages.emptyTitle,
        body: TodoMessages.emptyBody,
        action: GradientButton(
          label: TodoMessages.newTask,
          icon: Symbols.add_rounded,
          onPressed: () => context.router.push(TodoEditorRoute()),
        ),
      );
    }
    final sections = state.sections;
    if (sections.isEmpty) {
      return const EmptyState(
        icon: Symbols.search_off_rounded,
        title: TodoMessages.noMatchesTitle,
        body: TodoMessages.noMatchesBody,
      );
    }
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        for (final section in sections) TodoListSection(section: section),
      ],
    );
  }
}
