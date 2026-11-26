import 'package:drift/drift.dart';

/// Inbox entries. Example feature table: remove it with the notifications feature.
class NotificationLocal extends Table {
  @override
  String get tableName => 'notifications';

  @override
  Set<Column<Object>> get primaryKey => {id};

  TextColumn get id => text()();

  /// `NotificationType.name`.
  TextColumn get type => text()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  TextColumn get todoId => text().nullable()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
}
