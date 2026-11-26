// Scaffold: the fields are unused until you add the first method.
// ignore_for_file: unused_field_from_primary_constructor
import 'package:clean_architecture/core/clients/remote/connectivity_client.dart';
import 'package:clean_architecture/data/services/local/{{feature.snakeCase()}}_local_service.dart';
import 'package:clean_architecture/data/services/remote/{{feature.snakeCase()}}_api_service.dart';
import 'package:clean_architecture/domain/repositories/{{feature.snakeCase()}}_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: {{feature.pascalCase()}}Repository)
final class const {{feature.pascalCase()}}RepositoryImpl({
  required final {{feature.pascalCase()}}ApiService _api,
  required final {{feature.pascalCase()}}LocalService _local,
  required final ConnectivityClient _connectivity,
}) implements {{feature.pascalCase()}}Repository;
