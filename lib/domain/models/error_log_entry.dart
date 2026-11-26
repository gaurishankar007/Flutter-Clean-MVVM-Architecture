import 'package:equatable/equatable.dart';

/// One recorded error (see AppErrorRecorder).
final class const ErrorLogEntry({
  required final String id,
  required final DateTime createdAt,
  required final String message,
  final String? action,
  final String? source,
  final String? error,
  final bool shown = false,
}) extends Equatable {
  @override
  List<Object?> get props => [
    id,
    createdAt,
    message,
    action,
    source,
    error,
    shown,
  ];
}
