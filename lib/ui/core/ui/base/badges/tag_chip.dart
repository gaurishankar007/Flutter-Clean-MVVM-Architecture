import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:material_ui/material_ui.dart';

/// A small read-only tag tinted with [color] (a category, a priority).
class const TagChip({
  super.key,
  required final String label,
  required final Color color,
  final IconData? icon,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(horizontal: AppSpacing.sm, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: context.isDark ? 0.2 : 0.12),
        borderRadius: AppRadius.pill,
      ),
      child: Row(
        mainAxisSize: .min,
        spacing: AppSpacing.xs,
        children: [
          if (icon != null) Icon(icon, size: 14, color: color, fill: 1),
          Text(
            label,
            maxLines: 1,
            style: context.text.caption.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
