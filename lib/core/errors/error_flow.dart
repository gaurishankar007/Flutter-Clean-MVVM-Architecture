import 'dart:async';

/// The user flow a notifier runs ([action]) and the notifier ([source]),
/// carried down to the data layer in a [Zone], so an error recorded there
/// knows which flow it broke without every method taking it.
class const ErrorFlow({
  required final String action,
  required final String source,
}) {
  static final Object _zoneKey = Object();

  /// The flow the current code runs in, if any.
  static ErrorFlow? get current => switch (Zone.current[_zoneKey]) {
    final ErrorFlow flow => flow,
    _ => null,
  };

  /// Runs [body] in this flow. A returned `Future` keeps it across every
  /// `await`; a stream only gets it if `listen` is called inside.
  T run<T>(T Function() body) => runZoned(body, zoneValues: {_zoneKey: this});
}
