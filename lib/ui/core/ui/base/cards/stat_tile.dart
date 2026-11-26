import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:material_ui/material_ui.dart';

/// A number over a label on a raised tile.
class const StatTile({
  super.key,
  required final String label,
  required final int value,
  required final Color color,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .symmetric(
        vertical: AppSpacing.md,
        horizontal: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.colors.surfaceRaised,
        borderRadius: AppRadius.mdAll,
      ),
      child: Column(
        spacing: 2,
        children: [
          Text('$value', style: context.text.title.copyWith(color: color)),
          Text(
            label,
            maxLines: 1,
            overflow: .ellipsis,
            style: context.text.caption.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
