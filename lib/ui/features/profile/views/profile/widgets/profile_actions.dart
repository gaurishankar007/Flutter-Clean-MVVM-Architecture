import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/routing/routes.gr.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/tonal_button.dart';
import 'package:clean_architecture/ui/core/ui/base/dialog/confirm_dialog.dart';
import 'package:clean_architecture/ui/features/profile/providers/profile/profile_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// Edit profile and Log out.
class const ProfileActions({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(
      profileProvider.select((state) => state.isLoading),
    );

    Future<void> logout() async {
      final confirmed = await showConfirmDialog(
        context,
        title: ProfileMessages.logoutTitle,
        body: ProfileMessages.logoutBody,
        confirmLabel: ProfileMessages.logout,
        destructive: true,
      );
      if (!confirmed || !context.mounted) {
        return;
      }
      final router = context.router;
      if (await ref.read(profileProvider.notifier).logout()) {
        await router.root.replaceAll([const LoginRoute()]);
      }
    }

    return Padding(
      padding: const .only(top: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: AppSpacing.sm,
        children: [
          TonalButton(
            label: ProfileMessages.editProfile,
            icon: Symbols.edit_rounded,
            expand: true,
            onPressed: () => context.router.push(const EditProfileRoute()),
          ),
          TonalButton(
            label: ProfileMessages.logout,
            icon: Symbols.logout_rounded,
            destructive: true,
            expand: true,
            onPressed: isLoading ? null : logout,
          ),
        ],
      ),
    );
  }
}
