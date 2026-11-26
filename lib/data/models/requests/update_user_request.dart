import 'package:clean_architecture/core/types/types.dart';

final class const UpdateUserRequest({
  required final String firstName,
  required final String lastName,
  required final String email,
  final String? phone,
}) {
  JsonMap toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'phone': ?phone,
  };
}
