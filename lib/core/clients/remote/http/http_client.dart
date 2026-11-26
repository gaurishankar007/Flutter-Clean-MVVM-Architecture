import 'package:clean_architecture/config/app_config.dart';
import 'package:clean_architecture/core/clients/remote/http/http_auth_interceptor.dart';
import 'package:clean_architecture/core/constants/http_keys.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

/// HTTP verbs used by the remote services. An interface so tests mock it
/// instead of Dio.
abstract interface class HttpClient {
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<Response<T>> post<T>(String path, {Object? data, Options? options});

  Future<Response<T>> put<T>(String path, {Object? data, Options? options});

  Future<Response<T>> patch<T>(String path, {Object? data, Options? options});

  Future<Response<T>> delete<T>(String path, {Object? data, Options? options});
}

@LazySingleton(as: HttpClient)
final class HttpClientImpl({
  required AppConfig appConfig,
  required HttpAuthInterceptor authInterceptor,
}) implements HttpClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: appConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {HttpKeys.contentType: HttpKeys.applicationJson},
    ),
  )..interceptors.add(authInterceptor);

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _dio.get(path, queryParameters: queryParameters, options: options);

  @override
  Future<Response<T>> post<T>(String path, {Object? data, Options? options}) =>
      _dio.post(path, data: data, options: options);

  @override
  Future<Response<T>> put<T>(String path, {Object? data, Options? options}) =>
      _dio.put(path, data: data, options: options);

  @override
  Future<Response<T>> patch<T>(String path, {Object? data, Options? options}) =>
      _dio.patch(path, data: data, options: options);

  @override
  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Options? options,
  }) => _dio.delete(path, data: data, options: options);
}
