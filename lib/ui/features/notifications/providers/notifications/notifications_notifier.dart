import 'dart:async';

import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/domain/repositories/notification_repository.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';
import 'package:clean_architecture/ui/features/notifications/providers/notifications/notifications_state.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationsNotifier extends BaseNotifier<NotificationsState> {
  late final NotificationRepository _repository;

  @override
  NotificationsState build() {
    _repository = GetIt.I<NotificationRepository>();
    final subscription = _repository.watchNotifications().listen(
      (result) => runFlow('notifications.watch', () {
        state = switch (result) {
          SuccessState(:final data?) => state.copyWith(
            status: .loaded,
            notifications: data,
          ),
          _ => state.copyWith(
            status: .error,
            errorText: trackFailure(result).text,
          ),
        };
      }),
    );
    ref.onDispose(() => unawaited(subscription.cancel()));
    return const NotificationsState();
  }

  Future<void> markRead(String id) =>
      _run('notifications.markRead', () => _repository.markRead(id));

  Future<void> markAllRead() =>
      _run('notifications.markAllRead', _repository.markAllRead);

  Future<void> clearAll() =>
      _run('notifications.clearAll', _repository.clearAll);

  Future<void> _run(String action, FutureVoid Function() call) =>
      runFlow(action, () async {
        final result = await call();
        if (ref.mounted && result is FailureState) {
          state = state.copyWith(message: trackFailure(result));
        }
      });
}

final notificationsProvider = NotifierProvider.autoDispose(
  NotificationsNotifier.new,
);
