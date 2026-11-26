import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/core/utils/use_case.dart';
import 'package:clean_architecture/domain/models/app_notification.dart';
import 'package:clean_architecture/domain/models/user.dart';
import 'package:clean_architecture/domain/repositories/auth_repository.dart';
import 'package:clean_architecture/domain/repositories/notification_repository.dart';
import 'package:clean_architecture/domain/use_cases/sync_todos_use_case.dart';
import 'package:injectable/injectable.dart';

typedef LoginParams = ({String username, String password});

/// Logs in, then imports the user's tasks and adds a welcome notification.
/// A failed sync doesn't fail the login: the list can be refreshed later.
@injectable
class LoginUseCase({
  required final AuthRepository _auth,
  required final NotificationRepository _notifications,
  required final SyncTodosUseCase _syncTodos,
}) implements UseCase1<User, LoginParams> {
  @override
  FutureData<User> call(LoginParams params) async {
    final result = await _auth.login(
      username: params.username,
      password: params.password,
    );
    if (result is! SuccessState) {
      return result;
    }
    await _syncTodos();
    await _notifications.add(
      AppNotification(
        id: 'welcome',
        type: .welcome,
        title: NotificationMessages.welcomeTitle,
        body: NotificationMessages.welcomeBody,
        createdAt: DateTime.now(),
      ),
    );
    return result;
  }
}
