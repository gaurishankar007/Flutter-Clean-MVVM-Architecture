import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/domain/models/todo.dart';

abstract interface class TodoRepository {
  /// Every task on this device, as it changes.
  StreamData<List<Todo>> watchTodos();

  /// One task as it changes; null data once it's deleted.
  StreamData<Todo?> watchTodo(String id);

  FutureData<Todo?> getTodo(String id);

  /// Inserts or updates [todo].
  FutureData<Todo> save(Todo todo);

  FutureVoid delete(String id);

  /// Deletes every completed task; returns how many.
  FutureData<int> clearCompleted();

  /// Deletes every task (logout).
  FutureVoid clearAll();

  /// Imports tasks from the server; returns how many were new or changed.
  /// Local edits win for fields the server doesn't have.
  FutureData<int> sync();
}
