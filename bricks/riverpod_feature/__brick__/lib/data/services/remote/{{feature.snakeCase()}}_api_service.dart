// Scaffold: the fields are unused until you add the first method.
// ignore_for_file: unused_field_from_primary_constructor
import 'package:clean_architecture/core/clients/remote/http/http_client.dart';
import 'package:injectable/injectable.dart';

/// Call endpoints through `ApiExecutor.call(..., action: '{{feature.camelCase()}}.api.<op>')`.
@lazySingleton
class const {{feature.pascalCase()}}ApiService({required final HttpClient _http});
