import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/providers/session/session_notifier.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/aurora_glow.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_header.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/screen_scroll_view.dart';
import 'package:clean_architecture/ui/core/utils/extensions/ref_extension.dart';
import 'package:clean_architecture/ui/features/profile/providers/profile/profile_notifier.dart';
import 'package:clean_architecture/ui/features/profile/views/profile/widgets/profile_actions.dart';
import 'package:clean_architecture/ui/features/profile/views/profile/widgets/profile_card.dart';
import 'package:clean_architecture/ui/features/profile/views/profile/widgets/profile_details_card.dart';
import 'package:clean_architecture/ui/features/profile/views/profile/widgets/profile_stats_row.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// The Profile tab.
@RoutePage()
class const ProfileScreen({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listenMessages(profileProvider, context);
    final user = ref.watch(sessionProvider.select((state) => state.user));
    return ScreenScrollView(
      background: const AuroraGlow(),
      onRefresh: ref.read(profileProvider.notifier).refresh,
      children: [
        const ScreenHeader(title: ProfileMessages.title),
        if (user != null) ...[
          ProfileCard(user: user),
          const ProfileStatsRow(),
          ProfileDetailsCard(user: user),
          const ProfileActions(),
        ],
      ],
    );
  }
}
