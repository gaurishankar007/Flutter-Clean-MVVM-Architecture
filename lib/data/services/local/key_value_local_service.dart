import 'dart:convert';

import 'package:clean_architecture/core/clients/database/app_database.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:injectable/injectable.dart';

/// JSON values in the `key_value` table. Throws; callers wrap it in
/// `ErrorHandler`.
@lazySingleton
class KeyValueLocalService({required final AppDatabase _database}) {
  Future<JsonMap?> read(String key) async {
    final row = await (_database.select(
      _database.keyValueLocal,
    )..where((t) => t.key.equals(key))).getSingleOrNull();
    return row == null ? null : jsonDecode(row.value) as JsonMap;
  }

  Future<void> write(String key, JsonMap value) => _database
      .into(_database.keyValueLocal)
      .insertOnConflictUpdate(
        KeyValueLocalCompanion.insert(key: key, value: jsonEncode(value)),
      );

  Future<void> remove(String key) => (_database.delete(
    _database.keyValueLocal,
  )..where((t) => t.key.equals(key))).go();
}
