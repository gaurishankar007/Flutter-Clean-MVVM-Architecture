import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:material_ui/material_ui.dart';

/// A label on the left, a value on the right.
class const InfoRow({
  super.key,
  required final String label,
  required final String value,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(vertical: AppSpacing.xs + 2),
      child: Row(
        spacing: AppSpacing.md,
        children: [
          Text(
            label,
            style: context.text.label.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
          Expanded(
            child: Text(value, textAlign: .end, style: context.text.label),
          ),
        ],
      ),
    );
  }
}
