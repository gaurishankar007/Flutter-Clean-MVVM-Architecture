import 'package:clean_architecture/ui/features/todos/models/todo_section.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../testing/helpers/fixtures.dart';

void main() {
  test('groups tasks into sections, dropping empty ones', () {
    final sections = groupTodos([
      testTodo(id: 'overdue', dueAt: DateTime(2025, 11, 20)),
      testTodo(id: 'today', dueAt: DateTime(2025, 11, 26)),
      testTodo(id: 'none'),
      testTodo(id: 'done', isCompleted: true),
    ], now: testNow);

    expect(sections.map((s) => s.kind), [
      TodoSectionKind.overdue,
      TodoSectionKind.today,
      TodoSectionKind.noDate,
      TodoSectionKind.completed,
    ]);
  });
}
