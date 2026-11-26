# Clean Architecture Flutter Template — Claude Code Rules (CLAUDE.md)

> These rules apply to Claude Code working in this workspace. Follow them strictly.
> `.agents/AGENTS.md` holds the same rules for other agents; keep the two in sync.

---

## 1. Project Identity

- **What it is:** a starter template for new Flutter apps. It ships a working example app (a detailed to-do app) that shows every layer and pattern end to end. Start a new app with the `fresh-start` skill, which removes the example and keeps the foundation.
- **Architecture:** Clean Architecture + MVVM, following Flutter's official [app architecture guide](https://docs.flutter.dev/app-architecture): a UI layer (Views + ViewModels as Riverpod Notifiers), an optional domain layer (use cases), and a data layer (repositories + services). See `docs/architecture/architecture.md`.
- **Stack:** Riverpod 3 (`hooks_riverpod`), get_it + injectable, auto_route, dio, drift, flutter_hooks.
- **Platforms:** Android, iOS, Web.
- **Flavors:** `development`, `staging`, `production`. Entry points: `lib/main_dev.dart`, `lib/main_stg.dart`, `lib/main.dart`.
- **Package name:** `clean_architecture`.
- **Previous version:** the Cubit (flutter_bloc), feature-first version of this template is kept at the git tag `cubit-template`.

---

## 2. Mandatory Rules (Never Violate)

- **BEFORE** any task, read the **relevant** docs in `docs/` (only what the task needs). Start from the Docs Map in `docs/architecture/architecture.md`.
- **NEVER** update `docs/` or tests (new or existing) as part of a code change without **asking the user first**. Make the change, stop, and let the user try it; changes often need more rounds, and docs/tests written early are wasted. Only after the user says the change is final, ask whether to update the docs and tests, and do both in one pass. Approval to *implement* ("go ahead", "work on it") is **not** approval to write docs or tests. The only exception is a task that is itself a docs or test task (e.g. "fix this doc", "add a test for X").
- **ALWAYS** write code for the SDK installed on this machine (currently Dart 3.14 / Flutter 3.50), using its newest idioms (see "Modern Dart & Flutter" below). If the installed Dart/Flutter is newer than `pubspec.yaml`'s `environment` lower bounds, tell the user and offer to upgrade before writing feature code; never bump the SDK silently.
- **NEVER** use relative imports. Always `package:clean_architecture/...` (enforced by `always_use_package_imports`).
- **NEVER** import a platform-split `*_mobile.dart` / `*_web.dart` file directly. Import its facade (the file without the suffix that conditionally exports the right variant). When adding a split, create the facade too: `export '<name>_mobile.dart' if (dart.library.js_interop) '<name>_web.dart';`
- **NEVER** write business logic in Views or widgets. It belongs in Notifiers (ViewModels), use cases and repositories. That includes validation, filtering, sorting and grouping.
- **NEVER** call a service, `HttpClient`, dio, drift or a platform plugin from a Notifier or View. Notifiers talk to repositories and use cases only.
- **NEVER** add platform-specific code under `lib/ui/`. Route it through `lib/data/services/platform/`.
- **NEVER** use `void` as the return type of an `async` method. Use `Future<void>` (enforced by `avoid_void_async`).
- **NEVER** add a `Co-Authored-By: Claude ...` (or similar AI-attribution) trailer to commit messages.

---

## 3. Code Style

This project uses `leancode_lint` (see `analysis_options.yaml`) plus a few extra rules.

- Single quotes; `const` wherever possible; `if`/`for`/`while` bodies on a new line; constructors first in a class; method tear-offs over lambdas.
- **Comments:** short, single-line where possible, and only for the non-obvious *why* (an edge case, a workaround, a load-bearing ordering).
- **Post-frame callbacks:** use `runAfterBuild(...)` (`lib/ui/core/utils/frame_callback.dart`), not `WidgetsBinding.instance.addPostFrameCallback` directly.
- Run `dart format lib test testing` before finishing.

### Modern Dart & Flutter (Dart 3.14 / Flutter 3.50)

