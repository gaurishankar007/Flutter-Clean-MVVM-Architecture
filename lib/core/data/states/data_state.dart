import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

part 'failure_state.dart';
part 'loading_state.dart';
part 'success_state.dart';

/// Base immutable sealed class representing the state of asynchronous
/// data operations. Subtypes are `SuccessState`, `FailureState` and
/// `LoadingState`. This class holds optional metadata useful for
/// UI and error handling.
@immutable
sealed class const DataState<T>({
  /// The payload for successful operations. May be `null` for
  /// non-success states or when no data is available.
  final T? data,

  /// A user-facing, localized message suitable for display in UI.
  /// Present when an operation failed but a friendly message is known.
  final String? message,

  /// A raw error string (e.g. exception message or debug info). This
  /// is intended for logging or developer diagnostics rather than
  /// direct user display.
  final String? error,

  /// Whether this state currently carries non-null data.
  final bool hasData = false,

  /// Whether this state represents an error condition.
  final bool hasError = false,
  final dynamic extra,
}) extends Equatable {
  /// Executes the matching callback depending on runtime subtype.
  /// - `success` receives the unwrapped `data` for `SuccessState`.
  /// - `failure` receives the friendly `message` and `errorType`.
  /// - `loading` is used for `LoadingState`.
  R when<R>({
    required R Function(T data) success,
    required R Function(String? message, String? error) failure,
    required R Function() loading,
  }) => switch (this) {
    SuccessState<T>(:final data) => success(data as T),
    FailureState<T>(:final message, :final error) => failure(message, error),
    LoadingState<T>() => loading(),
  };

  /// Similar to `when`, but passes the concrete state instance to the
  /// callbacks allowing access to all fields (`data`, `message`, etc.).
  R map<R>({
    required R Function(SuccessState<T> value) success,
    required R Function(FailureState<T> value) failure,
    required R Function(LoadingState<T> value) loading,
  }) => switch (this) {
    final SuccessState<T> state => success(state),
    final FailureState<T> state => failure(state),
    final LoadingState<T> state => loading(state),
  };

  /// Transforms the contained `data` from `T` to `R` when the state is
  /// `SuccessState`. For `FailureState` and `LoadingState` the same
  /// logical state is returned but typed to `R`.
  DataState<R> mapData<R>(R Function(T data) transform) {
    return when(
      success: (data) => SuccessState<R>(
        data: transform(data),
        message: message,
        extra: extra,
      ),
      failure: (message, errorType) =>
          FailureState<R>(message: message, error: error, extra: extra),
      loading: LoadingState<R>.new,
    );
  }

  @override
  List<Object?> get props => [data, message, error, extra, hasData, hasError];
}
