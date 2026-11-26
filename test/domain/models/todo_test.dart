import 'package:clean_architecture/domain/models/subtask.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../testing/helpers/fixtures.dart';

void main() {
  group('Todo', () {
    test('an all-day task is overdue only after its day', () {
      final today = testTodo(dueAt: DateTime(2025, 11, 26));
      final yesterday = testTodo(dueAt: DateTime(2025, 11, 25));

      expect(today.isOverdue(testNow), isFalse);
      expect(yesterday.isOverdue(testNow), isTrue);
    });

    test('a timed task is overdue once its time passed', () {
      final earlier = testTodo(dueAt: DateTime(2025, 11, 26, 9));
      final later = testTodo(dueAt: DateTime(2025, 11, 26, 11, 30));

      expect(earlier.isOverdue(testNow), isTrue);
      expect(later.isOverdue(testNow), isFalse);
    });

    test('a completed task is never overdue', () {
      final done = testTodo(isCompleted: true, dueAt: DateTime(2025, 2, 3));

      expect(done.isOverdue(testNow), isFalse);
    });

    test('progress counts done subtasks', () {
      final todo = testTodo(
        subtasks: const [
          Subtask(id: 'a', title: 'A', isDone: true),
          Subtask(id: 'b', title: 'B'),
        ],
      );

      expect(todo.progress, 0.5);
      expect(todo.completedSubtasks, 1);
    });

    test('copyWith can clear the due date', () {
      final todo = testTodo(dueAt: testNow).copyWith(clearDueAt: true);

      expect(todo.dueAt, isNull);
    });
  });
}
