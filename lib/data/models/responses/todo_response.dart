import 'package:clean_architecture/core/data/models/domain_convertible.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/domain/models/todo_category.dart';
import 'package:clean_architecture/domain/models/todo_priority.dart';

final class const TodoResponse({
  required final int id,
  required final String todo,
  required final bool completed,
  required final int userId,
}) implements DomainConvertible<Todo> {
  factory fromJson(JsonMap json) => TodoResponse(
    id: json['id'] as int,
    todo: json['todo'] as String? ?? '',
    completed: json['completed'] as bool? ?? false,
    userId: json['userId'] as int? ?? 0,
  );

  /// The local id of an imported task, so a re-sync updates the same row.
  static String localIdOf(int remoteId) => 'remote-$remoteId';

  // The demo API has only a title and a done flag. Spread priority, category
  // and due dates by id so the sample list shows every state.
  @override
  Todo toDomain() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dayOffset = id % 7 - 2;
    return Todo(
      id: localIdOf(id),
      remoteId: id,
      title: todo,
      isCompleted: completed,
      completedAt: completed ? now : null,
      priority: TodoPriority.values[id % TodoPriority.values.length],
      category: TodoCategory.values[id % TodoCategory.values.length],
      dueAt: id % 5 == 0 ? null : today.add(Duration(days: dayOffset)),
      createdAt: now,
      updatedAt: now,
    );
  }
}
