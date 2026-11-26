part of 'data_state.dart';

/// A failed operation. [message] defaults to [CommonMessages.genericError].
final class const FailureState<T>({
  String? message,
  super.error,
  super.origin,
  super.extra,

  /// The labelled levels the failure passed through, outermost first
  /// (`['todos.save', 'todo.local.upsert']`). Kept out of equality.
  final List<String> actionPath = const [],

  /// Where the failure happened. Kept out of equality.
  final StackTrace? stackTrace,

  /// The error log entry `ErrorHandler` recorded this failure under, so
  /// `trackFailure` marks it shown instead of adding a duplicate.
  final String? errorId,
}) extends DataState<T> {
  this : super(message: message ?? CommonMessages.genericError, hasError: true);

  /// The server rejected the request's data.
  factory badRequest({String? message, String? error, dynamic extra}) =>
      FailureState(
        message: message ?? CommonMessages.badRequest,
        error: error,
        origin: .remote,
        extra: extra,
      );

  /// The session's token expired and couldn't be refreshed.
  factory tokenExpired() =>
      const FailureState(message: CommonMessages.tokenExpired, origin: .remote);

  /// The server answered with something we can't read.
  factory badResponse({String? message, String? error, dynamic extra}) =>
      FailureState(
        message: message ?? CommonMessages.badResponse,
        error: error,
        origin: .remote,
        extra: extra,
      );

  /// The server failed.
  factory serverError({String? message, String? error, dynamic extra}) =>
      FailureState(
        message: message ?? CommonMessages.serverError,
        error: error,
        origin: .remote,
        extra: extra,
      );

  /// No internet. `origin: .remote` is load-bearing: the UI uses it to tell
  /// an offline failure from a local one.
  factory noInternet({String? action}) => FailureState(
    message: CommonMessages.noInternet,
    error: CommonMessages.noInternet,
    origin: .remote,
    actionPath: [?action],
  );

  /// Adds [action] as the outermost level, unless it's null or already there.
  FailureState<T> withAction(String? action) {
    if (action == null || actionPath.firstOrNull == action) {
      return this;
    }
    return _copyWith(actionPath: [action, ...actionPath]);
  }

  /// Keeps an existing trace: it's closer to where the failure happened.
  FailureState<T> withStackTrace(StackTrace? stackTrace) {
    if (stackTrace == null || this.stackTrace != null) {
      return this;
    }
    return _copyWith(stackTrace: stackTrace);
  }

  /// This failure typed for another result, keeping every field.
  FailureState<R> retype<R>() => FailureState<R>(
    message: message,
    error: error,
    origin: origin,
    extra: extra,
    actionPath: actionPath,
    stackTrace: stackTrace,
    errorId: errorId,
  );

  FailureState<T> withErrorId(String errorId) => _copyWith(errorId: errorId);

  /// A clearer user-facing [message]; skipped when null.
  FailureState<T> withMessage(String? message) {
    if (message == null) {
      return this;
    }
    return _copyWith(message: message);
  }

  FailureState<T> _copyWith({
    String? message,
    List<String>? actionPath,
    StackTrace? stackTrace,
    String? errorId,
  }) => FailureState<T>(
    message: message ?? this.message,
    error: error,
    origin: origin,
    extra: extra,
    actionPath: actionPath ?? this.actionPath,
    stackTrace: stackTrace ?? this.stackTrace,
    errorId: errorId ?? this.errorId,
  );
}
