import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/gradient_button.dart';
import 'package:clean_architecture/ui/core/ui/base/form/app_text_field.dart';
import 'package:clean_architecture/ui/core/utils/toast_util.dart';
import 'package:clean_architecture/ui/features/profile/providers/edit_profile/edit_profile_notifier.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// Name, email and phone fields, and Save.
class const EditProfileForm({super.key}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editProfileProvider);
    final notifier = ref.read(editProfileProvider.notifier);
    final user = state.user;
    final firstName = useTextEditingController(text: user?.firstName);
    final lastName = useTextEditingController(text: user?.lastName);
    final email = useTextEditingController(text: user?.email);
    final phone = useTextEditingController(text: user?.phone);

    Future<void> save() async {
      final router = context.router;
      final saved = await notifier.save((
        firstName: firstName.text,
        lastName: lastName.text,
        email: email.text,
        phone: phone.text,
      ));
      if (saved && context.mounted) {
        ToastUtil.showSuccess(context, ProfileMessages.saved);
        await router.maybePop();
      }
    }

    return Column(
      crossAxisAlignment: .stretch,
      spacing: AppSpacing.lg,
      children: [
        Row(
          crossAxisAlignment: .start,
          spacing: AppSpacing.md,
          children: [
            Expanded(
              child: AppTextField(
                controller: firstName,
                label: ProfileMessages.firstName,
                errorText: state.firstNameError,
                textCapitalization: .words,
                textInputAction: .next,
                onChanged: (_) => notifier.clearErrors(),
              ),
            ),
            Expanded(
              child: AppTextField(
                controller: lastName,
                label: ProfileMessages.lastName,
                errorText: state.lastNameError,
                textCapitalization: .words,
                textInputAction: .next,
                onChanged: (_) => notifier.clearErrors(),
              ),
            ),
          ],
        ),
        AppTextField(
          controller: email,
          label: ProfileMessages.email,
          icon: Symbols.mail_rounded,
          errorText: state.emailError,
          keyboardType: .emailAddress,
          textInputAction: .next,
          onChanged: (_) => notifier.clearErrors(),
        ),
        AppTextField(
          controller: phone,
          label: ProfileMessages.phone,
          icon: Symbols.call_rounded,
          errorText: state.phoneError,
          keyboardType: .phone,
          textInputAction: .done,
          onChanged: (_) => notifier.clearErrors(),
        ),
        const SizedBox(height: AppSpacing.sm),
        GradientButton(
          label: CommonMessages.save,
          icon: Symbols.check_rounded,
          expand: true,
          onPressed: state.isSaving ? null : save,
        ),
      ],
    );
  }
}
