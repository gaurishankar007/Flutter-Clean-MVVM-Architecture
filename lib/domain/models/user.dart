import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show Uint8List;

/// The signed-in user.
final class const User({
  required final int id,
  required final String username,
  required final String email,
  required final String firstName,
  required final String lastName,
  final String? phone,
  final String? imageUrl,

  /// A photo picked on this device; shown instead of [imageUrl].
  final Uint8List? avatarBytes,
}) extends Equatable {
  String get fullName => '$firstName $lastName'.trim();

  String get displayName => fullName.isEmpty ? username : fullName;

  User copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    bool clearPhone = false,
    String? imageUrl,
    Uint8List? avatarBytes,
    bool clearAvatar = false,
  }) => User(
    id: id,
    username: username,
    email: email ?? this.email,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    phone: clearPhone ? null : phone ?? this.phone,
    imageUrl: imageUrl ?? this.imageUrl,
    avatarBytes: clearAvatar ? null : avatarBytes ?? this.avatarBytes,
  );

  @override
  List<Object?> get props => [
    id,
    username,
    email,
    firstName,
    lastName,
    phone,
    imageUrl,
    avatarBytes,
  ];
}
