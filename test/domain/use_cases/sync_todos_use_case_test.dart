import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/domain/models/app_notification.dart';
import 'package:clean_architecture/domain/models/app_settings.dart';
import 'package:clean_architecture/domain/use_cases/sync_todos_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/helpers/fixtures.dart';
import '../../../testing/mocks/repository_mocks.dart';

void main() {
  late MockTodoRepository todos;
  late MockUserRepository users;
  late MockNotificationRepository notifications;
  late MockSettingsRepository settings;
  late SyncTodosUseCase useCase;

  setUpAll(
    () => registerFallbackValue(
      AppNotification(
        id: '',
        type: NotificationType.welcome,
        title: '',
        body: '',
        createdAt: testNow,
      ),
    ),
  );

  setUp(() {
    todos = MockTodoRepository();
    users = MockUserRepository();
    notifications = MockNotificationRepository();
    settings = MockSettingsRepository();
    useCase = SyncTodosUseCase(
      todos: todos,
      users: users,
      notifications: notifications,
      settings: settings,
    );
    when(() => users.currentUser).thenReturn(testUser);
    when(() => todos.sync())
        .thenAnswer((_) async => const SuccessState(data: 3));
    when(() => notifications.add(any()))
        .thenAnswer((_) async => const SuccessState.nil());
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    when(() => todos.watchTodos()).thenAnswer(
      (_) => Stream.value(
        SuccessState(
          data: [
            testTodo(
              id: 'late',
              dueAt: DateTime(yesterday.year, yesterday.month, yesterday.day),
            ),
            testTodo(id: 'undated'),
          ],
        ),
      ),
    );
  });

  test('syncs and adds a reminder for an overdue task', () async {
    when(() => settings.current).thenReturn(const AppSettings());

    final result = await useCase();

    expect(result.data, 3);
    final added =
        verify(() => notifications.add(captureAny())).captured.single
            as AppNotification;
    expect(added.type, NotificationType.overdue);
    expect(added.todoId, 'late');
  });

  test('adds no reminders when they are turned off', () async {
    when(() => settings.current)
        .thenReturn(const AppSettings(dueReminders: false));

    await useCase();

    verifyNever(() => notifications.add(any()));
  });

  test('fails without a signed-in user', () async {
    when(() => users.currentUser).thenReturn(null);

    final result = await useCase();

    expect(result, isA<FailureState<int>>());
    verifyNever(() => todos.sync());
  });
}
