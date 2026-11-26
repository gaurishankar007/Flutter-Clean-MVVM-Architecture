import 'package:clean_architecture/core/clients/remote/connectivity_client.dart';
import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/data/models/mappers/todo_mapper.dart';
import 'package:clean_architecture/data/services/local/todo_local_service.dart';
import 'package:clean_architecture/data/services/remote/todo_api_service.dart';
import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/domain/repositories/todo_repository.dart';
import 'package:injectable/injectable.dart';

/// Offline-first: the local table is the source of truth; [sync] imports
/// the server's tasks into it.
@LazySingleton(as: TodoRepository)
final class TodoRepositoryImpl({
  required final TodoLocalService _local,
  required final TodoApiService _api,
  required final ConnectivityClient _connectivity,
}) implements TodoRepository {
  @override
  StreamData<List<Todo>> watchTodos() => _local.watchAll().map(
    (state) => state.mapData((rows) => rows.map((r) => r.toDomain()).toList()),
  );

  @override
  StreamData<Todo?> watchTodo(String id) =>
      _local.watch(id).map((state) => state.mapData((row) => row?.toDomain()));

  @override
  FutureData<Todo?> getTodo(String id) async =>
      (await _local.get(id)).mapData((row) => row?.toDomain());

  @override
  FutureData<Todo> save(Todo todo) async =>
      (await _local.upsert(todo.toCompanion())).mapData((_) => todo);

  @override
  FutureVoid delete(String id) => _local.delete(id);

  @override
  FutureData<int> clearCompleted() => _local.deleteCompleted();

  @override
  FutureVoid clearAll() => _local.deleteAll();

  @override
  FutureData<int> sync() async {
    if (!_connectivity.isConnected) {
      return FailureState.noInternet(action: 'todo.sync');
    }
    final remote = await _api.todos();
    final local = await _local.getAll();
    if (remote is! SuccessState || local is! SuccessState) {
      return switch ((remote, local)) {
        (final FailureState<dynamic> failure, _) ||
        (_, final FailureState<dynamic> failure) => failure.retype(),
        _ => const FailureState(),
      };
    }

    final existing = {
      for (final row in local.data!)
        if (row.remoteId != null) row.remoteId!: row.toDomain(),
    };
    // New tasks are imported whole; for known ones only the server's own
    // fields (title, done) are updated, so local details survive.
    final changed = <Todo>[];
    for (final response in remote.data!) {
      final imported = response.toDomain();
      final current = existing[response.id];
      if (current == null) {
        changed.add(imported);
      } else if (current.title != imported.title ||
          current.isCompleted != imported.isCompleted) {
        changed.add(
          current.copyWith(
            title: imported.title,
            isCompleted: imported.isCompleted,
            updatedAt: DateTime.now(),
          ),
        );
      }
    }
    if (changed.isEmpty) {
      return const SuccessState(data: 0, origin: .remote);
    }
    final saved = await _local.upsertAll([
      for (final todo in changed) todo.toCompanion(),
    ]);
    return saved.mapData((_) => changed.length);
  }
}
