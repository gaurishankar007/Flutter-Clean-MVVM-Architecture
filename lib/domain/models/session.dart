import 'package:clean_architecture/domain/models/user.dart';
import 'package:equatable/equatable.dart';

/// Tokens and the user they belong to.
final class const Session({
  required final String accessToken,
  required final String refreshToken,
  required final User user,
}) extends Equatable {
  Session copyWith({String? accessToken, String? refreshToken, User? user}) =>
      Session(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        user: user ?? this.user,
      );

  @override
  List<Object?> get props => [accessToken, refreshToken, user];
}
