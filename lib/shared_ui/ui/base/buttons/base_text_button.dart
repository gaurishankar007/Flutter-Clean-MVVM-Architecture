import 'package:clean_architecture/core/constants/app_colors.dart';
import 'package:clean_architecture/shared_ui/ui/base/text/base_text.dart';
import 'package:material_ui/material_ui.dart';

class const BaseTextButton({
  super.key,
  required final void Function() onPressed,
  required final String text,
  final Color? textColor,
  final TextType? textType,
  final FontWeight? textFontWeight,
  final Color? color,
  final EdgeInsets? padding,
  final VisualDensity? visualDensity,
  final double? elevation,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color,
        padding: padding,
        visualDensity: visualDensity,
        elevation: elevation,
      ),
      child: BaseText(
        text,
        color: textColor ?? AppColors.hightLight,
        textType: textType ?? TextType.bodyLarge,
        fontWeight: textFontWeight ?? FontWeight.w400,
      ),
    );
  }
}
