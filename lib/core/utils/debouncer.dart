import 'dart:async';

/// Runs only the last of several quick calls, after [delay].
final class Debouncer({
  final Duration delay = const Duration(milliseconds: 300),
}) {
  Timer? _timer;

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() => _timer?.cancel();
}
