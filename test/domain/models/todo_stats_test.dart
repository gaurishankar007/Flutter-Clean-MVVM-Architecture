import 'package:clean_architecture/domain/models/todo_stats.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../testing/helpers/fixtures.dart';

void main() {
  test('counts totals, today and overdue', () {
    final stats = TodoStats.from([
      testTodo(id: 'a', dueAt: DateTime(2025, 11, 26)),
      testTodo(id: 'b', dueAt: DateTime(2025, 11, 26), isCompleted: true),
      testTodo(id: 'c', dueAt: DateTime(2025, 11, 24)),
      testTodo(id: 'd'),
    ], now: testNow);

    expect(stats.total, 4);
    expect(stats.completed, 1);
    expect(stats.open, 3);
    expect(stats.dueToday, 2);
    expect(stats.doneToday, 1);
    expect(stats.todayProgress, 0.5);
    expect(stats.overdue, 1);
  });
}
