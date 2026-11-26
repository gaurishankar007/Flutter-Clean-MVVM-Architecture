import 'package:clean_architecture/domain/models/error_log_entry.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';

final class const ErrorLogState({
  super.status = .loading,
  super.message,
  final List<ErrorLogEntry> entries = const [],
}) extends BaseState {
  /// Every entry as plain text, for a bug report.
  String get report => entries
      .map(
        (e) => [
          e.createdAt.toIso8601String(),
          ?e.action,
          ?e.source,
          e.message,
          ?e.error,
        ].join(' | '),
      )
      .join('\n');

  @override
  List<Object?> get props => [...super.props, entries];
}