- **Primary constructors:** fields and constructor go in the class header: `class const TodoCard({super.key, required final Todo todo}) extends StatelessWidget { ... }`. Private fields are private named parameters (`required final TodoRepository _repository`); callers still pass `repository:`. Put `super(...)`/asserts in the body as `this : ...;`; extra constructors are `new name(...)` / `factory name(...)`. A class with no constructor stays plain (`use_primary_constructors` is off on purpose).
- **Empty bodies** end with `;`: `class MockTodoRepository extends Mock implements TodoRepository;`.
- **Dot shorthands** where the context type is exact: `mainAxisAlignment: .center`, `padding: const .all(8)`, `borderRadius: .circular(8)`, `status: .loading`. Keep the type name when the context is a supertype or there is none.
- **Null-aware elements** `[?maybeItem]` / `{'key': ?value}` instead of `if (x != null) x`; wildcard `_` for unused parameters.
- **Patterns:** switch expressions over `if`/`else` ladders, `if (x case final T y)` to test and bind, `sealed` hierarchies with exhaustive `switch` (no "unknown subtype" fallback), records for small multi-value returns.
- **`Future.syncValue(x)`** instead of `Future.value(x)` for an already-available value.
- **Material** comes from `package:material_ui/material_ui.dart`, never `package:flutter/material.dart`. Icons come from `material_symbols_icons` (`Symbols.*_rounded`).
- **No deprecated APIs** (e.g. `withValues(alpha:)`, not `withOpacity`); never silence `deprecated_member_use`.
- Never hand-edit generated files (`*.g.dart`, `*.gr.dart`, `*.config.dart`).

---

## 4. Architecture Rules

### State Management (ViewModels)

- Every ViewModel extends `BaseNotifier` / `BaseAsyncNotifier` / `BaseStreamNotifier` (`lib/ui/core/providers/base/base_notifier.dart`); every state extends `BaseState` (`StateStatus` + `StateMessage`).
- **`copyWith` never keeps the previous `message`**: use the argument directly (`message: message`, never `message ?? this.message`), so each message is shown exactly once. `StateMessage` subclasses stay `Equatable` (tests compare them).
- Notifiers get repositories and use cases from get_it (`GetIt.I<TodoRepository>()`) in `build()`.
- **Error messages go through the error log.** A notifier runs each user flow in `runFlow('<feature>.<flow>', () async { ... })` and surfaces an error with `trackFailure(dataState)` or `trackError(text)`, never a bare `ErrorMessage(...)` for a failure. Outside a `runFlow` closure pass `action: '...'` explicitly. Every `ErrorHandler.execute`/`ApiExecutor.*` call passes an `action:` label naming the exact operation (`'todo.local.upsert'`), different from the flow label, so the log's action path shows which step failed. See `docs/core/error_handling.md`.
- **User-facing text comes from the message catalog** (`lib/core/messages/app_messages.dart`): toasts, labels, empty/error states, validator errors, semantic labels. Never write a user-facing string literal at the call site. When a message is added, removed or reworded, bump `kMessagesVersion` and add a changelog line. See `docs/core/app_messages.md`.
- **Toasts, dialogs and navigation are View-only.** A Notifier never calls `ToastUtil`, opens a dialog or navigates. It sets state (`message`, a status, an error text) and returns a result (`Future<bool>`, an id, an enum); the View reacts with `ref.listenMessages(provider, context)` / `ref.listen` and navigates with `context.router`.
- `ref.listen`/`ref.listenMessages` use the `ref` of the widget or builder they're called in, at the top of its `build`, never a `ref` captured from an outer scope.
- A Notifier that calls another notifier captures it once in `build()` (a nullable field), never through a lazy getter or an inline `ref.read` at the call site.
- In `.autoDispose` notifiers, check `ref.mounted` before touching `state` after an `await`.
- App-wide state (session, settings, connectivity, screen type) lives in keep-alive providers under `lib/ui/core/providers/`. Screen state is `.autoDispose` (`.family` when keyed by an id).

### UI Widgets

