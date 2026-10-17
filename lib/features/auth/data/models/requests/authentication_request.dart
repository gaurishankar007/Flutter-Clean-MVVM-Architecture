import 'package:clean_architecture/features/auth/domain/entities/authentication.dart';

class const AuthenticationRequest({
  required final String username,
  required final String password,
}) {
  factory fromDomain(Authentication authentication) => AuthenticationRequest(
    username: authentication.username,
    password: authentication.password,
  );

  Map<String, String> toJson() => {'username': username, 'password': password};
}
