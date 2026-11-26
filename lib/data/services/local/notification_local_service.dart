import 'package:clean_architecture/core/clients/database/app_database.dart';
import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/errors/error_handler.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NotificationLocalService({required final AppDatabase _database}) {
  $NotificationLocalTable get _table => _database.notificationLocal;

  StreamData<List<NotificationLocalData>> watchAll() =>
      ErrorHandlerProvider.I.executeStream(
        (_database.select(
          _table,
        )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch(),
        action: 'notification.local.watchAll',
      );

  Stream<int> watchUnreadCount() {
    final count = _table.id.count();
    final query = _database.selectOnly(_table)
      ..addColumns([count])
      ..where(_table.isRead.equals(false));
    return query.map((row) => row.read(count) ?? 0).watchSingle();
  }

  /// Keeps an existing row with the same id (and its read state).
  FutureVoid insertIfAbsent(NotificationLocalCompanion notification) =>
      ErrorHandlerProvider.I.execute(() async {
        await _database
            .into(_table)
            .insert(notification, mode: InsertMode.insertOrIgnore);
        return const SuccessState.nil(origin: .local);
      }, action: 'notification.local.insert');

  FutureVoid markRead(String? id) => ErrorHandlerProvider.I.execute(() async {
    final update = _database.update(_table);
    if (id != null) {
      update.where((t) => t.id.equals(id));
    }
    await update.write(const NotificationLocalCompanion(isRead: Value(true)));
    return const SuccessState.nil(origin: .local);
  }, action: 'notification.local.markRead');

  FutureVoid deleteAll() => ErrorHandlerProvider.I.execute(() async {
    await _database.delete(_table).go();
    return const SuccessState.nil(origin: .local);
  }, action: 'notification.local.deleteAll');
}
