import 'package:clean_architecture/core/types/types.dart';

final class const LoginRequest({
  required final String username,
  required final String password,
  final int expiresInMins = 60,
}) {
  JsonMap toJson() => {
    'username': username,
    'password': password,
    'expiresInMins': expiresInMins,
  };
}
