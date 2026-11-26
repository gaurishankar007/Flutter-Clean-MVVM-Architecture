import 'package:clean_architecture/domain/models/subtask.dart';
import 'package:clean_architecture/domain/models/todo_category.dart';
import 'package:clean_architecture/domain/models/todo_priority.dart';
import 'package:clean_architecture/domain/models/todo_query.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../testing/helpers/fixtures.dart';

void main() {
  final overdue = testTodo(
    id: 'overdue',
    title: 'Pay rent',
    dueAt: DateTime(2025, 11, 20),
  );
  final today = testTodo(
    id: 'today',
    title: 'Gym',
    dueAt: DateTime(2025, 11, 26, 18),
  );
  final upcoming = testTodo(
    id: 'upcoming',
    title: 'Trip',
    dueAt: DateTime(2025, 12, 2),
  );
  final noDate = testTodo(
    id: 'none',
    title: 'Read',
    subtasks: const [Subtask(id: 's', title: 'Chapter on milk')],
  );
  final done = testTodo(id: 'done', title: 'Call mom', isCompleted: true);
  final all = [noDate, upcoming, done, today, overdue];

  List<String> ids(TodoQuery query) =>
      query.apply(all, now: testNow).map((t) => t.id).toList();

  test('filters by due state', () {
    expect(ids(const TodoQuery(filter: TodoFilter.today)), ['today']);
    expect(ids(const TodoQuery(filter: TodoFilter.upcoming)), ['upcoming']);
    expect(ids(const TodoQuery(filter: TodoFilter.overdue)), ['overdue']);
    expect(ids(const TodoQuery(filter: TodoFilter.completed)), ['done']);
  });

  test('sorts by due date, dated tasks first', () {
    expect(ids(const TodoQuery()).take(3), ['overdue', 'today', 'upcoming']);
  });

  test('sorts by priority, highest first', () {
    final high = testTodo(id: 'high').copyWith(priority: TodoPriority.high);
    final low = testTodo(id: 'low').copyWith(priority: TodoPriority.low);

    final sorted = const TodoQuery(sort: TodoSort.priority).apply([low, high]);

    expect(sorted.map((t) => t.id), ['high', 'low']);
  });

  test('searches titles and subtasks', () {
    expect(ids(const TodoQuery(search: 'MILK')), ['none']);
    expect(ids(const TodoQuery(search: 'gym')), ['today']);
  });

  test('filters by category', () {
    final work = testTodo(id: 'work').copyWith(category: TodoCategory.work);

    final result = const TodoQuery(category: TodoCategory.work)
        .apply([work, today]);

    expect(result.map((t) => t.id), ['work']);
  });
}
