import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/core/utils/use_case.dart';
import 'package:clean_architecture/domain/models/app_notification.dart';
import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/domain/repositories/notification_repository.dart';
import 'package:clean_architecture/domain/repositories/todo_repository.dart';
import 'package:injectable/injectable.dart';

typedef SetTodoCompletedParams = ({Todo todo, bool completed});

/// Marks a task done or not done; completing it adds an inbox entry.
@injectable
class SetTodoCompletedUseCase({
  required final TodoRepository _todos,
  required final NotificationRepository _notifications,
}) implements UseCase1<Todo, SetTodoCompletedParams> {
  @override
  FutureData<Todo> call(SetTodoCompletedParams params) async {
    final now = DateTime.now();
    final updated = params.todo.copyWith(
      isCompleted: params.completed,
      completedAt: params.completed ? now : null,
      clearCompletedAt: !params.completed,
      updatedAt: now,
    );
    final result = await _todos.save(updated);
    if (params.completed && result is SuccessState) {
      await _notifications.add(
        AppNotification(
          id: 'completed-${updated.id}-${now.millisecondsSinceEpoch}',
          type: .todoCompleted,
          title: NotificationMessages.completedTitle(updated.title),
          body: NotificationMessages.completedBody,
          todoId: updated.id,
          createdAt: now,
        ),
      );
    }
    return result;
  }
}
