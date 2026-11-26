import 'dart:async';

import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/domain/models/todo_category.dart';
import 'package:clean_architecture/domain/models/todo_query.dart';
import 'package:clean_architecture/domain/repositories/todo_repository.dart';
import 'package:clean_architecture/domain/use_cases/set_todo_completed_use_case.dart';
import 'package:clean_architecture/domain/use_cases/sync_todos_use_case.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';
import 'package:clean_architecture/ui/features/todos/providers/todos/todos_state.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// The task list (keep-alive): watches the local table, holds the query and
/// syncs with the server on start and pull-to-refresh.
class TodosNotifier extends BaseNotifier<TodosState> {
  late final TodoRepository _repository;

  @override
  TodosState build() {
    _repository = GetIt.I<TodoRepository>();
    final subscription = _repository.watchTodos().listen(_onTodos);
    ref.onDispose(() => unawaited(subscription.cancel()));
    unawaited(Future.microtask(() => sync(silent: true)));
    return const TodosState();
  }

  void _onTodos(DataState<List<Todo>> result) => runFlow('todos.watch', () {
    state = switch (result) {
      SuccessState(:final data?) => state.copyWith(
        status: .loaded,
        todos: data,
      ),
      _ => state.copyWith(status: .error, errorText: trackFailure(result).text),
    };
  });

  /// Pulls the server's tasks. [silent] skips the "up to date" toast and the
  /// offline warning (the banner already shows it).
  Future<void> sync({bool silent = false}) => runFlow('todos.sync', () async {
    if (state.isSyncing) {
      return;
    }
    state = state.copyWith(isSyncing: true);
    final result = await GetIt.I<SyncTodosUseCase>()();
    if (!ref.mounted) {
      return;
    }
    state = state.copyWith(
      isSyncing: false,
      message: switch (result) {
        SuccessState(:final data?) when !silent || data > 0 => SuccessMessage(
          TodoMessages.synced(data),
        ),
        SuccessState() => null,
        FailureState(origin: .remote) when silent => null,
        FailureState(origin: .remote, error: CommonMessages.noInternet) =>
          const WarningMessage(TodoMessages.offlineSync),
        _ => trackFailure(result),
      },
    );
  });

  void setFilter(TodoFilter filter) =>
      state = state.copyWith(query: state.query.copyWith(filter: filter));

  void setSort(TodoSort sort) =>
      state = state.copyWith(query: state.query.copyWith(sort: sort));

  void setSearch(String search) =>
      state = state.copyWith(query: state.query.copyWith(search: search));

  /// Selecting the active category again clears it.
  void toggleCategory(TodoCategory category) => state = state.copyWith(
    query: state.query.category == category
        ? state.query.copyWith(clearCategory: true)
        : state.query.copyWith(category: category),
  );

  Future<void> setCompleted(Todo todo, bool completed) =>
      runFlow('todos.setCompleted', () async {
        final result = await GetIt.I<SetTodoCompletedUseCase>()((
          todo: todo,
          completed: completed,
        ));
        if (!ref.mounted) {
          return;
        }
        state = state.copyWith(
          message: switch (result) {
            SuccessState() when completed => const SuccessMessage(
              TodoMessages.completed,
            ),
            SuccessState() => const NormalMessage(TodoMessages.reopened),
            _ => trackFailure(result),
          },
        );
      });

  Future<void> delete(Todo todo) => runFlow('todos.delete', () async {
    final result = await _repository.delete(todo.id);
    if (!ref.mounted) {
      return;
    }
    state = state.copyWith(
      message: result is SuccessState
          ? const SuccessMessage(TodoMessages.deleted)
          : trackFailure(result),
    );
  });
}

final todosProvider = NotifierProvider(TodosNotifier.new);
