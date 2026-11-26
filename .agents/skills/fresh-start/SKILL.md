---
name: fresh-start
description: Interactively strips this template's example app (todo features, their data/domain code, database tables, base widgets, demo backend, branding) so a new app can start from the foundation, optionally renaming the app and package. Use when the user wants to start a new app from this template, reset/clean the example, or remove the todo demo.
---

# Fresh Start Skill

Turns the template into a clean starting point for a new app. **Always ask
before deleting anything**: the user picks, per part, whether to **keep**,
**remove** or **replace** it. Never delete in a single pass without the
confirmed plan from step 3.

Work on a new branch (`git checkout -b chore/fresh-start`) so everything can
be reverted, and tell the user the branch name.

## 1. Survey

Before asking, look at what exists now (the user may have run this before or
added their own code):

```bash
ls lib/ui/features lib/domain/models lib/domain/repositories lib/domain/use_cases
ls lib/data/repositories lib/data/services/* lib/core/clients/database/tables
ls lib/ui/core/ui/base
```

Only offer the parts that still exist.

## 2. Ask (use AskUserQuestion, multiSelect, 4 questions per call max)

Ask in rounds; each question names the parts and what removing them implies.

**Round 1 — feature modules** (each removes its UI, providers, and the data +
domain code listed in "Module map" below):

- Tasks (`todos`) — the list, detail and editor screens, the todo table and sync.
- Inbox (`notifications`) — the inbox tab, its table and the reminder logic.
- Profile (`profile`) — profile + edit profile, the user repository and photo picking.
- Onboarding (`onboarding`) — the 3-page intro.

**Round 2 — app skeleton:**

- Auth (`auth` + session) — login, session storage, token refresh, route
  guards. Removing it makes every screen public.
- Splash (`startup`) — the in-app splash screen (not the native launch
  splash, see Round 3). Removing it makes the home shell (or the first kept
  screen) the initial route.
- Home shell (`home`) — the bottom bar / sidebar. Removing it means a single
  home screen.
