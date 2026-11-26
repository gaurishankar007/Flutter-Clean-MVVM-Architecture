# Routing

Files: `lib/routing/routes.dart`, `lib/routing/guards/`. Uses [auto_route](https://pub.dev/packages/auto_route); `routes.gr.dart` is generated.

## Route Tree

| Path | Screen | Guard |
| --- | --- | --- |
| `/` (initial) | `SplashScreen` | — |
| `/onboarding` | `OnboardingScreen` | — |
| `/login` | `LoginScreen` | `UnauthenticatedGuard` |
| `/home` | `HomeShellScreen` (tabs) | `AuthenticatedGuard` |
| `/home/tasks` (initial tab) | `TodosScreen` | inherited |
| `/home/inbox` | `NotificationsScreen` | inherited |
| `/home/profile` | `ProfileScreen` | inherited |
| `/home/settings` | `SettingsScreen` | inherited |
| `/tasks/editor?id=<id>` | `TodoEditorScreen` (no `id`: new task) | `AuthenticatedGuard` |
| `/tasks/:todoId` | `TodoDetailScreen` | `AuthenticatedGuard` |
| `/profile/edit` | `EditProfileScreen` | `AuthenticatedGuard` |
| `/settings/error-log` | `ErrorLogScreen` | — |
| `*` | redirects to `/` | — |

Screen classes end in `Screen`; `replaceInRouteName: 'Screen,Route'` turns `TodoDetailScreen` into `TodoDetailRoute`. Route names must be unique, so one screen can't have two route entries: the editor uses an optional query parameter (`@QueryParam('id')`) instead of two paths. Path parameters use `@PathParam('todoId')` on the screen's constructor parameter.

Full-screen pages are top-level routes (above the tab shell), so they cover the bottom bar.

## Navigating

Only Views navigate, with `context.router`:

```dart
context.router.push(TodoDetailRoute(todoId: todo.id));   // open
context.router.replace(TodoDetailRoute(todoId: id));     // swap the current page
context.router.root.replaceAll([const LoginRoute()]);    // reset the stack (logout)
context.navigateTo(const ProfileRoute());                 // switch tab
```

A Notifier returns a result (`Future<bool>`, an id, an enum) and the View decides where to go.

## Guards

- `AuthenticatedGuard`: lets a signed-in user through, otherwise redirects to `/login`.
- `UnauthenticatedGuard`: sends a signed-in user from `/login` to `/home`.

Both read `AuthRepository.isLoggedIn`, which is synchronous because the session is loaded into memory at startup.

## Session Expiry

When a token refresh fails, `HttpAuthInterceptor` expires the session (`TokenStore.expire()`), `SessionNotifier` sets `expired: true` with a message, and the root widget shows it and replaces the stack with `/login`. Nothing in the data layer navigates.
