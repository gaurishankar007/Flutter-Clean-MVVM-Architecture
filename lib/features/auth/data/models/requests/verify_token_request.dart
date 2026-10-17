import 'package:clean_architecture/features/auth/domain/entities/verify_token.dart';

class const VerifyTokenRequest({
  required final String token,
  required final String userId,
}) {
  factory fromDomain(VerifyToken verifyToken) =>
      VerifyTokenRequest(token: verifyToken.token, userId: verifyToken.userId);

  Map<String, dynamic> toJson() => {'token': token, 'user_id': userId};
}
