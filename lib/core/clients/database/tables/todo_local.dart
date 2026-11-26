import 'package:drift/drift.dart';

/// Tasks. Example feature table: remove it with the todo feature.
class TodoLocal extends Table {
  @override
  String get tableName => 'todos';

  @override
  Set<Column<Object>> get primaryKey => {id};

  TextColumn get id => text()();
  IntColumn get remoteId => integer().nullable().unique()();
  TextColumn get title => text()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();

  /// `TodoPriority.name` / `TodoCategory.name`.
  TextColumn get priority => text()();
  TextColumn get category => text()();
  DateTimeColumn get dueAt => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();

  /// JSON list of `{id, title, isDone}`.
  TextColumn get subtasks => text().withDefault(const Constant('[]'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
