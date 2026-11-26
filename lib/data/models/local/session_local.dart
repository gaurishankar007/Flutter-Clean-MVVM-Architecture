import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/data/models/local/user_local.dart';
import 'package:clean_architecture/domain/models/session.dart';

extension SessionLocal on Session {
  JsonMap toLocalJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'user': user.toLocalJson(),
  };

  static Session fromLocalJson(JsonMap json) => Session(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
    user: UserLocal.fromLocalJson(json['user'] as JsonMap),
  );
}
