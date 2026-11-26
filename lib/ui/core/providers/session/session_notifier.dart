import 'dart:async';

import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/repositories/auth_repository.dart';
import 'package:clean_architecture/domain/repositories/user_repository.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';
import 'package:clean_architecture/ui/core/providers/session/session_state.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// The signed-in user, app-wide (keep-alive). Reports an expired session;
/// the root widget reacts by navigating to login.
class SessionNotifier extends BaseNotifier<SessionState> {
  @override
  SessionState build() {
    final users = GetIt.I<UserRepository>();
    final userSubscription = users.watchUser().listen((user) {
      state = SessionState(user: user, expired: state.expired && user == null);
    });
    final expiredSubscription = GetIt.I<AuthRepository>().sessionExpired.listen(
      (_) => state = const SessionState(
        expired: true,
        message: ErrorMessage(AuthMessages.sessionExpired),
      ),
    );
    ref.onDispose(() {
      unawaited(userSubscription.cancel());
      unawaited(expiredSubscription.cancel());
    });
    return SessionState(user: users.currentUser);
  }
}

final sessionProvider = NotifierProvider(SessionNotifier.new);
