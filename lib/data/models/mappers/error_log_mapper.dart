import 'package:clean_architecture/core/clients/database/app_database.dart';
import 'package:clean_architecture/domain/models/error_log_entry.dart';

extension ErrorLogRowMapper on ErrorLogLocalData {
  ErrorLogEntry toDomain() => ErrorLogEntry(
    id: id,
    createdAt: createdAt,
    message: message,
    action: action,
    source: source,
    error: error,
    shown: shown,
  );
}
