import 'package:clean_architecture/core/data/states/data_state.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/domain/use_cases/login_use_case.dart';
import 'package:clean_architecture/ui/core/providers/base/base_notifier.dart';
import 'package:clean_architecture/ui/core/utils/validators.dart';
import 'package:clean_architecture/ui/features/auth/providers/login/login_state.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginNotifier extends BaseNotifier<LoginState> {
  @override
  LoginState build() => const LoginState();

  /// Validates and logs in. Returns true on success; the View navigates.
  Future<bool> login({required String username, required String password}) =>
      runFlow('auth.login', () async {
        if (state.isLoading) {
          return false;
        }
        final usernameError = Validators.required(username);
        final passwordError = Validators.required(password);
        if (usernameError != null || passwordError != null) {
          state = LoginState(
            usernameError: usernameError,
            passwordError: passwordError,
          );
          return false;
        }

        state = const LoginState(status: .loading);
        final result = await GetIt.I<LoginUseCase>()((
          username: username,
          password: password,
        ));
        if (!ref.mounted) {
          return false;
        }
        if (result is SuccessState) {
          state = const LoginState(
            status: .loaded,
            message: SuccessMessage(AuthMessages.loggedIn),
          );
          return true;
        }
        state = LoginState(status: .error, message: trackFailure(result));
        return false;
      });

  /// Clears a field's error while the user edits it.
  void clearErrors() {
    if (state.usernameError != null || state.passwordError != null) {
      state = LoginState(status: state.status);
    }
  }
}

final loginProvider = NotifierProvider.autoDispose(LoginNotifier.new);
