import 'package:clean_architecture/domain/models/subtask.dart';
import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/domain/models/user.dart';

/// A fixed "now" so date logic is deterministic: Wed 26 Nov 2025, 10:00.
final testNow = DateTime(2025, 11, 26, 10);

const testUser = User(
  id: 1,
  username: 'emilys',
  email: 'emily@example.com',
  firstName: 'Emily',
  lastName: 'Johnson',
);

Todo testTodo({
  String id = 'todo-1',
  String title = 'Buy milk',
  bool isCompleted = false,
  DateTime? dueAt,
  List<Subtask> subtasks = const [],
  int? remoteId,
  DateTime? createdAt,
}) => Todo(
  id: id,
  title: title,
  isCompleted: isCompleted,
  dueAt: dueAt,
  subtasks: subtasks,
  remoteId: remoteId,
  createdAt: createdAt ?? testNow,
  updatedAt: createdAt ?? testNow,
);
