import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/data/models/mappers/error_log_mapper.dart';
import 'package:clean_architecture/data/services/local/error_log_local_service.dart';
import 'package:clean_architecture/domain/models/error_log_entry.dart';
import 'package:clean_architecture/domain/repositories/error_log_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ErrorLogRepository)
final class ErrorLogRepositoryImpl({required final ErrorLogLocalService _local})
    implements ErrorLogRepository {
  @override
  StreamData<List<ErrorLogEntry>> watchEntries() => _local.watchAll().map(
    (state) => state.mapData((rows) => rows.map((r) => r.toDomain()).toList()),
  );

  @override
  FutureVoid clear() => _local.deleteAll();
}
