import 'package:clean_architecture/ui/core/themes/app_gradients.dart';
import 'package:clean_architecture/ui/core/themes/app_motion.dart';
import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:clean_architecture/ui/core/ui/base/form/segmented_picker_label.dart';
import 'package:material_ui/material_ui.dart';

/// One choice in a [SegmentedPicker].
typedef Segment<T> = ({T value, String label, IconData? icon});

/// Equal-width segments on a raised track, with an Aurora pill that slides to
/// the selected one (e.g. a task's priority).
class const SegmentedPicker<T>({
  super.key,
  required final List<Segment<T>> segments,
  required final T selected,
  required final ValueChanged<T> onSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final index = segments.indexWhere((segment) => segment.value == selected);
    final count = segments.length;

    return Container(
      height: 48,
      padding: const .all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: colors.surfaceRaised,
        borderRadius: AppRadius.mdAll,
        border: .all(color: colors.outline),
      ),
      // `expand` so the labels fill the track height and centre against the pill.
      child: Stack(
        fit: .expand,
        children: [
          if (index >= 0)
            AnimatedAlign(
              duration: MediaQuery.disableAnimationsOf(context)
                  ? .zero
                  : AppMotion.normal,
              curve: AppMotion.standard,
              alignment: Alignment(
                count == 1 ? 0 : -1 + 2 * index / (count - 1),
                0,
              ),
              child: FractionallySizedBox(
                widthFactor: 1 / count,
                heightFactor: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: AppGradients.aurora,
                    borderRadius: const .all(
                      .circular(AppRadius.md - AppSpacing.xs),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colors.primary.withValues(alpha: 0.3),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Row(
            crossAxisAlignment: .stretch,
            children: [
              for (final segment in segments)
                Expanded(
                  child: Semantics(
                    selected: segment.value == selected,
                    button: true,
                    child: InkWell(
                      onTap: () => onSelected(segment.value),
                      borderRadius: const .all(
                        .circular(AppRadius.md - AppSpacing.xs),
                      ),
                      child: SegmentedPickerLabel(
                        label: segment.label,
                        icon: segment.icon,
                        selected: segment.value == selected,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
