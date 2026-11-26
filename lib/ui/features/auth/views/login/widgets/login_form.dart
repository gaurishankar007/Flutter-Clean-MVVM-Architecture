import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/routing/routes.gr.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/gradient_button.dart';
import 'package:clean_architecture/ui/core/ui/base/form/app_text_field.dart';
import 'package:clean_architecture/ui/features/auth/providers/login/login_notifier.dart';
import 'package:clean_architecture/ui/features/auth/views/login/widgets/demo_account_card.dart';
import 'package:clean_architecture/ui/features/auth/views/login/widgets/password_visibility_button.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// Username, password, Log in, and the demo account shortcut.
class const LoginForm({super.key}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);
    final notifier = ref.read(loginProvider.notifier);
    final username = useTextEditingController();
    final password = useTextEditingController();
    final obscure = useState(true);

    Future<void> submit() async {
      final loggedIn = await notifier.login(
        username: username.text,
        password: password.text,
      );
      if (loggedIn && context.mounted) {
        await context.router.replaceAll([const HomeShellRoute()]);
      }
    }

    return AutofillGroup(
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: AppSpacing.lg,
        children: [
          AppTextField(
            controller: username,
            label: AuthMessages.username,
            icon: Symbols.person_rounded,
            errorText: state.usernameError,
            textInputAction: .next,
            autofillHints: const [AutofillHints.username],
            onChanged: (_) => notifier.clearErrors(),
          ),
          AppTextField(
            controller: password,
            label: AuthMessages.password,
            icon: Symbols.lock_rounded,
            errorText: state.passwordError,
            obscureText: obscure.value,
            textInputAction: .done,
            autofillHints: const [AutofillHints.password],
            onChanged: (_) => notifier.clearErrors(),
            onSubmitted: (_) => submit(),
            trailing: PasswordVisibilityButton(
              obscured: obscure.value,
              onPressed: () => obscure.value = !obscure.value,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          GradientButton(
            label: AuthMessages.login,
            icon: Symbols.login_rounded,
            expand: true,
            onPressed: state.isLoading ? null : submit,
          ),
          DemoAccountCard(
            onUse: () {
              username.text = 'emilys';
              password.text = 'emilyspass';
              notifier.clearErrors();
            },
          ),
        ],
      ),
    );
  }
}
