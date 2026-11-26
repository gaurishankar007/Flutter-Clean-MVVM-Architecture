import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/errors/error_translators/error_translator.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:drift/drift.dart';

/// Local database failures.
final class DriftErrorTranslator
    implements ErrorTranslator<DriftWrappedException> {
  @override
  bool matches(Object error) => error is DriftWrappedException;

  @override
  FailureState<T> translate<T>(DriftWrappedException error) => FailureState(
    message: CommonMessages.storageError,
    error: 'DriftWrappedException ${error.message} ${error.cause}',
    origin: .local,
  );
}
