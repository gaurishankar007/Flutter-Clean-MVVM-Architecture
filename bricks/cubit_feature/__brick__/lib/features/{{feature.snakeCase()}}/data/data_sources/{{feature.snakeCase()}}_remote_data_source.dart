import 'package:clean_architecture/core/clients/remote/http/http_client.dart';
import 'package:clean_architecture/core/data/operations/api_executor.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:injectable/injectable.dart';

abstract interface class {{feature.pascalCase()}}RemoteDataSource;

@LazySingleton(as: {{feature.pascalCase()}}RemoteDataSource)
final class const {{feature.pascalCase()}}RemoteDataSourceImpl({
  required final HttpClient _httpClient,
}) implements {{feature.pascalCase()}}RemoteDataSource;