- **One widget per file**, named after it. Extract widgets as classes, never `_buildX()` methods.
- Prefer `ConsumerWidget` / `HookConsumerWidget` / `ConsumerStatefulWidget`; use plain `StatelessWidget` when the widget reads no providers. Use `flutter_hooks` for controllers (`useTextEditingController`, `usePageController`).
- **Design-system widgets** live in `lib/ui/core/ui/base/<category>/` and take plain props only, never a Notifier or `Ref`. Before adding one, check whether an existing widget can take a parameter instead.
- **Colours, text styles, spacing, radius and motion come from the tokens** in `lib/ui/core/themes/` (`context.colors`, `context.text`, `AppSpacing`, `AppRadius`, `AppMotion`, `AppGradients`). Never write a hex colour, a raw `TextStyle` or a raw font size in a widget. See `docs/design/design_system.md`.
- Messages use `ToastUtil`, never a `SnackBar`.
- Widget tiers: one screen → `views/<screen>/widgets/`; several screens of one feature → `<feature>/widgets/`; several features → `lib/ui/core/ui/base/<category>/`. Promote a widget only once a second real consumer needs it.
- Screens (`@RoutePage()`) stay thin: they listen for messages and compose extracted widgets.

### Dependency Injection

- `@injectable`, `@lazySingleton`, `@singleton` (`@LazySingleton(as: Contract)` for repository implementations). `AppDatabase`, `AppErrorRecorder` and `ErrorHandler` are registered by hand first in `configureDependencies` because everything depends on them.
- Run `dart run build_runner build` after changing any injectable class, route or drift table.

### Data Layer

- **Services** do one kind of I/O each (`local/` drift and key-value, `remote/` HTTP, `platform/` plugins) and wrap every call in `ErrorHandler.execute(..., action:)` or `ApiExecutor.call(..., action:)`. They return DTOs or drift rows.
- **Repositories** are the only thing ViewModels and use cases talk to. They map DTOs to domain models (`DomainConvertible.toDomain()`, or mapper extensions for drift rows) and return `DataState<T>` (`FutureData`, `FutureList`, `FutureVoid`, `StreamData`).
- **Use cases** (optional, `lib/domain/use_cases/`) combine several repositories for one flow (e.g. `LoginUseCase`: log in → sync tasks → welcome notification). A flow that only calls one repository doesn't need one.
- `FutureVoid` methods return `const SuccessState.nil()` on success, never `SuccessState(data: null)`. Use `FutureVoid` (not `FutureBool`) when no caller reads the bool.
- Check `ConnectivityClient.isConnected` before remote calls; use `RepositoryFetcher` for offline-first reads.
- Use `HttpKeys` for header names and `Options(extra: ...)` flags, `ApiEndpoints` for paths, `AppConfig` (flavor + `.env`) for base URLs. Never hardcode a URL.
- Import shared typedefs (`FutureData`, `FutureVoid`, `JsonMap`, ...) from `lib/core/types/types.dart`.
- **Local database:** schema 1 hasn't shipped, so tables can still change in place. From the first release on, every `schemaVersion` bump gets an explicit `onUpgrade` step and an exported schema snapshot (`dart run drift_dev make-migrations`); never delete exported snapshots. See `docs/core/local_database.md`.

---

## 5. Project Structure

```
lib/
├── config/            # AppConfig (flavors), injector
├── core/              # app-agnostic: clients (database, http, connectivity), data states,
│                      # operations, errors, messages, types, utils, app_initializer
├── data/
│   ├── models/        # requests/, responses/ (DTOs), local/ (stored JSON), mappers/ (drift rows)
│   ├── repositories/  # repository implementations
│   └── services/      # local/, remote/, platform/
├── domain/
│   ├── models/        # pure entities
│   ├── repositories/  # abstract contracts
│   └── use_cases/     # optional flows over several repositories
├── routing/           # AppRouter (auto_route) + guards
└── ui/
    ├── core/          # providers/ (base, session, settings, ...), themes/, ui/base/, utils/
    ├── features/<feature>/
    │   ├── models/    # UI-only models and presentation extensions
    │   ├── providers/ # Notifiers (ViewModels) + states
    │   ├── widgets/   # shared by this feature's screens
    │   └── views/<screen>/
    │       ├── <screen>_screen.dart
    │       └── widgets/   # this screen only
    ├── startup/       # runCleanArchitectureApp, StartupErrorApp
    └── application.dart
```

**When to use Mason instead of writing manually** (see the `scaffolding` skill):

- New feature (data + domain + UI) → `mason make riverpod_feature -c config.json`
- New screen + Notifier in an existing feature → `mason make riverpod_view -c config.json`
- New domain model + DTOs → `mason make domain_data_model -c config.json`

---

## 6. Testing Rules

See [`docs/testing/testing.md`](docs/testing/testing.md) before writing tests.

