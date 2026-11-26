import 'package:clean_architecture/core/clients/database/app_database.dart';
import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/errors/error_handler.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:injectable/injectable.dart';

/// Tasks in the `todos` table, as drift rows.
@lazySingleton
class TodoLocalService({required final AppDatabase _database}) {
  $TodoLocalTable get _todos => _database.todoLocal;

  StreamData<List<TodoLocalData>> watchAll() =>
      ErrorHandlerProvider.I.executeStream(
        _database.select(_todos).watch(),
        action: 'todo.local.watchAll',
      );

  StreamData<TodoLocalData?> watch(String id) =>
      ErrorHandlerProvider.I.executeStream(
        (_database.select(
          _todos,
        )..where((t) => t.id.equals(id))).watchSingleOrNull(),
        action: 'todo.local.watch',
      );

  FutureData<TodoLocalData?> get(String id) =>
      ErrorHandlerProvider.I.execute(() async {
        final row = await (_database.select(
          _todos,
        )..where((t) => t.id.equals(id))).getSingleOrNull();
        return SuccessState(data: row, origin: .local);
      }, action: 'todo.local.get');

  FutureData<List<TodoLocalData>> getAll() =>
      ErrorHandlerProvider.I.execute(() async {
        final rows = await _database.select(_todos).get();
        return SuccessState(data: rows, origin: .local);
      }, action: 'todo.local.getAll');

  FutureVoid upsert(TodoLocalCompanion todo) =>
      ErrorHandlerProvider.I.execute(() async {
        await _database.into(_todos).insertOnConflictUpdate(todo);
        return const SuccessState.nil(origin: .local);
      }, action: 'todo.local.upsert');

  FutureVoid upsertAll(List<TodoLocalCompanion> todos) =>
      ErrorHandlerProvider.I.execute(() async {
        await _database.batch(
          (batch) => batch.insertAllOnConflictUpdate(_todos, todos),
        );
        return const SuccessState.nil(origin: .local);
      }, action: 'todo.local.upsertAll');

  FutureVoid delete(String id) => ErrorHandlerProvider.I.execute(() async {
    await (_database.delete(_todos)..where((t) => t.id.equals(id))).go();
    return const SuccessState.nil(origin: .local);
  }, action: 'todo.local.delete');

  FutureData<int> deleteCompleted() => ErrorHandlerProvider.I.execute(() async {
    final count = await (_database.delete(
      _todos,
    )..where((t) => t.isCompleted.equals(true))).go();
    return SuccessState(data: count, origin: .local);
  }, action: 'todo.local.deleteCompleted');

  FutureVoid deleteAll() => ErrorHandlerProvider.I.execute(() async {
    await _database.delete(_todos).go();
    return const SuccessState.nil(origin: .local);
  }, action: 'todo.local.deleteAll');
}
