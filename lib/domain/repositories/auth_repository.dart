import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/domain/models/user.dart';

abstract interface class AuthRepository {
  /// Whether a session is stored. Synchronous, for route guards.
  bool get isLoggedIn;

  /// Emits when the session expired and couldn't be refreshed.
  Stream<void> get sessionExpired;

  FutureData<User> login({required String username, required String password});

  /// Clears the session. Never fails.
  FutureVoid logout();
}
