import 'package:clean_architecture/domain/models/user.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/avatar/user_avatar.dart';
import 'package:clean_architecture/ui/core/ui/base/cards/app_card.dart';
import 'package:material_ui/material_ui.dart';

/// Avatar, name and username.
class const ProfileCard({super.key, required final User user})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        spacing: AppSpacing.lg,
        children: [
          UserAvatar(
            name: user.displayName,
            bytes: user.avatarBytes,
            imageUrl: user.imageUrl,
            size: 72,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: AppSpacing.xs,
              children: [
                Text(user.displayName, style: context.text.title),
                Text(
                  '@${user.username}',
                  style: context.text.label.copyWith(
                    color: context.colors.primaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
