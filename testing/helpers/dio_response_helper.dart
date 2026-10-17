import 'package:clean_architecture/core/data/models/domain_convertible.dart';
import 'package:dio/dio.dart';

Response<dynamic> getResponse({
  dynamic data,
  String responseDataKey = 'data',
  String? message,
  int? statusCode,
  RequestOptions? requestOptions,
  bool isStandardResponse = true,
}) => Response(
  data: isStandardResponse ? {responseDataKey: data, 'message': message} : data,
  requestOptions: requestOptions ?? RequestOptions(),
  statusCode: statusCode,
);

DioException getDioException({
  dynamic data,
  String responseDataKey = 'data',
  String? message,
  int? statusCode,
  RequestOptions? requestOptions,
}) => DioException(
  requestOptions: requestOptions ?? RequestOptions(),
  response: getResponse(
    responseDataKey: responseDataKey,
    data: data,
    message: message,
    statusCode: statusCode,
  ),
  type: .badResponse,
);

class FakeDto(final int value) implements DomainConvertible<String> {
  @override
  String toDomain() => 'Mapped: $value';
}
