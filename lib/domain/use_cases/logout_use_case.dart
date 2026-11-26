import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/core/utils/use_case.dart';
import 'package:clean_architecture/domain/repositories/auth_repository.dart';
import 'package:clean_architecture/domain/repositories/notification_repository.dart';
import 'package:clean_architecture/domain/repositories/todo_repository.dart';
import 'package:injectable/injectable.dart';

/// Ends the session and removes the user's data from this device, so the
/// next account starts clean.
@injectable
class LogoutUseCase({
  required final AuthRepository _auth,
  required final TodoRepository _todos,
  required final NotificationRepository _notifications,
}) implements UseCase0<void> {
  @override
  FutureVoid call() async {
    final results = await (
      _todos.clearAll(),
      _notifications.clearAll(),
      _auth.logout(),
    ).wait;
    return switch (results) {
      (final FailureState<void> failure, _, _) ||
      (_, final FailureState<void> failure, _) ||
      (_, _, final FailureState<void> failure) => failure,
      _ => const SuccessState.nil(),
    };
  }
}
