import 'dart:convert';

import 'package:clean_architecture/core/types/types.dart';
import 'package:clean_architecture/domain/models/user.dart';

/// The user as stored on the device; a picked photo is kept as base64.
extension UserLocal on User {
  JsonMap toLocalJson() => {
    'id': id,
    'username': username,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'phone': phone,
    'imageUrl': imageUrl,
    'avatar': avatarBytes == null ? null : base64Encode(avatarBytes!),
  };

  static User fromLocalJson(JsonMap json) => User(
    id: json['id'] as int,
    username: json['username'] as String,
    email: json['email'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    phone: json['phone'] as String?,
    imageUrl: json['imageUrl'] as String?,
    avatarBytes: switch (json['avatar']) {
      final String encoded => base64Decode(encoded),
      _ => null,
    },
  );
}
