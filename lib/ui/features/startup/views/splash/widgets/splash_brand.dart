import 'package:clean_architecture/config/app_config.dart';
import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/themes/app_motion.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/icons/gradient_icon_tile.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// The app mark, name and tagline, fading and scaling in.
class const SplashBrand({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: MediaQuery.disableAnimationsOf(context)
          ? .zero
          : AppMotion.slow * 2,
      curve: AppMotion.emphasized,
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.scale(scale: 0.9 + value * 0.1, child: child),
      ),
      child: Column(
        mainAxisSize: .min,
        spacing: AppSpacing.md,
        children: [
          const GradientIconTile(icon: Symbols.task_alt_rounded, size: 88),
          const SizedBox(height: AppSpacing.sm),
          Text(
            AppConfigUtil.I.appTitle,
            style: context.text.title,
            textAlign: .center,
          ),
          Text(
            StartupMessages.tagline,
            style: context.text.body.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
