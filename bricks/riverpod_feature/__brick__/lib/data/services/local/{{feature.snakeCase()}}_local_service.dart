// Scaffold: the fields are unused until you add the first method.
// ignore_for_file: unused_field_from_primary_constructor
import 'package:clean_architecture/core/clients/database/app_database.dart';
import 'package:injectable/injectable.dart';

/// Wrap every call in `ErrorHandlerProvider.I.execute(..., action: '{{feature.camelCase()}}.local.<op>')`.
@lazySingleton
class const {{feature.pascalCase()}}LocalService({required final AppDatabase _database});
