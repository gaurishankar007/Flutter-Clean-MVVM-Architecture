# Inbox (example)

Files: `lib/ui/features/notifications/`, `lib/domain/models/app_notification.dart`, `lib/domain/repositories/notification_repository.dart`, `lib/data/repositories/notification_repository_impl.dart`, `lib/data/services/local/notification_local_service.dart`.

Local, in-app notifications stored in the `notifications` table:

| Type | Created by |
| --- | --- |
| `welcome` | `LoginUseCase` (id `welcome`, once) |
| `todoCreated` | `SaveTodoUseCase` for a new task |
| `todoCompleted` | `SetTodoCompletedUseCase` |
| `dueToday` / `overdue` | `SyncTodosUseCase` when Due reminders is on (once per task per day) |

`NotificationRepository.add` inserts only if the id doesn't exist, so reminders are idempotent and keep their read state.

## Screen

`/home/inbox`: a header, **Mark all read** and **Clear all** (confirmed), then **New** (unread) and **Earlier** groups. Each `NotificationTile` has a type icon and colour, title, body, time and an unread dot. Tapping marks it read and opens its task.

`unreadCountProvider` (a `BaseStreamNotifier<int>` over a drift count query) drives the badge on the Inbox tab.

This is where push notifications would plug in: a platform service receiving FCM/APNs messages would write entries through the same repository.
