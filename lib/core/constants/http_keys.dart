/// Header names and per-request `Options.extra` flags.
abstract final class HttpKeys {
  static const authorization = 'Authorization';
  static const contentType = 'Content-Type';
  static const applicationJson = 'application/json';

  /// `Options(extra: {HttpKeys.excludeAuth: true})` skips the bearer token.
  static const excludeAuth = 'excludeAuth';
}
