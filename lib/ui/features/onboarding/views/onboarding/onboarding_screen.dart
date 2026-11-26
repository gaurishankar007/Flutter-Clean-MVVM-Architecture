import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/routing/routes.gr.dart';
import 'package:clean_architecture/ui/core/providers/settings/app_settings_notifier.dart';
import 'package:clean_architecture/ui/core/themes/app_motion.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/ghost_button.dart';
import 'package:clean_architecture/ui/core/ui/base/buttons/gradient_button.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/aurora_glow.dart';
import 'package:clean_architecture/ui/core/utils/extensions/ref_extension.dart';
import 'package:clean_architecture/ui/features/onboarding/models/onboarding_page.dart';
import 'package:clean_architecture/ui/features/onboarding/views/onboarding/widgets/onboarding_page_view.dart';
import 'package:clean_architecture/ui/features/onboarding/views/onboarding/widgets/page_dots.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

@RoutePage()
class const OnboardingScreen({super.key}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listenMessages(appSettingsProvider, context);
    final controller = usePageController();
    final page = useState(0);
    final isLast = page.value == OnboardingPage.values.length - 1;

    Future<void> finish() async {
      await ref.read(appSettingsProvider.notifier).completeOnboarding();
      if (context.mounted) {
        await context.router.replaceAll([const LoginRoute()]);
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          const AuroraGlow(height: 420),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: .centerRight,
                  child: Padding(
                    padding: const .all(AppSpacing.sm),
                    child: isLast
                        ? const SizedBox(height: 44)
                        : GhostButton(
                            label: CommonMessages.skip,
                            onPressed: finish,
                          ),
                  ),
                ),
                Expanded(
                  child: OnboardingPageView(
                    controller: controller,
                    onPageChanged: (index) => page.value = index,
                  ),
                ),
                PageDots(
                  count: OnboardingPage.values.length,
                  index: page.value,
                ),
                Padding(
                  padding: const .all(AppSpacing.xl),
                  child: GradientButton(
                    label: isLast
                        ? OnboardingMessages.getStarted
                        : CommonMessages.next,
                    icon: isLast
                        ? Symbols.rocket_launch_rounded
                        : Symbols.arrow_forward_rounded,
                    expand: true,
                    onPressed: isLast
                        ? finish
                        : () => controller.nextPage(
                            duration: AppMotion.normal,
                            curve: AppMotion.standard,
                          ),
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
