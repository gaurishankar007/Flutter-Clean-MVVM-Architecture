import 'package:clean_architecture/core/constants/app_colors.dart';
import 'package:clean_architecture/shared_ui/ui/base/text/base_text.dart';
import 'package:clean_architecture/shared_ui/utils/ui_helpers.dart';
import 'package:material_ui/material_ui.dart';

class const IconTextButton({
  super.key,
  required final void Function() onPressed,
  required final IconData iconData,
  required final String text,
  final Color? iconColor,
  final double? iconSize,
  final Color? textColor,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color newIconColor = iconColor ?? AppColors.base;

    return InkWell(
      onTap: onPressed,
      borderRadius: UIHelpers.radiusC4,
      child: Padding(
        padding: UIHelpers.paddingA4,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, color: newIconColor, size: iconSize),
            UIHelpers.spaceH4,
            BaseText(text, color: textColor),
          ],
        ),
      ),
    );
  }
}
