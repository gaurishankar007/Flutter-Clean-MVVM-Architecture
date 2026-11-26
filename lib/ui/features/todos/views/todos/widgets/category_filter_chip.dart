import 'package:clean_architecture/domain/models/todo_category.dart';
import 'package:clean_architecture/ui/core/themes/app_motion.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/features/todos/models/todo_presentation.dart';
import 'package:material_ui/material_ui.dart';

/// A compact category chip tinted with the category's colour.
class const CategoryFilterChip({
  super.key,
  required final TodoCategory category,
  required final bool selected,
  required final VoidCallback onSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = category.color;
    return Semantics(
      selected: selected,
      button: true,
      child: AnimatedContainer(
        duration: AppMotion.fast,
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.18) : Colors.transparent,
          borderRadius: AppRadius.pill,
          border: .all(color: selected ? color : context.colors.outline),
        ),
        child: InkWell(
          onTap: onSelected,
          borderRadius: AppRadius.pill,
          child: Padding(
            padding: const .symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs + 2,
            ),
            child: Row(
              mainAxisSize: .min,
              spacing: AppSpacing.xs,
              children: [
                Icon(
                  category.icon,
                  size: 14,
                  color: color,
                  fill: selected ? 1 : 0,
                ),
                Text(
                  category.label,
                  style: context.text.caption.copyWith(
                    color: selected
                        ? context.colors.textPrimary
                        : context.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
