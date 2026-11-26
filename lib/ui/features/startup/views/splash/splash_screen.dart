import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/routing/routes.gr.dart';
import 'package:clean_architecture/ui/core/ui/base/layout/aurora_glow.dart';
import 'package:clean_architecture/ui/features/startup/providers/splash/splash_notifier.dart';
import 'package:clean_architecture/ui/features/startup/views/splash/widgets/splash_brand.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@RoutePage()
class const SplashScreen({super.key}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(splashProvider.notifier).resolve().then((destination) {
        if (!context.mounted) {
          return;
        }
        context.router.replaceAll([
          switch (destination) {
            .onboarding => const OnboardingRoute(),
            .login => const LoginRoute(),
            .home => const HomeShellRoute(),
          },
        ]);
      });
      return null;
    }, const []);
    return const Scaffold(
      body: Stack(
        children: [
          AuroraGlow(height: 520),
          Center(child: SplashBrand()),
        ],
      ),
    );
  }
}
