import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DataState', () {
    test('mapData transforms a success and keeps its origin', () {
      const state = SuccessState(data: 2, origin: DataOrigin.remote);

      final mapped = state.mapData((value) => '$value!');

      expect(mapped, const SuccessState(data: '2!', origin: DataOrigin.remote));
    });

    test('mapData retypes a failure keeping every field', () {
      const failure = FailureState<int>(
        message: 'Nope',
        error: 'boom',
        actionPath: ['flow'],
        errorId: 'id-1',
      );

      final mapped =
          failure.mapData((value) => '$value') as FailureState<String>;

      expect(mapped.message, 'Nope');
      expect(mapped.actionPath, ['flow']);
      expect(mapped.errorId, 'id-1');
    });

    test('FailureState defaults to the generic message', () {
      expect(const FailureState<void>().message, CommonMessages.genericError);
    });

    test('withAction adds the outermost level once', () {
      const failure = FailureState<void>(actionPath: ['todo.local.upsert']);

      final once = failure.withAction('todos.save');
      final twice = once.withAction('todos.save');

      expect(twice.actionPath, ['todos.save', 'todo.local.upsert']);
    });

    test('noInternet is a remote failure', () {
      final failure = FailureState<void>.noInternet(action: 'sync');

      expect(failure.origin, DataOrigin.remote);
      expect(failure.actionPath, ['sync']);
    });

    test('SuccessState.nil has data and no payload', () {
      const state = SuccessState<void>.nil();

      expect(state.hasData, isTrue);
      expect(state.props.first, isNull);
    });
  });
}
