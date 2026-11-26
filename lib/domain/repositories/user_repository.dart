import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/domain/models/user.dart';
import 'package:flutter/foundation.dart' show Uint8List;

abstract interface class UserRepository {
  /// The signed-in user, or null.
  User? get currentUser;

  /// The signed-in user as it changes (login, edits, logout).
  Stream<User?> watchUser();

  /// Fetches the user from the server and stores it.
  FutureData<User> refresh();

  /// Saves profile edits on the server, then on this device.
  FutureData<User> update(User user);

  /// Opens the photo picker; null data when the user cancelled.
  FutureData<Uint8List?> pickAvatar();
}
