import 'dart:async';

import 'package:clean_architecture/config/app_config.dart';
import 'package:clean_architecture/core/clients/remote/http/token_store.dart';
import 'package:clean_architecture/core/constants/api_endpoints.dart';
import 'package:clean_architecture/core/constants/http_keys.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

/// Adds the bearer token and, on a 401, refreshes it once and retries every
/// request that failed meanwhile. A failed refresh expires the session; the
/// UI reacts to that (it never navigates from here).
@lazySingleton
final class HttpAuthInterceptor({
  required final TokenStore _tokenStore,
  required AppConfig appConfig,
}) extends QueuedInterceptor {
  // A bare Dio, so the refresh call doesn't loop through this interceptor.
  final Dio _refreshDio = Dio(BaseOptions(baseUrl: appConfig.apiBaseUrl));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final excluded = options.extra[HttpKeys.excludeAuth] == true;
    final token = _tokenStore.accessToken;
    if (!excluded &&
        token != null &&
        !options.headers.containsKey(HttpKeys.authorization)) {
      options.headers[HttpKeys.authorization] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final excluded = options.extra[HttpKeys.excludeAuth] == true;
    if (err.response?.statusCode != 401 || excluded) {
      return handler.next(err);
    }

    // QueuedInterceptor runs errors one at a time: a request queued behind
    // the refresh retries with the token it already got.
    final sentToken = options.headers[HttpKeys.authorization];
    final currentToken = _tokenStore.accessToken;
    if (currentToken != null && sentToken != 'Bearer $currentToken') {
      await _retry(options, currentToken, err, handler);
      return;
    }

    final refreshed = await _refresh();
    if (refreshed == null) {
      await _tokenStore.expire();
      return handler.next(err);
    }
    await _retry(options, refreshed, err, handler);
  }

  Future<String?> _refresh() async {
    final refreshToken = _tokenStore.refreshToken;
    if (refreshToken == null) {
      return null;
    }
    try {
      final response = await _refreshDio.post<Map<String, dynamic>>(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );
      if (response.data case {
        'accessToken': final String access,
        'refreshToken': final String refresh,
      }) {
        await _tokenStore.saveTokens(
          accessToken: access,
          refreshToken: refresh,
        );
        return access;
      }
    } on DioException {
      // Falls through: the session expires.
    }
    return null;
  }

  Future<void> _retry(
    RequestOptions options,
    String token,
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    options.headers[HttpKeys.authorization] = 'Bearer $token';
    try {
      handler.resolve(await _refreshDio.fetch<dynamic>(options));
    } on DioException catch (error) {
      handler.next(error);
    }
  }
}
