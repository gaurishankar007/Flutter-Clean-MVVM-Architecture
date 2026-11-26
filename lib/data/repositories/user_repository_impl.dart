import 'dart:async';

import 'package:clean_architecture/core/clients/remote/connectivity_client.dart';
import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/data/models/requests/update_user_request.dart';
import 'package:clean_architecture/data/services/local/session_local_service.dart';
import 'package:clean_architecture/data/services/platform/image_picker_service.dart';
import 'package:clean_architecture/data/services/remote/user_api_service.dart';
import 'package:clean_architecture/domain/models/user.dart';
import 'package:clean_architecture/domain/repositories/user_repository.dart';
import 'package:flutter/foundation.dart' show Uint8List;
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserRepository)
final class UserRepositoryImpl({
  required final UserApiService _api,
  required final SessionLocalService _session,
  required final ImagePickerService _imagePicker,
  required final ConnectivityClient _connectivity,
}) implements UserRepository {
  @override
  User? get currentUser => _session.current?.user;

  @override
  Stream<User?> watchUser() async* {
    yield currentUser;
    yield* _session.changes.map((session) => session?.user);
  }

  @override
  FutureData<User> refresh() async {
    final current = _session.current;
    if (current == null) {
      return FailureState.tokenExpired();
    }
    if (!_connectivity.isConnected) {
      return SuccessState(data: current.user, origin: .local);
    }
    final result = await _api.me();
    if (result case SuccessState(:final data?)) {
      // The picked photo exists only on this device; keep it.
      final user = data.toDomain().copyWith(
        avatarBytes: current.user.avatarBytes,
      );
      await _session.save(current.copyWith(user: user));
      return SuccessState(data: user, origin: .remote);
    }
    return result.mapData((data) => data.toDomain());
  }

  @override
  FutureData<User> update(User user) async {
    final current = _session.current;
    if (current == null) {
      return FailureState.tokenExpired();
    }
    if (!_connectivity.isConnected) {
      return FailureState.noInternet();
    }
    final result = await _api.update(
      user.id,
      UpdateUserRequest(
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        phone: user.phone,
      ),
    );
    if (result is! SuccessState) {
      return result.mapData((data) => data.toDomain());
    }
    // The demo API doesn't persist edits, so the device copy is the truth.
    final saved = await _session.save(current.copyWith(user: user));
    return switch (saved) {
      final FailureState<void> failure => failure.retype(),
      _ => SuccessState(data: user, origin: .remote),
    };
  }

  @override
  FutureData<Uint8List?> pickAvatar() => _imagePicker.pickFromGallery();
}
