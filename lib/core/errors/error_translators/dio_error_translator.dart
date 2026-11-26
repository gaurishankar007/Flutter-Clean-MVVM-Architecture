import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/errors/error_translators/error_translator.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:dio/dio.dart';

/// HTTP failures. The logged error keeps the host and path only: no query
/// string, headers or body.
final class DioErrorTranslator implements ErrorTranslator<DioException> {
  @override
  bool matches(Object error) => error is DioException;

  @override
  FailureState<T> translate<T>(DioException error) {
    final code = error.response?.statusCode;
    final uri = error.requestOptions.uri;
    final detail =
        'DioException ${error.type.name} ${code ?? ''} ${uri.host}${uri.path}';
    // Prefer the server's own message when it sends one.
    final serverMessage = switch (error.response?.data) {
      {'message': final String message} when message.isNotEmpty => message,
      _ => null,
    };
    return switch (error.type) {
      .badResponse => switch (code) {
        400 || 422 => .badRequest(message: serverMessage, error: detail),
        401 || 403 => FailureState(
          message: serverMessage ?? CommonMessages.unauthorized,
          error: detail,
          origin: .remote,
        ),
        404 => FailureState(
          message: CommonMessages.notFound,
          error: detail,
          origin: .remote,
        ),
        _ => .serverError(error: detail),
      },
      .connectionTimeout ||
      .sendTimeout ||
      .receiveTimeout ||
      .connectionError => FailureState(
        message: CommonMessages.network,
        error: detail,
        origin: .remote,
      ),
      _ => FailureState(error: detail, origin: .remote),
    };
  }
}
