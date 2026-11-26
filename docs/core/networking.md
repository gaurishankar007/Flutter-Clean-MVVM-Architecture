# Networking

Files: `lib/core/clients/remote/`, `lib/core/data/operations/`, `lib/core/constants/`, `lib/config/app_config.dart`.

## Base URL and Endpoints

`AppConfig` (one per flavor) reads `BASE_PRODUCTION` / `BASE_STAGING` / `BASE_DEVELOPMENT` from `.env`, falling back to the demo backend `https://dummyjson.com/`. Paths live in `ApiEndpoints`; header names and per-request flags in `HttpKeys`. Never hardcode either.

## HttpClient

`HttpClient` (`http/http_client.dart`) is a small interface over dio (`get`, `post`, `put`, `patch`, `delete`) so services and tests don't touch dio directly. `HttpClientImpl` configures base URL, 15 s timeouts, JSON headers and the auth interceptor.

Remote services call it through `ApiExecutor`:

```dart
FutureList<TodoResponse> todos({int limit = 30}) => ApiExecutor.call(
  () => _http.get<dynamic>(ApiEndpoints.todos, queryParameters: {'limit': limit}),
  action: 'todo.api.todos',
  fromJson: TodoResponse.fromJson,
  dataKey: 'todos', // payload is body['todos']; omit to parse the whole body
);
```

## Authentication

`HttpAuthInterceptor` (a dio `QueuedInterceptor`):

1. Adds `Authorization: Bearer <accessToken>` from the `TokenStore`, unless the request sets `Options(extra: {HttpKeys.excludeAuth: true})` (login) or already has the header.
2. On a 401, refreshes once (`POST auth/refresh` with the refresh token, on a bare dio so it doesn't loop), saves the new tokens and retries the request. Requests queued behind the refresh retry with the token it got.
3. If the refresh fails, calls `TokenStore.expire()`: the session is cleared and the app returns to login (see [Routing](routing.md#session-expiry)).

`TokenStore` is an interface in `core/` implemented by `SessionLocalService`, so the HTTP client doesn't depend on the data layer.

## Connectivity

`ConnectivityClient` reads the current state at startup and listens for changes (`isConnected`, `onConnectivityChanged`). Repositories check it before remote calls (or use `RepositoryFetcher.fetchWithFallback`); `connectivityProvider` drives the offline banner in the home shell.

## Offline-first

The example's tasks live in drift; the server is imported by `TodoRepository.sync()`, which merges by remote id and keeps local-only fields (notes, priority, category, due date, subtasks). Screens watch the table, so they work offline and update instantly after a sync.

## The Demo Backend

[DummyJSON](https://dummyjson.com/docs) gives the example real endpoints without a server of your own: `auth/login` (user `emilys` / `emilyspass`), `auth/me`, `auth/refresh`, `users/{id}` and `todos`. Writes are simulated (not persisted), so the device copy is the truth after an edit. Replace it with your API by setting the `.env` URLs and adapting the DTOs.
