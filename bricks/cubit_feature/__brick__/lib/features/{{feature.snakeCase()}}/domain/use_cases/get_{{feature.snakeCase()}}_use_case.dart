import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/domain/use_cases/use_case.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/features/{{feature.snakeCase()}}/domain/repositories/{{feature.snakeCase()}}_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class Get{{feature.pascalCase()}}UseCase({
  required final {{feature.pascalCase()}}Repository _{{feature.camelCase()}}Repository,
}) implements UseCase<String, String> {
  @override
  FutureData<String> call(String request) async => const SuccessState(data: '');
}
