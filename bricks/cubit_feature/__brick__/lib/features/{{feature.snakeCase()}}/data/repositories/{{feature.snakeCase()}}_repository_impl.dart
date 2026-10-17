import 'package:clean_architecture/core/clients/remote/connectivity_client.dart';
import 'package:clean_architecture/core/data/operations/repository_fetcher.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/features/{{feature.snakeCase()}}/data/data_sources/{{feature.snakeCase()}}_local_data_source.dart';
import 'package:clean_architecture/features/{{feature.snakeCase()}}/data/data_sources/{{feature.snakeCase()}}_remote_data_source.dart';
import 'package:clean_architecture/features/{{feature.snakeCase()}}/domain/repositories/{{feature.snakeCase()}}_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: {{feature.pascalCase()}}Repository)
final class {{feature.pascalCase()}}RepositoryImpl({
  required final ConnectivityClient _internet,
  required final {{feature.pascalCase()}}RemoteDataSource _remoteDataSource,
  required final {{feature.pascalCase()}}LocalDataSource _localDataSource,
}) implements {{feature.pascalCase()}}Repository;
