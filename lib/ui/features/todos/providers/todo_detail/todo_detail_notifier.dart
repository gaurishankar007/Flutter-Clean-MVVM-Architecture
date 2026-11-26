import 'dart:async';

import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/repositories/todo_repository.dart';
import 'package:clean_architecture/domain/use_cases/set_todo_completed_use_case.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';
import 'package:clean_architecture/ui/features/todos/providers/todo_detail/todo_detail_state.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// One task, live: edits from the editor show up here at once.
class TodoDetailNotifier(final String todoId)
    extends BaseNotifier<TodoDetailState> {
  late final TodoRepository _repository;

  @override
  TodoDetailState build() {
    _repository = GetIt.I<TodoRepository>();
    final subscription = _repository
        .watchTodo(todoId)
        .listen(
          (result) => runFlow('todoDetail.watch', () {
            state = switch (result) {
              SuccessState(:final data?) => state.copyWith(
                status: .loaded,
                todo: data,
              ),
              SuccessState() => const TodoDetailState(
                status: .error,
                errorText: TodoMessages.notFound,
              ),
              _ => state.copyWith(
                status: .error,
                errorText: trackFailure(result).text,
              ),
            };
          }),
        );
    ref.onDispose(() => unawaited(subscription.cancel()));
    return const TodoDetailState();
  }

  Future<void> toggleCompleted() => runFlow('todoDetail.toggle', () async {
    final todo = state.todo;
    if (todo == null) {
      return;
    }
    final result = await GetIt.I<SetTodoCompletedUseCase>()((
      todo: todo,
      completed: !todo.isCompleted,
    ));
    if (!ref.mounted) {
      return;
    }
    state = state.copyWith(
      message: switch (result) {
        SuccessState(:final data?) when data.isCompleted =>
          const SuccessMessage(TodoMessages.completed),
        SuccessState() => const NormalMessage(TodoMessages.reopened),
        _ => trackFailure(result),
      },
    );
  });

  Future<void> toggleSubtask(String subtaskId) =>
      runFlow('todoDetail.toggleSubtask', () async {
        final todo = state.todo;
        if (todo == null) {
          return;
        }
        final updated = todo.copyWith(
          subtasks: [
            for (final subtask in todo.subtasks)
              if (subtask.id == subtaskId)
                subtask.copyWith(isDone: !subtask.isDone)
              else
                subtask,
          ],
          updatedAt: DateTime.now(),
        );
        final result = await _repository.save(updated);
        if (ref.mounted && result is FailureState) {
          state = state.copyWith(message: trackFailure(result));
        }
      });

  /// Returns true once deleted; the View confirms it and closes the screen.
  Future<bool> delete() => runFlow('todoDetail.delete', () async {
    final result = await _repository.delete(todoId);
    if (!ref.mounted) {
      return result is SuccessState;
    }
    if (result is SuccessState) {
      return true;
    }
    state = state.copyWith(message: trackFailure(result));
    return false;
  });
}

final todoDetailProvider = NotifierProvider.autoDispose
    .family<TodoDetailNotifier, TodoDetailState, String>(
      TodoDetailNotifier.new,
    );
