import 'package:clean_architecture/core/clients/database/tables/error_log_local.dart';
import 'package:clean_architecture/core/clients/database/tables/key_value_local.dart';
import 'package:clean_architecture/core/clients/database/tables/notification_local.dart';
import 'package:clean_architecture/core/clients/database/tables/todo_local.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// The app's one local database. See docs/core/local_database.md.
// Schema 1 hasn't shipped: change it in place until the first release. After
// that, every change bumps schemaVersion with its own onUpgrade step.
@DriftDatabase(
  tables: [KeyValueLocal, ErrorLogLocal, TodoLocal, NotificationLocal],
)
final class AppDatabase([QueryExecutor? executor]) extends _$AppDatabase {
  this : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(onCreate: (migrator) => migrator.createAll());

  static QueryExecutor _openConnection() => driftDatabase(
    name: 'clean_architecture',
    native: const DriftNativeOptions(
      databaseDirectory: getApplicationSupportDirectory,
    ),
    // Web: web/sqlite3.wasm and web/drift_worker.js ship with the app.
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}

/// Access to the [AppDatabase] singleton.
abstract final class AppDatabaseProvider {
  static AppDatabase get I => GetIt.I<AppDatabase>();

  static AppDatabase register([AppDatabase? database]) =>
      GetIt.I.registerSingleton<AppDatabase>(database ?? AppDatabase());
}