- Unit/widget tests live in `test/`, mirroring `lib/`.
- **Issue regression tests** go in `test/regression/`, one `issue_<number>_<short_name>_test.dart` per GitHub issue, tagged `@Tags(['regression'])`.
- Mock with `mocktail` (never mockito); shared mocks in `testing/mocks/`, shared helpers in `testing/helpers/`. When adding a testable class, add its mock there.
- Notifier tests use a `ProviderContainer` (`testing/helpers/provider_container.dart`) with mocks registered in get_it; assert on states and on returned values, not on navigation (that belongs in the screen's widget test).
- Widget tests use `patrol_finders` (`patrolWidgetTest`), not plain `flutter_test` finders.
- Integration tests live in `patrol_test/` using Patrol.
- If coverage requirements are ambiguous, ask the user.
- Follow the ask-first rule in "Mandatory Rules": run the existing tests to check nothing broke, but don't add or rewrite tests for a change until the user confirms it's final.

---

## 7. Code Generation

```bash
dart run build_runner build   # routes, DI, drift
```

---

## 8. Available Custom Skills

Skills live in `.claude/skills/` (and `.agents/skills/` for other agents):

- **`codegen`** — runs `build_runner`.
- **`scaffolding`** — Mason bricks for features, screens and models.
- **`api-integration`** — adds an API endpoint through service → repository → domain → Notifier.
- **`testing`** — runs the unit, widget, regression and Patrol suites.
- **`fresh-start`** — interactively removes the example app (features, tables, repositories, base widgets...) so a new app can start from the foundation, optionally renaming the app and package.

`.claude/workflows/release.md` documents how a release reaches testers; consult it before proposing or running any release step.

---

## 9. CI/CD

- Composite actions in `.github/actions/`: `setup-flutter` (Java 21, which the Android Gradle Plugin 9 release lint needs; pinned Flutter, `pub get`), `create-files` (`.env`, plus Android signing files and `ios/ExportOptions.plist` when their secrets are set) and `flutter-test` (`flutter analyze` + `flutter test`).
- `.github/workflows/staging_app_distribution.yml` / `production_app_distribution.yml`: **manual-only** (`workflow_dispatch`). Android goes to Firebase App Distribution, iOS to TestFlight; production only runs from `master`.
- `fastlane/Fastfile`: the local alternative (`bundle exec fastlane <android|ios> <staging|production>`), with credentials in `fastlane/.env` + `fastlane/keys/` (both gitignored, never commit them).
- Keep the pinned Flutter version in `.github/actions/setup-flutter/action.yml` in sync with `flutter --version` locally.

---

## 10. Code Quality

- `flutter analyze` must report zero issues and `flutter test` must pass before a task is done.
- If unsure about a lint, see the [leancode_lint docs](https://pub.dev/packages/leancode_lint).

---

## 11. What NOT to Do

| ❌ Don't | ✅ Do instead |
| --- | --- |
| Business logic in Views/widgets | Notifier / use case / repository |
| Call a service, dio or drift from a Notifier | Go through a repository |
| Relative imports | `package:clean_architecture/...` |
| Import `*_mobile.dart` / `*_web.dart` | Import the facade |
| Hex colours, raw `TextStyle`s or font sizes in widgets | Theme tokens (`context.colors`, `context.text`, `AppSpacing`) |
| Hard-coded user-facing text | `lib/core/messages/app_messages.dart` |
| `SnackBar` | `ToastUtil` with a `StateMessage` |
| Notifier shows a toast, opens a dialog or navigates | Set state / return a result; the View reacts |
| Bare `try/catch` in data code | `ErrorHandler.execute(..., action:)` / `ApiExecutor` |
| `ErrorMessage(...)` for a failure in a Notifier | `trackFailure(result)` / `trackError(text)` inside `runFlow` |
| `copyWith` keeping the old `message` | `message: message` |
| `_buildX()` widget methods | A widget class in its own file |
| Hardcode API URLs or header names | `AppConfig`, `ApiEndpoints`, `HttpKeys` |
| `FutureBool` when no caller reads the bool | `FutureVoid` + `const SuccessState.nil()` |
| Hand-edit generated files | Change the source and regenerate |
| Write docs/tests before the user confirms a change | Ask first, then do both in one pass |
| Commit `.env`, `fastlane/.env` or `fastlane/keys/` | Keep them local; CI uses GitHub secrets |
