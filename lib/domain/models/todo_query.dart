import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/domain/models/todo_category.dart';
import 'package:equatable/equatable.dart';

enum TodoFilter { all, today, upcoming, overdue, completed }

enum TodoSort { dueDate, priority, newest }

/// What the task list shows: a filter, an optional category, a search text
/// and an order.
final class const TodoQuery({
  final TodoFilter filter = .all,
  final TodoSort sort = .dueDate,
  final String search = '',
  final TodoCategory? category,
}) extends Equatable {
  bool get isDefault => filter == .all && search.isEmpty && category == null;

  /// The tasks matching this query, in its order.
  List<Todo> apply(List<Todo> todos, {DateTime? now}) {
    final current = now ?? DateTime.now();
    final text = search.trim().toLowerCase();
    final matches = todos.where((todo) {
      final byFilter = switch (filter) {
        .all => true,
        .today => !todo.isCompleted && todo.isDueToday(current),
        .upcoming =>
          !todo.isCompleted &&
              todo.dueAt != null &&
              todo.dueAt!.isAfter(current) &&
              !todo.isDueToday(current),
        .overdue => todo.isOverdue(current),
        .completed => todo.isCompleted,
      };
      final byCategory = category == null || todo.category == category;
      final bySearch =
          text.isEmpty ||
          todo.title.toLowerCase().contains(text) ||
          todo.notes.toLowerCase().contains(text) ||
          todo.subtasks.any((s) => s.title.toLowerCase().contains(text));
      return byFilter && byCategory && bySearch;
    }).toList();
    return matches..sort(_compare);
  }

  int _compare(Todo a, Todo b) => switch (sort) {
    .dueDate => _compareDue(a, b),
    .priority =>
      b.priority.index.compareTo(a.priority.index) != 0
          ? b.priority.index.compareTo(a.priority.index)
          : _compareDue(a, b),
    .newest => b.createdAt.compareTo(a.createdAt),
  };

  // Dated tasks first, soonest first; then undated, newest first.
  static int _compareDue(Todo a, Todo b) => switch ((a.dueAt, b.dueAt)) {
    (final aDue?, final bDue?) => aDue.compareTo(bDue),
    (_?, null) => -1,
    (null, _?) => 1,
    (null, null) => b.createdAt.compareTo(a.createdAt),
  };

  TodoQuery copyWith({
    TodoFilter? filter,
    TodoSort? sort,
    String? search,
    TodoCategory? category,
    bool clearCategory = false,
  }) => TodoQuery(
    filter: filter ?? this.filter,
    sort: sort ?? this.sort,
    search: search ?? this.search,
    category: clearCategory ? null : category ?? this.category,
  );

  @override
  List<Object?> get props => [filter, sort, search, category];
}
