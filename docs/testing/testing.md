# Testing Guide

Unit, widget, regression and end-to-end (Patrol) tests. Read this before writing tests.

## Layout

- **Unit/widget tests** live in `test/`, mirroring `lib/` (e.g. `lib/domain/use_cases/sync_todos_use_case.dart` → `test/domain/use_cases/sync_todos_use_case_test.dart`).
- **Shared mocks** live in `testing/mocks/` (`client_mocks.dart`, `service_mocks.dart`, `repository_mocks.dart`, `use_case_mocks.dart`); **shared helpers** in `testing/helpers/` (`test_setup.dart`, `fixtures.dart`). Add a new class's mock there instead of redefining it in a test.
- **Integration tests** live in `patrol_test/` and use [Patrol](https://pub.dev/packages/patrol).
- **Issue regression tests** live together in `test/regression/`. See [Regression tests](#regression-tests).

`test/` and `testing/` import each other with relative paths (they're outside `lib/`, so package imports can't reach `testing/`). Everything in `lib/` is imported with `package:clean_architecture/...`.

## Conventions

- **Mock with `mocktail`** (`class MockX extends Mock implements X;`). Never hit real HTTP, the real database or platform channels in a unit test. Classes you mock can't be `final` (services and use cases are plain classes for that reason; repositories are mocked through their interface).
- **Fixed time:** use `testNow` from `testing/helpers/fixtures.dart` and the `now:` parameters (`Todo.isOverdue(now)`, `TodoQuery.apply(..., now:)`, `TodoStats.from(..., now:)`) so date logic doesn't depend on the clock.
- **Fallback values:** call `registerFallbackValue` in `setUpAll` for every type matched with `any()` (records like `(username: '', password: '')` included). `trackFailure` takes a `DataState<dynamic>`, so register `const SuccessState<dynamic>(data: null)` when verifying it.
- **Widget tests use `patrol_finders`** (`patrolWidgetTest`, the `$` finder). Wrap the widget in `MaterialApp(theme: buildTheme(Brightness.light))` so `context.colors`/`context.text` resolve.
- **Prefer text or semantics finders.** Message texts come from `app_messages.dart`, so tests use the same constants (`$(TodoMessages.newTask)`). Only add a `Key` to production code when a finder would be ambiguous.
- If coverage requirements are ambiguous, ask rather than inventing a convention.
- **Ask before writing tests for a code change** (see `CLAUDE.md`): run the existing tests, but add or rewrite tests only after the user confirms the change is final.

## Testing ViewModels (Notifiers)

Notifiers resolve repositories and use cases from get_it in `build()`, so a test registers mocks there and reads the notifier from a `ProviderContainer`:

```dart
setUp(() {
  registerErrorHandling(); // real ErrorHandler + mock AppErrorRecorder
  registerMock<LoginUseCase>(loginUseCase);
  // Listening keeps an .autoDispose provider alive between reads.
  container = ProviderContainer.test()..listen(loginProvider, (_, _) {});
});

tearDown(resetDependencies); // GetIt.I.reset()
```

- **Assert on state and returned values.** A notifier never shows a toast or navigates: it sets `state.message` and returns a result (`Future<bool>`, an id). Assert `container.read(provider).message == const SuccessMessage(...)` and the return value. Navigation is asserted in the screen's widget test.
- **`StateMessage` subclasses are `Equatable`**, so exact comparisons work. Keep any new subclass `Equatable` too.
- **Errors are tracked:** verify `recorder.trackFailure(any(), action: 'auth.login', source: 'LoginNotifier')` when a failure must reach the error log.
- **Async `build()` work** (e.g. `Future.microtask(_load)`): `await pumpEventQueue()` before asserting.
- Family providers: `todoEditorProvider(id)`; listen to the exact family member you read.

Examples: `test/ui/features/auth/providers/login_notifier_test.dart`, `test/ui/features/todos/providers/todo_editor_notifier_test.dart`.

## Testing the data layer

- **Repositories:** construct the implementation with mocked services and connectivity; assert on the returned `DataState` and on what was written (`verify(...).captured`). See `test/data/repositories/todo_repository_impl_test.dart` (sync merge).
- **Services / `ApiExecutor`:** stub the `HttpClient` (or pass a lambda returning a `Response`) and call `registerErrorHandling()` so `ErrorHandler.execute` works. See `test/core/data/operations/api_executor_test.dart`.
- **Use cases:** mock every repository they combine. See `test/domain/use_cases/sync_todos_use_case_test.dart`.
- **Pure domain logic** (`TodoQuery`, `TodoStats`, `Todo`) needs no mocks.

## Regression tests

Regression tests pin the fix for a specific GitHub issue so it can't silently break again.

- **One file per issue:** `test/regression/issue_<number>_<short_name>_test.dart`.
- **Tag every file:** start it with `@Tags(['regression'])` followed by `library;` (the tag is declared in `dart_test.yaml`).
- **Group by issue:** `group('Issue #<number> - <what is checked>', ...)`, with the reported symptom in the file's header comment.
- **Read the issue first** (`gh issue view <number>`), including screenshots, and assert on the actual cause.
- **Open issues:** write the test against the expected fixed behaviour and skip it (`group(..., skip: 'Open issue #<number>', ...)`) so `flutter test` stays green; the fix removes the `skip`.

## Integration tests (Patrol)

`patrol_test/todo_flow_test.dart` runs the whole example: onboarding → demo login → create a task → complete it → find it under Completed → log out. It needs the demo backend (`https://dummyjson.com`) and a fresh install. Switch the flavor in `patrol_test/helpers/test_app.dart`.

## Running tests

```bash
flutter test                            # unit + widget tests
flutter test --tags regression          # only the issue regression tests
flutter test --exclude-tags regression  # everything except them
flutter analyze                         # static analysis, must be clean
patrol test --target patrol_test/todo_flow_test.dart
```

Tests for `dart:js_interop`/`package:web` code are marked `@TestOn('browser')`; run them with `flutter test --platform chrome path/to/test.dart`.
