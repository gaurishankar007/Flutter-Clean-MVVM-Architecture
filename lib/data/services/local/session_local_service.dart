import 'dart:async';

import 'package:clean_architecture/core/clients/remote/http/token_store.dart';
import 'package:clean_architecture/core/constants/storage_keys.dart';
import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/errors/error_handler.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/data/models/local/session_local.dart';
import 'package:clean_architecture/data/services/local/key_value_local_service.dart';
import 'package:clean_architecture/domain/models/session.dart';
import 'package:injectable/injectable.dart';

/// The stored session, cached in memory so guards and the HTTP client read
/// it synchronously.
@lazySingleton
class SessionLocalService({required final KeyValueLocalService _keyValue})
    implements TokenStore {
  final _changes = StreamController<Session?>.broadcast();
  final _expired = StreamController<void>.broadcast();
  Session? _session;

  Session? get current => _session;

  /// The session after every change; null after logout or expiry.
  Stream<Session?> get changes => _changes.stream;

  /// Emits when [expire] dropped the session.
  Stream<void> get expired => _expired.stream;

  /// Reads the stored session into memory. Called once at startup.
  FutureVoid load() => ErrorHandlerProvider.I.execute(() async {
    final json = await _keyValue.read(StorageKeys.session);
    _session = json == null ? null : SessionLocal.fromLocalJson(json);
    return const SuccessState.nil(origin: .local);
  }, action: 'session.local.load');

  FutureVoid save(Session session) => ErrorHandlerProvider.I.execute(() async {
    await _keyValue.write(StorageKeys.session, session.toLocalJson());
    _set(session);
    return const SuccessState.nil(origin: .local);
  }, action: 'session.local.save');

  FutureVoid clear() => ErrorHandlerProvider.I.execute(() async {
    _set(null);
    await _keyValue.remove(StorageKeys.session);
    return const SuccessState.nil(origin: .local);
  }, action: 'session.local.clear');

  @override
  String? get accessToken => _session?.accessToken;

  @override
  String? get refreshToken => _session?.refreshToken;

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    if (_session case final session?) {
      await save(
        session.copyWith(accessToken: accessToken, refreshToken: refreshToken),
      );
    }
  }

  @override
  Future<void> expire() async {
    if (_session == null) {
      return;
    }
    await clear();
    _expired.add(null);
  }

  void _set(Session? session) {
    _session = session;
    _changes.add(session);
  }
}

/// Registers the same [SessionLocalService] as the HTTP client's [TokenStore].
@module
abstract class TokenStoreModule {
  @lazySingleton
  TokenStore tokenStore(SessionLocalService service) => service;
}
