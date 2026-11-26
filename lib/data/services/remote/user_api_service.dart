import 'package:clean_architecture/core/clients/remote/http/http_client.dart';
import 'package:clean_architecture/core/constants/api_endpoints.dart';
import 'package:clean_architecture/core/data/operations/api_executor.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/data/models/requests/update_user_request.dart';
import 'package:clean_architecture/data/models/responses/user_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserApiService({required final HttpClient _http}) {
  FutureData<UserResponse> me() => ApiExecutor.call(
    () => _http.get<dynamic>(ApiEndpoints.me),
    action: 'user.api.me',
    fromJson: UserResponse.fromJson,
  );

  FutureData<UserResponse> update(int id, UpdateUserRequest request) =>
      ApiExecutor.call(
        () => _http.put<dynamic>(ApiEndpoints.user(id), data: request.toJson()),
        action: 'user.api.update',
        fromJson: UserResponse.fromJson,
      );
}
