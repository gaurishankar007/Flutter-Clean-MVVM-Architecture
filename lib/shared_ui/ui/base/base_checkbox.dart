import 'package:clean_architecture/core/constants/app_colors.dart';
import 'package:clean_architecture/shared_ui/ui/base/text/base_text.dart';
import 'package:clean_architecture/shared_ui/utils/ui_helpers.dart';
import 'package:material_ui/material_ui.dart';

class const BaseCheckbox({
  super.key,
  final double? scale = .85,
  required final bool value,
  final void Function(bool?)? onChanged,
  final String? title,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget child = Transform.scale(
      scale: scale,
      child: Checkbox(
        value: value,
        fillColor: WidgetStateColor.resolveWith(
          (states) => value ? AppColors.hightLight : Colors.transparent,
        ),
        side: value ? null : const BorderSide(width: 1.2),
        onChanged: onChanged,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );

    if (title != null) {
      final textColor = value ? AppColors.hightLight : AppColors.base;
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          UIHelpers.spaceH8,
          BaseText(title!, color: textColor, fontWeight: FontWeight.w500),
        ],
      );
    }

    return child;
  }
}
