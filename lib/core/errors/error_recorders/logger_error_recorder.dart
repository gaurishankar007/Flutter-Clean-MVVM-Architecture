import 'dart:developer';

import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/errors/error_recorders/error_recorder.dart';
import 'package:flutter/foundation.dart';

/// Prints recorded errors to the console in debug builds.
final class LoggerErrorRecorder implements ErrorRecorder {
  @override
  void recordUncaughtErrors() {}

  @override
  bool get isRecordable => kDebugMode;

  @override
  void record({
    required Object error,
    FailureState<dynamic>? failureState,
    StackTrace? stackTrace,
  }) {
    final path = failureState?.actionPath.join(' > ');
    log(
      '${failureState?.message ?? 'Error'}'
      '${path == null || path.isEmpty ? '' : ' ($path)'}',
      name: 'clean_architecture',
      error: failureState?.error ?? error,
      stackTrace: stackTrace,
    );
  }
}
