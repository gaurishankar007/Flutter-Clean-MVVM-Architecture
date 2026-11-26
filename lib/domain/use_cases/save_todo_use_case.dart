import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/core/utils/use_case.dart';
import 'package:clean_architecture/domain/models/app_notification.dart';
import 'package:clean_architecture/domain/models/todo.dart';
import 'package:clean_architecture/domain/repositories/notification_repository.dart';
import 'package:clean_architecture/domain/repositories/todo_repository.dart';
import 'package:injectable/injectable.dart';

typedef SaveTodoParams = ({Todo todo, bool isNew});

/// Saves a task; a new one also gets an inbox entry.
@injectable
class SaveTodoUseCase({
  required final TodoRepository _todos,
  required final NotificationRepository _notifications,
}) implements UseCase1<Todo, SaveTodoParams> {
  @override
  FutureData<Todo> call(SaveTodoParams params) async {
    final result = await _todos.save(params.todo);
    if (params.isNew && result is SuccessState) {
      await _notifications.add(
        AppNotification(
          id: 'created-${params.todo.id}',
          type: .todoCreated,
          title: NotificationMessages.createdTitle(params.todo.title),
          body: NotificationMessages.createdBody,
          todoId: params.todo.id,
          createdAt: DateTime.now(),
        ),
      );
    }
    return result;
  }
}
