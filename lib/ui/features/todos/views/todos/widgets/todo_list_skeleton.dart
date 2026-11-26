import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/ui/base/states/shimmer_box.dart';
import 'package:material_ui/material_ui.dart';

/// Loading placeholder shaped like the list.
class const TodoListSkeleton({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .only(top: AppSpacing.xl),
      child: Column(
        crossAxisAlignment: .start,
        spacing: AppSpacing.sm,
        children: [
          const ShimmerBox(width: 120, height: 20),
          const SizedBox(height: AppSpacing.xs),
          for (var i = 0; i < 4; i++)
            const ShimmerBox(height: 84, borderRadius: AppRadius.lgAll),
        ],
      ),
    );
  }
}
