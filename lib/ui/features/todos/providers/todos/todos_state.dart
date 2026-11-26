import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/domain/models/todo_query.dart';
import 'package:clean_architecture/domain/models/todo_stats.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';
import 'package:clean_architecture/ui/features/todos/models/todo_section.dart';

final class const TodosState({
  super.status = .loading,
  super.message,
  final List<Todo> todos = const [],
  final TodoQuery query = const TodoQuery(),
  final bool isSyncing = false,
  final String? errorText,
}) extends BaseState {
  TodoStats get stats => TodoStats.from(todos);

  /// The tasks matching [query], grouped for the list.
  List<TodoSection> get sections => groupTodos(query.apply(todos));

  TodosState copyWith({
    StateStatus? status,
    StateMessage? message,
    List<Todo>? todos,
    TodoQuery? query,
    bool? isSyncing,
    String? errorText,
  }) => TodosState(
    status: status ?? this.status,
    // Never keep the previous message: each one is shown once.
    message: message,
    todos: todos ?? this.todos,
    query: query ?? this.query,
    isSyncing: isSyncing ?? this.isSyncing,
    errorText: errorText ?? this.errorText,
  );

  @override
  List<Object?> get props => [
    ...super.props,
    todos,
    query,
    isSyncing,
    errorText,
  ];
}
