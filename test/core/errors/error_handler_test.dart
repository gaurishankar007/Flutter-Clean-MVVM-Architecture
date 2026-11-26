import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/errors/error_handler.dart';
import 'package:clean_architecture/core/errors/error_recorders/error_recorder.dart';
import 'package:clean_architecture/core/errors/error_translators/dio_error_translator.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRecorder extends Mock implements ErrorRecorder;

void main() {
  late _MockRecorder recorder;
  late ErrorHandler handler;

  setUp(() {
    recorder = _MockRecorder();
    when(() => recorder.isRecordable).thenReturn(true);
    handler = ErrorHandlerImpl(
      errorTranslators: [DioErrorTranslator()],
      errorRecorders: [recorder],
    );
  });

  group('execute', () {
    test('returns a success unchanged', () async {
      final result = await handler.execute(
        () async => const SuccessState(data: 1),
        action: 'test.op',
      );

      expect(result, const SuccessState(data: 1));
      verifyNever(
        () => recorder.record(
          error: any(named: 'error'),
          failureState: any(named: 'failureState'),
          stackTrace: any(named: 'stackTrace'),
        ),
      );
    });

    test('translates and records a throw, labelled with the action', () async {
      final result = await handler.execute<int>(
        () => throw DioException(
          requestOptions: RequestOptions(path: '/todos'),
          type: DioExceptionType.connectionError,
        ),
        action: 'todo.api.list',
      );

      final failure = result as FailureState<int>;
      expect(failure.message, CommonMessages.network);
      expect(failure.actionPath, ['todo.api.list']);
      expect(failure.errorId, isNotNull);
      verify(
        () => recorder.record(
          error: any(named: 'error'),
          failureState: failure,
          stackTrace: any(named: 'stackTrace'),
        ),
      ).called(1);
    });

    test('labels a returned failure without recording it again', () async {
      final result = await handler.execute<int>(
        () async => const FailureState(actionPath: ['inner']),
        action: 'outer',
      );

      expect((result as FailureState).actionPath, ['outer', 'inner']);
    });
  });

  test('executeStream turns an error event into a failure event', () async {
    final stream = Stream<int>.multi((controller) {
      controller
        ..add(1)
        ..addError(StateError('db closed'))
        ..close();
    });

    final events = await handler
        .executeStream(stream, action: 'watch')
        .toList();

    expect(events.first, const SuccessState(data: 1));
    expect(events.last, isA<FailureState<int>>());
  });
}
