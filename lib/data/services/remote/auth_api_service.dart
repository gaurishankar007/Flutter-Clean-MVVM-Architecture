import 'package:clean_architecture/core/clients/remote/http/http_client.dart';
import 'package:clean_architecture/core/constants/api_endpoints.dart';
import 'package:clean_architecture/core/constants/http_keys.dart';
import 'package:clean_architecture/core/data/operations/api_executor.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/data/models/requests/login_request.dart';
import 'package:clean_architecture/data/models/responses/login_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthApiService({required final HttpClient _http}) {
  FutureData<LoginResponse> login(LoginRequest request) => ApiExecutor.call(
    () => _http.post<dynamic>(
      ApiEndpoints.login,
      data: request.toJson(),
      // A 401 here is a wrong password, not an expired session.
      options: Options(extra: {HttpKeys.excludeAuth: true}),
    ),
    action: 'auth.api.login',
    fromJson: LoginResponse.fromJson,
  );
}