- Settings screen + error log (`settings`) — theme picker, error log viewer.
  (`appSettingsProvider` and the error log recorder always stay; they're core.)

**Round 3 — shared pieces:**

- Base widget groups no remaining code uses (`lib/ui/core/ui/base/<category>/`):
  list each unused category found with
  `grep -rl "ui/base/<category>/" lib --include=*.dart` (ignoring the
  category's own folder). Offer **remove unused** / **keep all**.
- Database tables of removed features (always removed with their feature;
  just confirm) and whether to keep the `key_value` / `error_log` tables
  (recommend keep: settings, session and the error log use them).
- Design tokens: keep the Aurora palette and fonts, or **replace** (ask for
  the new primary/gradient colours and font families, then update
  `app_colors.dart`, `app_gradients.dart`, `app_typography.dart`,
  `pubspec.yaml` fonts and `docs/design/design_system.md`).
- App icon and native splash: keep the to-do checkbox icon, or **replace**
  (ask for the user's art: a 1024×1024 icon, plus the adaptive background /
  foreground and monochrome layers if they have them; see "App icon and
  splash" below). If the design tokens are replaced, the splash and web
  manifest colours change with them either way.
- Demo backend: keep DummyJSON, or **replace** with the user's base URLs
  (update `AppConfig.demoBaseUrl`, `.env` and `.env.example`, remove the demo
  account card and `AuthMessages.demoHint/useDemo`).

**Round 4 — identity** (free-text answers via "Other"):

- App display name (`AppConfig*.appTitle`, `android/app/src/main/AndroidManifest.xml`
  label, iOS `CFBundleDisplayName`, `web/index.html` + `web/manifest.json`).
- Dart package name (replaces `clean_architecture` in `pubspec.yaml` and every
  `package:clean_architecture/` import, in `lib/`, `test/`, `testing/`,
  `patrol_test/`, `bricks/`, docs and skills).
- Android application id / iOS bundle id (`android/app/build.gradle.kts`
  `applicationId`, iOS `PRODUCT_BUNDLE_IDENTIFIER` per flavor, the `patrol:`
  block in `pubspec.yaml`).
- Whether to keep `README.md`'s template sections or reset it to a short
  project README.

## 3. Confirm the plan

Summarise every change as a checklist (files/folders to delete, files to
edit, renames) and ask once more before executing. Mention anything that will
stop working (e.g. "removing Auth also removes the guards; all routes become
public").

## 4. Execute, in this order

1. **Delete** the chosen modules' files (Module map), their tests in `test/`
   (mirrored paths) and their mocks in `testing/mocks/`.
2. **Fix couplings** (see table below) so nothing references removed code.
3. **Routing:** remove the deleted screens from `lib/routing/routes.dart`; set
   a valid `initial: true` route; drop the guards if Auth was removed; update
   `HomeShellScreen`'s `AutoTabsRouter.routes` and `NavDestination` to match
   the kept tabs (same order).
4. **Database:** remove deleted tables from `@DriftDatabase(tables: [...])`
   and delete their files. Schema 1 hasn't shipped, so no migration is needed.
5. **Messages:** delete the removed areas' classes from
   `lib/core/messages/app_messages.dart`, reset `kMessagesVersion` to `1` with
   a single "first catalog" changelog line.
6. **Nothing left to show?** If every feature screen was removed, generate a
   placeholder home: set `config.json` to `{"feature": "home", "notifier":
   "home", "view": "home"}` and run `mason make riverpod_view -c config.json`
   (see the `scaffolding` skill), route it as `initial: true`.
7. **Base widgets:** delete the unused categories the user chose.
8. **Replace** choices (tokens, backend, identity, icon) as answered.
9. `dart run build_runner build --delete-conflicting-outputs`,
   `dart fix --apply`, `dart format lib test testing patrol_test`.
10. `flutter analyze` (zero issues) and `flutter test`. Fix what breaks;
    never leave the template uncompilable.
11. **Docs:** delete `docs/features/<removed>.md`, remove their rows from the
    Docs Map (`docs/architecture/architecture.md`) and README, and update the
    project identity in `CLAUDE.md` + `.agents/AGENTS.md` (name, package,
    what the app is). Update `patrol_test/` to a test that matches what's left
    (or delete it and say so).

## App icon and splash

Sources are in `assets/icon/`, configs at the bottom of `pubspec.yaml`
(`flutter_launcher_icons`, `flutter_native_splash`). Sizes and roles:
`docs/design/design_system.md#app-icon-and-splash`.

- **Replace:** put the user's images in `assets/icon/` under the same file
  names (`app_icon.png`, `app_icon_background.png`, `app_icon_foreground.png`,
  `app_icon_monochrome.png`, `splash.png`, `splash_android12.png`). If they
  only have one icon image, use it for `app_icon.png` and `splash.png`, drop
  the `adaptive_icon_*` lines and the `android_12: image:` line from the
  configs, and tell them which layers are still missing.
- **New tokens:** set `color` / `color_dark` (both places) in
  `flutter_native_splash` to the new light/dark `background` tokens, and the
  `web:` `background_color` / `theme_color` in `flutter_launcher_icons`.
- Then run `dart run flutter_launcher_icons` and
  `dart run flutter_native_splash:create`, and revert the two iOS side
  effects listed in `docs/architecture/development.md#app-icon-and-splash`
  (`project.pbxproj`, `Info.plist`).
- A bundle id change doesn't need a regeneration; a new platform added with
  `flutter create` does.

## Module map

Paths are under `lib/`. "Shared" files stay unless every module using them goes.

| Module | UI | Domain | Data | Tables |
| --- | --- | --- | --- | --- |
| Tasks | `ui/features/todos/` | `models/todo*.dart`, `subtask.dart`, `repositories/todo_repository.dart`, `use_cases/save_todo_use_case.dart`, `set_todo_completed_use_case.dart`, `sync_todos_use_case.dart` | `repositories/todo_repository_impl.dart`, `services/local/todo_local_service.dart`, `services/remote/todo_api_service.dart`, `models/responses/todo_response.dart`, `models/mappers/todo_mapper.dart` | `todo_local.dart` |
| Inbox | `ui/features/notifications/` | `models/app_notification.dart`, `repositories/notification_repository.dart` | `repositories/notification_repository_impl.dart`, `services/local/notification_local_service.dart`, `models/mappers/notification_mapper.dart` | `notification_local.dart` |
| Profile | `ui/features/profile/` | `repositories/user_repository.dart` (shared with Auth: keep if Auth stays) | `repositories/user_repository_impl.dart`, `services/remote/user_api_service.dart`, `services/platform/image_picker_service.dart`, `models/requests/update_user_request.dart` | — |
| Onboarding | `ui/features/onboarding/` | `AppSettings.onboardingSeen` | — | — |
| Auth | `ui/features/auth/`, `ui/core/providers/session/`, `ui/core/ui/base/avatar/` (if Profile also goes) | `models/user.dart`, `session.dart`, `repositories/auth_repository.dart`, `user_repository.dart`, `use_cases/login_use_case.dart`, `logout_use_case.dart` | `repositories/auth_repository_impl.dart`, `services/local/session_local_service.dart`, `services/remote/auth_api_service.dart`, `models/requests/login_request.dart`, `models/responses/login_response.dart`, `user_response.dart`, `models/local/session_local.dart`, `user_local.dart`, `core/clients/remote/http/token_store.dart`, `http_auth_interceptor.dart` (or keep the interceptor without refresh), `routing/guards/` | — |
| Splash | `ui/features/startup/` | — | — | — |
| Home shell | `ui/features/home/` | — | — | — |
| Settings | `ui/features/settings/` | `models/error_log_entry.dart`, `repositories/error_log_repository.dart`, `app_info_repository.dart` | `repositories/error_log_repository_impl.dart`, `app_info_repository_impl.dart`, `services/local/error_log_local_service.dart`, `services/platform/app_info_service.dart`, `models/mappers/error_log_mapper.dart` | — (keep `error_log`: the recorder writes it) |

Always kept (the foundation): `config/`, `core/` (data states, errors,
`ErrorFlow`, `ApiExecutor`, `RepositoryFetcher`, connectivity, HTTP client,
database with `key_value` + `error_log`, message catalog, types, utils),
`ui/core/providers/base/`, `screen_type/`, `connectivity/`, `settings/`
(`appSettingsProvider`), `ui/core/themes/`, `ui/core/utils/`,
`ui/application.dart`, `ui/startup/`, the settings repository/service, the
bricks, skills, CI and docs structure.

## Couplings to fix

| If you remove | Also update |
| --- | --- |
| Tasks | `ProfileStatsRow` (profile), `TaskSettingsSection` "Clear completed" + `SettingsNotifier.clearCompleted`, `LoginUseCase` (sync step), `LogoutUseCase` (clear tasks), `SyncTodosUseCase` reminders, `NavDestination.tasks`, `TodosHeader` avatar link, `AppSettings.dueReminders` + its tile |
| Inbox | `LoginUseCase` (welcome), `SaveTodoUseCase` / `SetTodoCompletedUseCase` / `SyncTodosUseCase` (notifications), `LogoutUseCase`, `HomeShellScreen` badge + `unreadCountProvider`, `NavDestination.notifications`, `NotificationGroup` task links |
| Profile | `NavDestination.profile`, logout button (move it to Settings if Auth stays), `TodosHeader` avatar |
| Onboarding | `SplashNotifier` (no onboarding step), `AppSettings.onboardingSeen` |
| Auth | `AppInitializer` (session load), `SessionNotifier` + its listen in `application.dart`, `HttpClientImpl` (drop the interceptor or keep only the header part), splash destinations, guards in `routes.dart`, `TodosHeader` user greeting |
| Splash | `initial: true` moves to the next first screen; onboarding/auth redirects happen in guards or the home screen instead |
| Home shell | Push targets that use `context.navigateTo(...Route())` for tabs |

## 5. Report

List what was removed, replaced and kept, the branch name, analyze/test
results, and anything the user still has to do by hand (e.g. supply the
missing icon layers, set new GitHub secrets, run `flutter create .` for platforms after a
bundle id change). Don't commit unless the user asks.
