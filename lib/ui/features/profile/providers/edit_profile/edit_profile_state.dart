import 'package:clean_architecture/domain/models/user.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';
import 'package:flutter/foundation.dart' show Uint8List;

final class const EditProfileState({
  super.status = .loaded,
  super.message,
  final User? user,
  final Uint8List? avatarBytes,
  final String? firstNameError,
  final String? lastNameError,
  final String? emailError,
  final String? phoneError,
  final bool isSaving = false,
}) extends BaseState {
  EditProfileState copyWith({
    StateMessage? message,
    Uint8List? avatarBytes,
    bool clearAvatar = false,
    String? firstNameError,
    String? lastNameError,
    String? emailError,
    String? phoneError,
    bool clearErrors = false,
    bool? isSaving,
  }) => EditProfileState(
    status: status,
    message: message,
    user: user,
    avatarBytes: clearAvatar ? null : avatarBytes ?? this.avatarBytes,
    firstNameError: clearErrors ? null : firstNameError ?? this.firstNameError,
    lastNameError: clearErrors ? null : lastNameError ?? this.lastNameError,
    emailError: clearErrors ? null : emailError ?? this.emailError,
    phoneError: clearErrors ? null : phoneError ?? this.phoneError,
    isSaving: isSaving ?? this.isSaving,
  );

  @override
  List<Object?> get props => [
    ...super.props,
    user,
    avatarBytes,
    firstNameError,
    lastNameError,
    emailError,
    phoneError,
    isSaving,
  ];
}
