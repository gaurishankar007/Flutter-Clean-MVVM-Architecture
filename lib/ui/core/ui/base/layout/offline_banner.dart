import 'package:clean_architecture/ui/core/themes/app_motion.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// A thin warning strip that slides in while [visible].
class const OfflineBanner({
  super.key,
  required final bool visible,
  required final String message,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AnimatedSize(
      duration: AppMotion.normal,
      curve: AppMotion.standard,
      child: visible
          ? Semantics(
              liveRegion: true,
              child: Container(
                width: double.infinity,
                color: colors.warning,
                padding: const .symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.xs + 2,
                ),
                child: SafeArea(
                  bottom: false,
                  child: Row(
                    mainAxisAlignment: .center,
                    spacing: AppSpacing.sm,
                    children: [
                      Icon(
                        Symbols.cloud_off_rounded,
                        size: 16,
                        color: colors.onPrimary,
                      ),
                      Flexible(
                        child: Text(
                          message,
                          style: context.text.caption.copyWith(
                            color: colors.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const SizedBox(width: double.infinity),
    );
  }
}
