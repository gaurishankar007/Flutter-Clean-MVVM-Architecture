import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/ui/base/avatar/user_avatar.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/ghost_button.dart';
import 'package:clean_architecture/ui/features/profile/providers/edit_profile/edit_profile_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// The avatar with Change photo / Remove photo.
class const AvatarEditor({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editProfileProvider);
    final notifier = ref.read(editProfileProvider.notifier);
    final user = state.user;
    if (user == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const .only(bottom: AppSpacing.xl),
      child: Column(
        spacing: AppSpacing.sm,
        children: [
          UserAvatar(
            name: user.displayName,
            bytes: state.avatarBytes,
            imageUrl: user.imageUrl,
            size: 104,
          ),
          Wrap(
            alignment: .center,
            children: [
              GhostButton(
                label: ProfileMessages.changePhoto,
                icon: Symbols.photo_camera_rounded,
                onPressed: notifier.pickAvatar,
              ),
              if (state.avatarBytes != null)
                GhostButton(
                  label: ProfileMessages.removePhoto,
                  icon: Symbols.delete_rounded,
                  destructive: true,
                  onPressed: notifier.removeAvatar,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
