import 'package:clean_architecture/core/data/models/domain_convertible.dart';
import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/domain/models/user.dart';

final class const UserResponse({
  required final int id,
  required final String username,
  required final String email,
  required final String firstName,
  required final String lastName,
  final String? phone,
  final String? image,
}) implements DomainConvertible<User> {
  factory fromJson(JsonMap json) => UserResponse(
    id: json['id'] as int,
    username: json['username'] as String? ?? '',
    email: json['email'] as String? ?? '',
    firstName: json['firstName'] as String? ?? '',
    lastName: json['lastName'] as String? ?? '',
    phone: json['phone'] as String?,
    image: json['image'] as String?,
  );

  @override
  User toDomain() => User(
    id: id,
    username: username,
    email: email,
    firstName: firstName,
    lastName: lastName,
    phone: phone,
    imageUrl: image,
  );
}
