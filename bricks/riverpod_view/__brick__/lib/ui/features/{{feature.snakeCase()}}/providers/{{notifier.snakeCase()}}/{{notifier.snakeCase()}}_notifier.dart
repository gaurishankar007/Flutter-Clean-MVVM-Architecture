import 'package:clean_architecture/domain/repositories/{{feature.snakeCase()}}_repository.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';
import 'package:clean_architecture/ui/features/{{feature.snakeCase()}}/providers/{{notifier.snakeCase()}}/{{notifier.snakeCase()}}_state.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class {{notifier.pascalCase()}}Notifier extends BaseNotifier<{{notifier.pascalCase()}}State> {
  // Scaffold: used by the first method you add.
  // ignore: unused_field
  late final {{feature.pascalCase()}}Repository _repository;

  @override
  {{notifier.pascalCase()}}State build() {
    _repository = GetIt.I<{{feature.pascalCase()}}Repository>();
    return const {{notifier.pascalCase()}}State();
  }
}

final {{notifier.camelCase()}}Provider = NotifierProvider.autoDispose({{notifier.pascalCase()}}Notifier.new);
