import 'package:clean_architecture/core/errors/error_handler.dart';
import 'package:clean_architecture/core/errors/error_recorders/app_error_recorder.dart';
import 'package:clean_architecture/core/errors/error_translators/dio_error_translator.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/client_mocks.dart';

/// Registers a real [ErrorHandler] (Dio translator, no recorders) and a mock
/// [AppErrorRecorder], which `trackFailure`/`trackError` need. Returns the
/// recorder so tests can verify what was tracked.
MockAppErrorRecorder registerErrorHandling() {
  final recorder = MockAppErrorRecorder();
  GetIt.I
    ..registerSingleton<AppErrorRecorder>(recorder)
    ..registerSingleton<ErrorHandler>(
      ErrorHandlerImpl(
        errorTranslators: [DioErrorTranslator()],
        errorRecorders: [],
      ),
    );
  return recorder;
}

/// Registers [instance] in get_it as [T].
void registerMock<T extends Object>(T instance) =>
    GetIt.I.registerSingleton<T>(instance);

/// Clears get_it between tests.
Future<void> resetDependencies() => GetIt.I.reset();

/// Call once in `setUpAll` for every type used with `any()`.
void registerFallbacks(List<Object> values) =>
    values.forEach(registerFallbackValue);
