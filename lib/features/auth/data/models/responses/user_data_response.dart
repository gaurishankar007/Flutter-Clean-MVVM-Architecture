import 'package:clean_architecture/core/data/models/domain_convertible.dart';
import 'package:clean_architecture/core/data/models/responses/user_response.dart';
import 'package:clean_architecture/core/domain/entities/user_data.dart';
import 'package:equatable/equatable.dart';

class const UserDataResponse({
  required final UserResponse user,
  required final String accessToken,
  required final String refreshToken,
}) extends Equatable implements DomainConvertible<UserData> {
  factory fromJson(Map<String, dynamic> json) {
    return UserDataResponse(
      user: .fromJson(json['user'] as Map<String, dynamic>? ?? {}),
      accessToken: json['access'] as String? ?? '',
      refreshToken: json['refresh'] as String? ?? '',
    );
  }

  factory fromDomain(UserData domain) {
    return UserDataResponse(
      user: .fromDomain(domain.user),
      accessToken: domain.accessToken,
      refreshToken: domain.refreshToken,
    );
  }
  Map<String, dynamic> toJson() => {
    'user': user.toJson(),
    'access': accessToken,
    'refresh': refreshToken,
  };

  @override
  UserData toDomain() {
    return UserData(
      user: user.toDomain(),
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  @override
  List<Object?> get props => [user, accessToken, refreshToken];
}
