import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/domain/repositories/user_repository.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';
import 'package:clean_architecture/ui/core/utils/validators.dart';
import 'package:clean_architecture/ui/features/profile/providers/edit_profile/edit_profile_state.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef ProfileForm = ({
  String firstName,
  String lastName,
  String email,
  String phone,
});

class EditProfileNotifier extends BaseNotifier<EditProfileState> {
  late final UserRepository _repository;

  @override
  EditProfileState build() {
    _repository = GetIt.I<UserRepository>();
    final user = _repository.currentUser;
    return EditProfileState(user: user, avatarBytes: user?.avatarBytes);
  }

  Future<void> pickAvatar() => runFlow('editProfile.pickAvatar', () async {
    final result = await _repository.pickAvatar();
    if (!ref.mounted) {
      return;
    }
    state = switch (result) {
      SuccessState(:final data?) => state.copyWith(avatarBytes: data),
      SuccessState() => state, // Cancelled.
      _ => state.copyWith(message: trackFailure(result)),
    };
  });

  void removeAvatar() => state = state.copyWith(clearAvatar: true);

  void clearErrors() => state = state.copyWith(clearErrors: true);

  /// Validates and saves. Returns true on success; the View closes.
  Future<bool> save(ProfileForm form) => runFlow('editProfile.save', () async {
    final user = state.user;
    if (user == null || state.isSaving) {
      return false;
    }
    final errors = (
      firstName: Validators.required(form.firstName),
      lastName: Validators.required(form.lastName),
      email: Validators.email(form.email),
      phone: Validators.phone(form.phone),
    );
    if ([
      errors.firstName,
      errors.lastName,
      errors.email,
      errors.phone,
    ].any((e) => e != null)) {
      state = state.copyWith(
        firstNameError: errors.firstName,
        lastNameError: errors.lastName,
        emailError: errors.email,
        phoneError: errors.phone,
      );
      return false;
    }

    state = state.copyWith(isSaving: true, clearErrors: true);
    final phone = form.phone.trim();
    final updated = user.copyWith(
      firstName: form.firstName.trim(),
      lastName: form.lastName.trim(),
      email: form.email.trim(),
      phone: phone.isEmpty ? null : phone,
      clearPhone: phone.isEmpty,
      avatarBytes: state.avatarBytes,
      clearAvatar: state.avatarBytes == null,
    );
    final result = await _repository.update(updated);
    if (!ref.mounted) {
      return result is SuccessState;
    }
    if (result is SuccessState) {
      state = state.copyWith(isSaving: false);
      return true;
    }
    state = state.copyWith(isSaving: false, message: trackFailure(result));
    return false;
  });
}

final editProfileProvider = NotifierProvider.autoDispose(
  EditProfileNotifier.new,
);
