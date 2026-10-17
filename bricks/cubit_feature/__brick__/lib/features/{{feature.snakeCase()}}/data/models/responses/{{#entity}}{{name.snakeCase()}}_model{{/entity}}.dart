import 'package:clean_architecture/core/data/models/domain_convertible.dart';
import 'package:clean_architecture/features/{{feature.snakeCase()}}/domain/entities/{{#entity}}{{name.snakeCase()}}{{/entity}}.dart';

{{#entity}}
class const {{name.pascalCase()}}Response({
  {{#variables}}
  required final {{{type}}} {{name.camelCase()}},
  {{/variables}}
}) implements DomainConvertible<{{name.pascalCase()}}> {
  @override
  {{name.pascalCase()}} toDomain() {
    return {{name.pascalCase()}}(
      {{#variables}}
      {{name.camelCase()}}: {{name.camelCase()}},
      {{/variables}}
    );
  }
}
{{/entity}}