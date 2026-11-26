import 'package:clean_architecture/config/injector/injector.config.dart';
import 'package:clean_architecture/core/clients/database/app_database.dart';
import 'package:clean_architecture/core/errors/error_handler.dart';
import 'package:clean_architecture/core/errors/error_recorders/app_error_recorder.dart';
import 'package:clean_architecture/core/errors/error_recorders/logger_error_recorder.dart';
import 'package:clean_architecture/core/errors/error_translators/dio_error_translator.dart';
import 'package:clean_architecture/core/errors/error_translators/drift_error_translator.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(initializerName: 'initialize')
Future<void> configureDependencies({required String environment}) async {
  // Order matters: the error log needs the database, the handler needs both.
  final database = AppDatabaseProvider.register();
  AppErrorProvider.register(database);
  ErrorHandlerProvider.register(
    errorTranslators: [DioErrorTranslator(), DriftErrorTranslator()],
    errorRecorders: [AppErrorProvider.I, LoggerErrorRecorder()],
  );
  GetIt.I.initialize(environment: environment);
}
