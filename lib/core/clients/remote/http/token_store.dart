/// Where the HTTP client reads and refreshes the session's tokens. The
/// session service implements it, so `core/` doesn't depend on `data/`.
abstract interface class TokenStore {
  String? get accessToken;
  String? get refreshToken;

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  });

  /// The refresh failed: drop the session and tell the app.
  Future<void> expire();
}
