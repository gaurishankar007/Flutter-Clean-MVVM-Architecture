import 'package:clean_architecture/ui/core/themes/app_gradients.dart';
import 'package:clean_architecture/ui/core/themes/app_motion.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:material_ui/material_ui.dart';

/// Page indicator: the current page is a wider Aurora pill.
class const PageDots({
  super.key,
  required final int count,
  required final int index,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      spacing: AppSpacing.sm,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: AppMotion.normal,
            curve: AppMotion.standard,
            width: i == index ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              gradient: i == index ? AppGradients.aurora : null,
              color: i == index ? null : context.colors.outline,
              borderRadius: AppRadius.pill,
            ),
          ),
      ],
    );
  }
}
