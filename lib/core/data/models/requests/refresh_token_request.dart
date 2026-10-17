class const RefreshTokenRequest({required final String refreshToken}) {
  Map<String, String> toJson() => {'refresh': refreshToken};
}
