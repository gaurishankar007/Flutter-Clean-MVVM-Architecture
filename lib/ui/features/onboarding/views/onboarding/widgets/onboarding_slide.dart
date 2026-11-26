import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/icons/gradient_icon_tile.dart';
import 'package:clean_architecture/ui/features/onboarding/models/onboarding_page.dart';
import 'package:material_ui/material_ui.dart';

/// One onboarding page: big icon, title and body.
class const OnboardingSlide({super.key, required final OnboardingPage page})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const .symmetric(horizontal: AppSpacing.xxl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            spacing: AppSpacing.lg,
            children: [
              GradientIconTile(icon: page.icon, size: 120),
              const SizedBox(height: AppSpacing.lg),
              Text(page.title, style: context.text.display, textAlign: .center),
              Text(
                page.body,
                style: context.text.body.copyWith(
                  color: context.colors.textSecondary,
                ),
                textAlign: .center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
