import 'package:clean_architecture/core/data/models/domain_convertible.dart';
import 'package:clean_architecture/core/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class const UserResponse({
  required final int id,
  required final String firstName,
  required final String lastName,
  required final String username,
  required final String email,
  required final bool isActive,
}) extends Equatable implements DomainConvertible<User> {
  factory fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'] as int? ?? 0,
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? false,
    );
  }

  factory fromDomain(User user) {
    return UserResponse(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      username: user.username,
      email: user.email,
      isActive: user.isActive,
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'username': username,
    'email': email,
    'is_active': isActive,
  };

  @override
  User toDomain() {
    return User(
      id: id,
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
      isActive: isActive,
    );
  }

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    username,
    email,
    isActive,
  ];
}
