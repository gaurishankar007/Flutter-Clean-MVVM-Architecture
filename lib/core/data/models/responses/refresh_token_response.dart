class const RefreshTokenResponse({required final String accessToken}) {
  factory fromJson(Map<String, dynamic> json) =>
      RefreshTokenResponse(accessToken: json['access'] as String);
}
