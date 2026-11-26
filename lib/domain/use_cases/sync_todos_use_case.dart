import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/core/utils/use_case.dart';
import 'package:clean_architecture/domain/models/app_notification.dart';
import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/domain/repositories/notification_repository.dart';
import 'package:clean_architecture/domain/repositories/settings_repository.dart';
import 'package:clean_architecture/domain/repositories/todo_repository.dart';
import 'package:clean_architecture/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

/// Imports tasks from the server, then adds inbox reminders for
/// tasks due today or overdue (once per task and day). Returns how many
/// tasks changed. Offline it still adds reminders and returns the failure.
@injectable
class SyncTodosUseCase({
  required final TodoRepository _todos,
  required final UserRepository _users,
  required final NotificationRepository _notifications,
  required final SettingsRepository _settings,
}) implements UseCase0<int> {
  @override
  FutureData<int> call() async {
    if (_users.currentUser == null) {
      return FailureState.tokenExpired();
    }
    final result = await _todos.sync();
    if (_settings.current.dueReminders) {
      await _addReminders();
    }
    return result;
  }

  Future<void> _addReminders() async {
    final todos = await _todos.watchTodos().first;
    final now = DateTime.now();
    final day = '${now.year}${now.month}${now.day}';
    for (final todo in todos.data ?? const <Todo>[]) {
      final notification = switch (todo) {
        _ when todo.isOverdue(now) => AppNotification(
          id: 'overdue-${todo.id}-$day',
          type: .overdue,
          title: NotificationMessages.overdueTitle(todo.title),
          body: NotificationMessages.overdueBody,
          todoId: todo.id,
          createdAt: now,
        ),
        _ when !todo.isCompleted && todo.isDueToday(now) => AppNotification(
          id: 'due-${todo.id}-$day',
          type: .dueToday,
          title: NotificationMessages.dueTodayTitle(todo.title),
          body: NotificationMessages.dueTodayBody,
          todoId: todo.id,
          createdAt: now,
        ),
        _ => null,
      };
      if (notification != null) {
        await _notifications.add(notification);
      }
    }
  }
}
