part of 'base_notifier.dart';

/// Logs the errors a notifier shows the user in the [AppErrorRecorder].
mixin ErrorTracking {
  /// Runs [call] as the user flow [action]: an error the data layer records
  /// inside it is labelled with [action] and this notifier.
  T runFlow<T>(String action, T Function() call) =>
      ErrorFlow(action: action, source: '$runtimeType').run(call);

  /// Logs a notifier-side error (validation, guards) as shown and returns it
  /// as an [ErrorMessage]. [action] defaults to the current [runFlow]'s.
  ErrorMessage trackError(String text, {String? action}) {
    AppErrorProvider.I.trackError(
      text,
      action: _flowAction(action),
      source: '$runtimeType',
    );
    return ErrorMessage(text);
  }

  /// Marks a failed [dataState] as shown and returns its message as an
  /// [ErrorMessage]; [action] becomes the outermost level of its action path.
  ErrorMessage trackFailure(DataState<dynamic> dataState, {String? action}) {
    AppErrorProvider.I.trackFailure(
      dataState,
      action: _flowAction(action),
      source: '$runtimeType',
    );
    return ErrorMessage(dataState.message ?? CommonMessages.genericError);
  }

  String? _flowAction(String? action) {
    final flowAction = action ?? ErrorFlow.current?.action;
    assert(
      flowAction != null,
      'Track errors inside runFlow or pass an action, so the log names the flow.',
    );
    return flowAction;
  }
}
