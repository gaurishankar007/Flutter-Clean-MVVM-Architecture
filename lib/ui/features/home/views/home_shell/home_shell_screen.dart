import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/routing/routes.gr.dart';
import 'package:clean_architecture/ui/core/providers/connectivity/connectivity_notifier.dart';
import 'package:clean_architecture/ui/core/providers/screen_type/screen_type_notifier.dart';
import 'package:clean_architecture/ui/core/providers/settings/app_settings_notifier.dart';
import 'package:clean_architecture/ui/core/themes/app_motion.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/offline_banner.dart';
import 'package:clean_architecture/ui/core/utils/extensions/ref_extension.dart';
import 'package:clean_architecture/ui/features/home/models/nav_destination.dart';
import 'package:clean_architecture/ui/features/home/views/home_shell/widgets/app_navigation_bar.dart';
import 'package:clean_architecture/ui/features/home/views/home_shell/widgets/app_sidebar.dart';
import 'package:clean_architecture/ui/features/notifications/providers/unread_count/unread_count_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// The tab shell: floating bottom bar on phones/tablets, sidebar on wide
/// screens, and an offline banner on top.
@RoutePage()
class const HomeShellScreen({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Shown here, not per tab, so a settings change gets one toast.
    ref.listenMessages(appSettingsProvider, context);
    final usesSidebar = ref.watch(
      screenTypeProvider.select((type) => type.usesSidebar),
    );
    final isOnline = ref.watch(connectivityProvider);
    final unread = ref.watch(unreadCountProvider).value ?? 0;
    final badges = {NavDestination.notifications: unread};

    return AutoTabsRouter(
      routes: const [
        TodosRoute(),
        NotificationsRoute(),
        ProfileRoute(),
        SettingsRoute(),
      ],
      duration: AppMotion.normal,
      transitionBuilder: (context, child, animation) =>
          FadeTransition(opacity: animation, child: child),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final body = Column(
          children: [
            OfflineBanner(visible: !isOnline, message: CommonMessages.offline),
            Expanded(child: child),
          ],
        );
        if (usesSidebar) {
          return Scaffold(
            body: Row(
              children: [
                AppSidebar(
                  selectedIndex: tabsRouter.activeIndex,
                  onSelected: tabsRouter.setActiveIndex,
                  badges: badges,
                ),
                Expanded(child: body),
              ],
            ),
          );
        }
        return Scaffold(
          extendBody: true,
          body: body,
          bottomNavigationBar: AppNavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onSelected: tabsRouter.setActiveIndex,
            badges: badges,
          ),
        );
      },
    );
  }
}
