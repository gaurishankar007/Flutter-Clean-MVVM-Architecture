import 'package:clean_architecture/ui/core/themes/app_motion.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:material_ui/material_ui.dart';

/// One segment's icon and label inside a `SegmentedPicker`.
class const SegmentedPickerLabel({
  super.key,
  required final String label,
  required final bool selected,
  final IconData? icon,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final foreground = selected
        ? context.colors.onPrimary
        : context.colors.textSecondary;
    return Row(
      mainAxisAlignment: .center,
      spacing: AppSpacing.xs + 2,
      children: [
        if (icon != null)
          Icon(icon, size: 18, color: foreground, fill: selected ? 1 : 0),
        Flexible(
          child: AnimatedDefaultTextStyle(
            duration: AppMotion.fast,
            style: context.text.label.copyWith(
              color: foreground,
              fontWeight: .w600,
            ),
            child: Text(label, maxLines: 1, overflow: .ellipsis),
          ),
        ),
      ],
    );
  }
}
