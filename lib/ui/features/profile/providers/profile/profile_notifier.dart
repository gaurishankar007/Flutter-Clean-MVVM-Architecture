import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/repositories/user_repository.dart';
import 'package:clean_architecture/domain/use_cases/logout_use_case.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';
import 'package:clean_architecture/ui/features/profile/providers/profile/profile_state.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Profile actions. The user itself comes from `sessionProvider`.
class ProfileNotifier extends BaseNotifier<ProfileState> {
  @override
  ProfileState build() {
    // Login returns a short user; fetch the full one once the tab opens.
    Future.microtask(() => refresh(silent: true));
    return const ProfileState();
  }

  /// [silent] skips the error toast (offline on open is expected).
  Future<void> refresh({bool silent = false}) => runFlow(
    'profile.refresh',
    () async {
      state = const ProfileState(status: .refreshing);
      final result = await GetIt.I<UserRepository>().refresh();
      if (!ref.mounted) {
        return;
      }
      state = ProfileState(
        status: result is SuccessState ? .loaded : .error,
        message: result is SuccessState || silent ? null : trackFailure(result),
      );
    },
  );

  /// Returns true once logged out; the View navigates to login.
  Future<bool> logout() => runFlow('profile.logout', () async {
    state = const ProfileState(status: .loading);
    final result = await GetIt.I<LogoutUseCase>()();
    if (!ref.mounted) {
      return result is SuccessState;
    }
    if (result is SuccessState) {
      state = const ProfileState(
        status: .loaded,
        message: NormalMessage(AuthMessages.loggedOut),
      );
      return true;
    }
    state = ProfileState(status: .error, message: trackFailure(result));
    return false;
  });
}

final profileProvider = NotifierProvider.autoDispose(ProfileNotifier.new);
