import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:material_ui/material_ui.dart';

/// A section title inside a screen, with an optional trailing widget.
class const SectionHeader({
  super.key,
  required final String title,
  final Widget? trailing,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .only(top: AppSpacing.xl, bottom: AppSpacing.md),
      child: Row(
        spacing: AppSpacing.sm,
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 2,
              overflow: .ellipsis,
              style: context.text.headline,
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
