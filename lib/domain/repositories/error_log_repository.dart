import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/domain/models/error_log_entry.dart';

abstract interface class ErrorLogRepository {
  StreamData<List<ErrorLogEntry>> watchEntries();

  FutureVoid clear();
}
