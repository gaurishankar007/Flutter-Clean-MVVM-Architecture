import 'package:clean_architecture/core/clients/database/app_database.dart';
import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/data/models/mappers/todo_mapper.dart';
import 'package:clean_architecture/data/models/responses/todo_response.dart';
import 'package:clean_architecture/data/repositories/todo_repository_impl.dart';
import 'package:clean_architecture/domain/models/todo_priority.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/helpers/fixtures.dart';
import '../../../testing/mocks/client_mocks.dart';
import '../../../testing/mocks/service_mocks.dart';

TodoLocalData _row(TodoLocalCompanion c) => TodoLocalData(
  id: c.id.value,
  remoteId: c.remoteId.value,
  title: c.title.value,
  notes: c.notes.value,
  isCompleted: c.isCompleted.value,
  priority: c.priority.value,
  category: c.category.value,
  dueAt: c.dueAt.value,
  completedAt: c.completedAt.value,
  subtasks: c.subtasks.value,
  createdAt: c.createdAt.value,
  updatedAt: c.updatedAt.value,
);

void main() {
  late MockTodoLocalService local;
  late MockTodoApiService api;
  late MockConnectivityClient connectivity;
  late TodoRepositoryImpl repository;

  setUpAll(() => registerFallbackValue(<TodoLocalCompanion>[]));

  setUp(() {
    local = MockTodoLocalService();
    api = MockTodoApiService();
    connectivity = MockConnectivityClient();
    repository = TodoRepositoryImpl(
      local: local,
      api: api,
      connectivity: connectivity,
    );
    when(() => connectivity.isConnected).thenReturn(true);
    when(() => local.upsertAll(any()))
        .thenAnswer((_) async => const SuccessState.nil());
  });

  test('sync offline fails without calling the API', () async {
    when(() => connectivity.isConnected).thenReturn(false);

    final result = await repository.sync();

    expect(result, isA<FailureState<int>>());
    verifyNever(() => api.todos());
  });

  test('sync imports new tasks and updates server fields only', () async {
    final known = testTodo(
      id: TodoResponse.localIdOf(1),
      remoteId: 1,
      title: 'Old title',
    ).copyWith(priority: TodoPriority.high, notes: 'my notes');
    when(() => api.todos()).thenAnswer(
      (_) async => const SuccessState(
        data: [
          TodoResponse(id: 1, todo: 'New title', completed: true, userId: 1),
          TodoResponse(id: 2, todo: 'Brand new', completed: false, userId: 1),
        ],
      ),
    );
    when(
      () => local.getAll(),
    ).thenAnswer((_) async => SuccessState(data: [_row(known.toCompanion())]));

    final result = await repository.sync();

    expect(result.data, 2);
    final saved =
        verify(() => local.upsertAll(captureAny())).captured.single
            as List<TodoLocalCompanion>;
    final updated = _row(saved.first).toDomain();
    expect(updated.title, 'New title');
    expect(updated.isCompleted, isTrue);
    expect(updated.notes, 'my notes');
    expect(updated.priority, TodoPriority.high);
    expect(saved.last.title.value, 'Brand new');
  });

  test('sync with nothing changed writes nothing', () async {
    final known = testTodo(
      id: TodoResponse.localIdOf(1),
      remoteId: 1,
      title: 'Same',
    );
    when(() => api.todos()).thenAnswer(
      (_) async => const SuccessState(
        data: [TodoResponse(id: 1, todo: 'Same', completed: false, userId: 1)],
      ),
    );
    when(
      () => local.getAll(),
    ).thenAnswer((_) async => SuccessState(data: [_row(known.toCompanion())]));

    final result = await repository.sync();

    expect(result.data, 0);
    verifyNever(() => local.upsertAll(any()));
  });
}
