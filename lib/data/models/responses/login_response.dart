import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/data/models/responses/user_response.dart';

/// The demo API returns the user's fields and the tokens in one object.
final class const LoginResponse({
  required final String accessToken,
  required final String refreshToken,
  required final UserResponse user,
}) {
  factory fromJson(JsonMap json) => LoginResponse(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
    user: .fromJson(json),
  );
}
