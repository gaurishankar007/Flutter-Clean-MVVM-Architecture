import 'package:clean_architecture/core/clients/database/app_database.dart';
import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/errors/error_handler.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ErrorLogLocalService({required final AppDatabase _database}) {
  StreamData<List<ErrorLogLocalData>> watchAll() =>
      ErrorHandlerProvider.I.executeStream(
        (_database.select(
          _database.errorLogLocal,
        )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch(),
        action: 'errorLog.local.watchAll',
      );

  FutureVoid deleteAll() => ErrorHandlerProvider.I.execute(() async {
    await _database.delete(_database.errorLogLocal).go();
    return const SuccessState.nil(origin: .local);
  }, action: 'errorLog.local.deleteAll');
}
