import 'package:clean_architecture/domain/models/todo.dart';
import 'package:equatable/equatable.dart';

/// Counts for the progress card and the profile.
final class const TodoStats({
  final int total = 0,
  final int completed = 0,
  final int dueToday = 0,
  final int doneToday = 0,
  final int overdue = 0,
}) extends Equatable {
  factory from(List<Todo> todos, {DateTime? now}) {
    final current = now ?? DateTime.now();
    final today = todos.where((t) => t.isDueToday(current));
    return TodoStats(
      total: todos.length,
      completed: todos.where((t) => t.isCompleted).length,
      dueToday: today.length,
      doneToday: today.where((t) => t.isCompleted).length,
      overdue: todos.where((t) => t.isOverdue(current)).length,
    );
  }

  int get open => total - completed;

  /// Share of today's tasks that are done; 0 when nothing is due today.
  double get todayProgress => dueToday == 0 ? 0 : doneToday / dueToday;

  @override
  List<Object?> get props => [total, completed, dueToday, doneToday, overdue];
}
