import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/routing/routes.gr.dart';
import 'package:clean_architecture/ui/core/providers/session/session_notifier.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/avatar/user_avatar.dart';
import 'package:clean_architecture/ui/core/utils/date_formats.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// Greeting, today's date and the user's avatar (opens Profile).
class const TodosHeader({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(sessionProvider.select((state) => state.user));
    final now = DateTime.now();
    final greeting = switch (now.hour) {
      < 12 => TodoMessages.goodMorning,
      < 18 => TodoMessages.goodAfternoon,
      _ => TodoMessages.goodEvening,
    };
    return Padding(
      padding: const .only(top: AppSpacing.xl, bottom: AppSpacing.lg),
      child: Row(
        spacing: AppSpacing.md,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: AppSpacing.xs,
              children: [
                Text(
                  DateFormats.longDate(now).toUpperCase(),
                  style: context.text.caption.copyWith(
                    color: context.colors.primaryText,
                    letterSpacing: 0.8,
                  ),
                ),
                Text(
                  TodoMessages.greeting(greeting, user?.firstName ?? ''),
                  style: context.text.screenTitle,
                ),
              ],
            ),
          ),
          if (user != null)
            GestureDetector(
              onTap: () => context.navigateTo(const ProfileRoute()),
              child: UserAvatar(
                name: user.displayName,
                bytes: user.avatarBytes,
                imageUrl: user.imageUrl,
              ),
            ),
        ],
      ),
    );
  }
}
