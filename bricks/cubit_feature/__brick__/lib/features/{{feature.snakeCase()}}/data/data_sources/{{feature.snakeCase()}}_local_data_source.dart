import 'package:clean_architecture/core/clients/local/local_storage_client.dart';
import 'package:clean_architecture/core/errors/error_handler.dart';
import 'package:injectable/injectable.dart';

abstract interface class {{feature.pascalCase()}}LocalDataSource;

@LazySingleton(as: {{feature.pascalCase()}}LocalDataSource)
final class const {{feature.pascalCase()}}LocalDataSourceImpl({
  required final ErrorHandler _errorHandler,
  required final LocalStorageClient _localDatabase,
}) implements {{feature.pascalCase()}}LocalDataSource;
