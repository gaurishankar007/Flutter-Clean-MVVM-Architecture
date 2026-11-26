import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

part 'failure_state.dart';
part 'loading_state.dart';
part 'success_state.dart';

/// Where a [DataState]'s data came from, when known. `null` means unknown.
enum DataOrigin { local, remote }

/// Sealed result of a data operation: `SuccessState`, `FailureState` or
/// `LoadingState`.
@immutable
sealed class const DataState<T>({
  /// The payload of a success; `null` otherwise or when there's no data.
  final T? data,

  /// A user-facing message (from the message catalog or the server).
  final String? message,

  /// A raw error for the error log, never shown to the user.
  final String? error,
  final bool hasData = false,
  final bool hasError = false,
  final DataOrigin? origin,
  final dynamic extra,
}) extends Equatable {
  /// Runs the callback matching this state's subtype.
  R when<R>({
    required R Function(T data) success,
    required R Function(String? message, String? error) failure,
    required R Function() loading,
  }) => switch (this) {
    SuccessState(:final data) => success(data as T),
    FailureState(:final message, :final error) => failure(message, error),
    LoadingState() => loading(),
  };

  /// Maps a success's data to [R]; failures keep every field, retyped.
  DataState<R> mapData<R>(R Function(T data) transform) => switch (this) {
    SuccessState(:final data) => SuccessState<R>(
      data: transform(data as T),
      message: message,
      origin: origin,
      extra: extra,
    ),
    final FailureState<T> failure => failure.retype<R>(),
    LoadingState() => LoadingState<R>(),
  };

  @override
  List<Object?> get props => [
    data,
    message,
    error,
    hasData,
    hasError,
    origin,
    extra,
  ];
}

extension DataStateActionPath<T> on DataState<T> {
  /// Adds [action] as the outermost level of a failure's action path.
  DataState<T> withAction(String? action) => switch (this) {
    final FailureState<T> failure => failure.withAction(action),
    _ => this,
  };
}
