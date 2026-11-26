import 'package:clean_architecture/ui/core/themes/app_gradients.dart';
import 'package:clean_architecture/ui/core/themes/app_motion.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

/// A round check: an outlined ring, or an Aurora disc with a tick when
/// [value] is true. [label] is the screen-reader label.
class const AppCheckbox({
  super.key,
  required final bool value,
  required final ValueChanged<bool>? onChanged,
  required final String label,
  final double size = 24,
  final Color? ringColor,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      checked: value,
      label: label,
      button: true,
      excludeSemantics: true,
      // A 44px touch target around the small ring.
      child: InkResponse(
        onTap: onChanged == null ? null : () => onChanged!(!value),
        radius: 22,
        child: SizedBox.square(
          dimension: 44,
          child: Center(
            child: AnimatedContainer(
              duration: AppMotion.fast,
              curve: AppMotion.standard,
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: .circle,
                gradient: value ? AppGradients.aurora : null,
                border: value
                    ? null
                    : .all(color: ringColor ?? colors.textMuted, width: 2),
              ),
              child: value
                  ? Icon(
                      Symbols.check_rounded,
                      size: size * 0.66,
                      color: colors.onPrimary,
                      weight: 700,
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
