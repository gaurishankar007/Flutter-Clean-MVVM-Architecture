/// Paths on `AppConfig.apiBaseUrl`. The example features use the public
/// DummyJSON API (https://dummyjson.com/docs).
abstract final class ApiEndpoints {
  // Auth
  static const login = 'auth/login';
  static const me = 'auth/me';
  static const refreshToken = 'auth/refresh';

  // Users
  static String user(int id) => 'users/$id';

  // Todos
  static const todos = 'todos';
}
