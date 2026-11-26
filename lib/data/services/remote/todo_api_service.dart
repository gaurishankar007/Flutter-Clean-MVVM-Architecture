import 'package:clean_architecture/core/clients/remote/http/http_client.dart';
import 'package:clean_architecture/core/constants/api_endpoints.dart';
import 'package:clean_architecture/core/data/operations/api_executor.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/data/models/responses/todo_response.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TodoApiService({required final HttpClient _http}) {
  /// The demo API's shared sample list (its per-user lists are tiny).
  FutureList<TodoResponse> todos({int limit = 30}) => ApiExecutor.call(
    () => _http.get<dynamic>(
      ApiEndpoints.todos,
      queryParameters: {'limit': limit},
    ),
    action: 'todo.api.todos',
    fromJson: TodoResponse.fromJson,
    dataKey: 'todos',
  );
}
