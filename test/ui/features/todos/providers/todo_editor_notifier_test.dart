import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/domain/models/todo_priority.dart';
import 'package:clean_architecture/domain/repositories/todo_repository.dart';
import 'package:clean_architecture/domain/use_cases/save_todo_use_case.dart';
import 'package:clean_architecture/ui/features/todos/providers/todo_editor/todo_editor_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../testing/helpers/fixtures.dart';
import '../../../../../testing/helpers/test_setup.dart';
import '../../../../../testing/mocks/repository_mocks.dart';
import '../../../../../testing/mocks/use_case_mocks.dart';

void main() {
  late MockSaveTodoUseCase saveTodo;
  late MockTodoRepository repository;
  late ProviderContainer container;

  setUpAll(() => registerFallbackValue((todo: testTodo(), isNew: true)));

  setUp(() {
    registerErrorHandling();
    saveTodo = MockSaveTodoUseCase();
    repository = MockTodoRepository();
    registerMock<SaveTodoUseCase>(saveTodo);
    registerMock<TodoRepository>(repository);
    when(() => saveTodo(any())).thenAnswer(
      (invocation) async => SuccessState(
        data:
            (invocation.positionalArguments.single as ({Todo todo, bool isNew}))
                .todo,
      ),
    );
    container = ProviderContainer.test();
  });

  tearDown(resetDependencies);

  TodoEditorNotifier listen(String? id) {
    container.listen(todoEditorProvider(id), (_, _) {});
    return container.read(todoEditorProvider(id).notifier);
  }

  test('a new task needs a title', () async {
    final notifier = listen(null);

    final savedId = await notifier.save();

    expect(savedId, isNull);
    expect(
      container.read(todoEditorProvider(null)).titleError,
      ValidationMessages.required,
    );
    verifyNever(() => saveTodo(any()));
  });

  test('saves a new task with its subtasks', () async {
    final notifier = listen(null)
      ..setTitle('  Plan trip ')
      ..setPriority(TodoPriority.high)
      ..addSubtask('Book flights')
      ..addSubtask('   ');

    final savedId = await notifier.save();

    expect(savedId, isNotNull);
    final params =
        verify(() => saveTodo(captureAny())).captured.single
            as ({Todo todo, bool isNew});
    expect(params.isNew, isTrue);
    expect(params.todo.title, 'Plan trip');
    expect(params.todo.priority, TodoPriority.high);
    expect(params.todo.subtasks.map((s) => s.title), ['Book flights']);
    expect(container.read(todoEditorProvider(null)).hasChanges, isFalse);
  });

  test('loads an existing task and tracks changes', () async {
    when(() => repository.getTodo('todo-1'))
        .thenAnswer((_) async => SuccessState(data: testTodo()));
    final notifier = listen('todo-1');
    await pumpEventQueue();

    expect(container.read(todoEditorProvider('todo-1')).title, 'Buy milk');
    expect(container.read(todoEditorProvider('todo-1')).hasChanges, isFalse);

    notifier.setTitle('Buy oat milk');

    expect(container.read(todoEditorProvider('todo-1')).hasChanges, isTrue);
  });

  test('a time without a day lands on today', () {
    final notifier = listen(null)..setDueTime(9, 30);

    final dueAt = container.read(todoEditorProvider(null)).dueAt!;
    final now = DateTime.now();
    expect(
      (dueAt.year, dueAt.month, dueAt.day),
      (now.year, now.month, now.day),
    );
    expect((dueAt.hour, dueAt.minute), (9, 30));
    notifier.clearDueDate();
    expect(container.read(todoEditorProvider(null)).dueAt, isNull);
  });
}
