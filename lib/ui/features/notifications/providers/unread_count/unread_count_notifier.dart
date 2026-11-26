import 'package:clean_architecture/domain/repositories/notification_repository.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Unread inbox entries, for the tab badge.
class UnreadCountNotifier extends BaseStreamNotifier<int> {
  @override
  Stream<int> build() => GetIt.I<NotificationRepository>().watchUnreadCount();
}

final unreadCountProvider = StreamNotifierProvider(UnreadCountNotifier.new);
