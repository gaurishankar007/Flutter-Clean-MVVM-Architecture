import 'package:clean_architecture/core/data/models/domain_convertible.dart';
import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/types/types.dart';

/// Coordinates remote and local data in repositories (offline-first reads).
abstract final class RepositoryFetcher {
  /// Online: runs [remote] and, on success, [onRemoteSuccess] (e.g. cache
  /// it). Offline: falls back to [local], or a `noInternet` failure.
  static FutureData<T> fetchWithFallback<T>({
    required bool isConnected,
    required FutureData<T> Function() remote,
    required String action,
    Future<void> Function(T data)? onRemoteSuccess,
    FutureData<T> Function()? local,
  }) async {
    if (isConnected) {
      final result = await remote();
      if (result case SuccessState(:final data?) when onRemoteSuccess != null) {
        await onRemoteSuccess(data);
      }
      return result.withAction(action);
    }
    final fallback = await local?.call();
    return (fallback ?? FailureState.noInternet()).withAction(action);
  }

  /// [fetchWithFallback] for a DTO that maps to the domain model [R].
  static FutureData<R>
  fetchWithFallbackAndMap<T extends DomainConvertible<R>, R>({
    required bool isConnected,
    required FutureData<T> Function() remote,
    required String action,
    Future<void> Function(T data)? onRemoteSuccess,
    FutureData<T> Function()? local,
  }) async {
    final result = await fetchWithFallback(
      isConnected: isConnected,
      remote: remote,
      action: action,
      onRemoteSuccess: onRemoteSuccess,
      local: local,
    );
    return result.mapData((dto) => dto.toDomain());
  }
}
