import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/data/models/requests/login_request.dart';
import 'package:clean_architecture/data/services/local/session_local_service.dart';
import 'package:clean_architecture/data/services/remote/auth_api_service.dart';
import 'package:clean_architecture/domain/models/session.dart';
import 'package:clean_architecture/domain/models/user.dart';
import 'package:clean_architecture/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
final class AuthRepositoryImpl({
  required final AuthApiService _api,
  required final SessionLocalService _session,
}) implements AuthRepository {
  @override
  bool get isLoggedIn => _session.current != null;

  @override
  Stream<void> get sessionExpired => _session.expired;

  @override
  FutureData<User> login({
    required String username,
    required String password,
  }) async {
    final result = await _api.login(
      LoginRequest(username: username.trim(), password: password),
    );
    switch (result) {
      case SuccessState(:final data?):
        final session = Session(
          accessToken: data.accessToken,
          refreshToken: data.refreshToken,
          user: data.user.toDomain(),
        );
        final saved = await _session.save(session);
        if (saved case final FailureState<void> failure) {
          return failure.retype();
        }
        return SuccessState(data: session.user, origin: .remote);
      default:
        return result.mapData((data) => data.user.toDomain());
    }
  }

  @override
  FutureVoid logout() => _session.clear();
}
