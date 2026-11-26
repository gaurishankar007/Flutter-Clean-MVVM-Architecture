---
name: api-integration
description: Automates the integration of a new API endpoint through the service, repository, domain and ViewModel layers in this project.
---

# API Integration Skill

Adds an endpoint end to end, following the layers in
`docs/architecture/architecture.md`:

```
ApiEndpoints → DTOs → remote service → repository (contract + impl) → [use case] → Notifier → View
```

Use the `scaffolding` skill first when the endpoint belongs to a new feature.

## 1. Endpoint

Add the path to `lib/core/constants/api_endpoints.dart` (relative to
`AppConfig.apiBaseUrl`; never hardcode a host):

```dart
static const habits = 'habits';
static String habit(int id) => 'habits/$id';
```

## 2. Models

- Domain model in `lib/domain/models/` (`Equatable`, primary constructor, no
  JSON).
- Response DTO in `lib/data/models/responses/` implementing
  `DomainConvertible<Model>`:

```dart
final class const HabitResponse({required final int id, required final String title})
    implements DomainConvertible<Habit> {
  factory fromJson(JsonMap json) =>
      HabitResponse(id: json['id'] as int, title: json['title'] as String? ?? '');

  @override
  Habit toDomain() => Habit(id: id, title: title);
}
```

- Request DTO in `lib/data/models/requests/` with `toJson()` (use null-aware
  map entries `'phone': ?phone` for optional fields).

## 3. Remote service — `ApiExecutor`

`lib/data/services/remote/<feature>_api_service.dart`, `@lazySingleton`,
taking `HttpClient`. Every call passes an `action:` label naming the exact
operation (`'<feature>.api.<op>'`):

```dart
FutureList<HabitResponse> habits() => ApiExecutor.call(
  () => _http.get<dynamic>(ApiEndpoints.habits),
  action: 'habit.api.list',
  fromJson: HabitResponse.fromJson,
  dataKey: 'habits', // when the body is {"habits": [...]}; omit to use the whole body
);

FutureVoid delete(int id) => ApiExecutor.voidCall(
  () => _http.delete<dynamic>(ApiEndpoints.habit(id)),
  action: 'habit.api.delete',
);
```

- `ApiExecutor` wraps the request in `ErrorHandler.execute`, so a `DioException`
  becomes a translated, recorded `FailureState` (see
  `docs/core/error_handling.md`).
- Auth headers and token refresh are automatic (`HttpAuthInterceptor`). Pass
  `Options(extra: {HttpKeys.excludeAuth: true})` for public endpoints such as
  login.

## 4. Repository

Contract in `lib/domain/repositories/` (domain models only), implementation
in `lib/data/repositories/` with `@LazySingleton(as: Contract)`:

```dart
@override
FutureList<Habit> habits() async {
  if (!_connectivity.isConnected) {
    return FailureState.noInternet();
  }
  return (await _api.habits()).mapData((list) => [for (final r in list) r.toDomain()]);
}
```

- Offline-first reads: `RepositoryFetcher.fetchWithFallback(AndMap)` with a
  `local:` fallback and an `onRemoteSuccess:` cache hook (see
  `TodoRepositoryImpl` for a full sync example).
- `FutureVoid` methods return `const SuccessState.nil()`; use `FutureVoid`, not
  `FutureBool`, when no caller reads the bool.

## 5. Use case (optional)

Only when the flow combines several repositories (`lib/domain/use_cases/`,
`@injectable`, implementing `UseCase0`/`UseCase1`). Single-repository flows
call the repository from the Notifier directly.

## 6. Notifier and View

```dart
Future<void> load() => runFlow('habits.load', () async {
  state = state.copyWith(status: .loading);
  final result = await GetIt.I<HabitRepository>().habits();
  if (!ref.mounted) {
    return;
  }
  state = switch (result) {
    SuccessState(:final data?) => state.copyWith(status: .loaded, habits: data),
    _ => state.copyWith(status: .error, message: trackFailure(result)),
  };
});
```

The View calls `ref.listenMessages(habitsProvider, context)` to show the
message. User-facing text goes in `app_messages.dart`.

## 7. DI, mocks, verify

1. Run the `codegen` skill.
2. Add mocks for the new service/repository in `testing/mocks/`.
3. `flutter analyze` (zero issues) and `flutter test`.

## Ask the user when

- It's unclear whether the endpoint belongs to an existing repository or a new
  feature.
- It's unclear whether it needs offline support (a local table + fallback).
