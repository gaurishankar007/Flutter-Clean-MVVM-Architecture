import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/errors/error_handler.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:dio/dio.dart';

/// Runs an HTTP request inside `ErrorHandler.execute` and parses the body.
abstract final class ApiExecutor {
  /// Parses the response into [T] with [fromJson] (a JSON object, or each
  /// item of a JSON list). [dataKey] reads the payload from that key of the
  /// body (`{"todos": [...]}`); null uses the whole body.
  static FutureData<T> call<T, R>(
    Future<Response<dynamic>> Function() request, {
    required String action,
    R Function(JsonMap json)? fromJson,
    String? dataKey,
  }) => ErrorHandlerProvider.I.execute(() async {
    final response = await request();
    dynamic body = response.data;

    FailureState<T> failure(String error) =>
        FailureState.badResponse(error: '$action: $error');

    if (dataKey != null) {
      if (body case final JsonMap map when map.containsKey(dataKey)) {
        body = map[dataKey];
      } else {
        return failure('missing key "$dataKey"');
      }
    }
    if (fromJson != null) {
      return switch (body) {
        final JsonMap json => SuccessState(
          data: fromJson(json) as T,
          origin: .remote,
        ),
        final List<dynamic> list => SuccessState(
          data: list.cast<JsonMap>().map(fromJson).toList() as T,
          origin: .remote,
        ),
        _ => failure('expected a JSON object or list, got ${body.runtimeType}'),
      };
    }
    if (body is T) {
      return SuccessState(data: body, origin: .remote);
    }
    return failure('expected $T, got ${body.runtimeType}');
  }, action: action);

  /// Runs a request whose response body isn't needed.
  static FutureVoid voidCall(
    Future<Response<dynamic>> Function() request, {
    required String action,
  }) => ErrorHandlerProvider.I.execute(() async {
    await request();
    return const SuccessState.nil(origin: .remote);
  }, action: action);
}
