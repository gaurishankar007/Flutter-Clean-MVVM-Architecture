import 'package:clean_architecture/domain/models/todo.dart';

enum TodoSectionKind { overdue, today, upcoming, noDate, completed }

/// A titled group of tasks in the list.
typedef TodoSection = ({TodoSectionKind kind, List<Todo> todos});

/// Groups already-filtered, already-sorted [todos] into sections, keeping
/// their order inside each section and dropping empty ones.
List<TodoSection> groupTodos(List<Todo> todos, {DateTime? now}) {
  final current = now ?? DateTime.now();
  final groups = {for (final kind in TodoSectionKind.values) kind: <Todo>[]};
  for (final todo in todos) {
    final kind = switch (todo) {
      _ when todo.isCompleted => TodoSectionKind.completed,
      _ when todo.isOverdue(current) => TodoSectionKind.overdue,
      _ when todo.isDueToday(current) => TodoSectionKind.today,
      Todo(dueAt: null) => TodoSectionKind.noDate,
      _ => TodoSectionKind.upcoming,
    };
    groups[kind]!.add(todo);
  }
  return [
    for (final MapEntry(:key, :value) in groups.entries)
      if (value.isNotEmpty) (kind: key, todos: value),
  ];
}
