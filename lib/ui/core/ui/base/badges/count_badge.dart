import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:material_ui/material_ui.dart';

/// A small pill with a count (unread items). Hidden at zero; caps at 99+.
class const CountBadge({super.key, required final int count})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (count <= 0) {
      return const SizedBox.shrink();
    }
    final colors = context.colors;
    return Container(
      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
      padding: const .symmetric(horizontal: AppSpacing.xs + 1),
      alignment: .center,
      decoration: BoxDecoration(
        color: colors.error,
        borderRadius: AppRadius.pill,
        border: .all(color: colors.surface, width: 1.5),
      ),
      child: Text(
        count > 99 ? '99+' : '$count',
        style: context.text.caption.copyWith(
          color: colors.onPrimary,
          fontSize: 10,
          height: 1.2,
        ),
      ),
    );
  }
}
