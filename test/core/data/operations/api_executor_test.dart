import 'package:clean_architecture/core/data/operations/api_executor.dart';
import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/data/models/responses/todo_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../testing/helpers/test_setup.dart';

Response<dynamic> _response(Object? data) => Response(
  requestOptions: RequestOptions(path: '/'),
  data: data,
);

void main() {
  setUp(registerErrorHandling);
  tearDown(resetDependencies);

  test('reads a list under dataKey and parses each item', () async {
    final result = await ApiExecutor.call<List<TodoResponse>, TodoResponse>(
      () async => _response({
        'todos': [
          {'id': 1, 'todo': 'A', 'completed': false, 'userId': 1},
          {'id': 2, 'todo': 'B', 'completed': true, 'userId': 1},
        ],
      }),
      action: 'test',
      fromJson: TodoResponse.fromJson,
      dataKey: 'todos',
    );

    expect(result.data?.map((t) => t.todo), ['A', 'B']);
  });

  test('fails with a bad response when dataKey is missing', () async {
    final result = await ApiExecutor.call<List<TodoResponse>, TodoResponse>(
      () async => _response({'items': <dynamic>[]}),
      action: 'test',
      fromJson: TodoResponse.fromJson,
      dataKey: 'todos',
    );

    expect(result, isA<FailureState<List<TodoResponse>>>());
    expect((result as FailureState).actionPath, ['test']);
  });

  test('voidCall returns nil on success', () async {
    final result = await ApiExecutor.voidCall(
      () async => _response(null),
      action: 'test',
    );

    expect(result.hasData, isTrue);
  });
}
