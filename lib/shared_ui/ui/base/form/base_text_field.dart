import 'package:clean_architecture/core/constants/app_colors.dart';
import 'package:clean_architecture/shared_ui/ui/base/text/base_text.dart';
import 'package:clean_architecture/shared_ui/utils/ui_helpers.dart';
import 'package:material_ui/material_ui.dart';

class const BaseTextField({
  super.key,
  final String? title,
  final Color? titleColor,
  final TextType? titleSize,
  final FontWeight? titleFontWeight,
  final TextEditingController? controller,
  final TextInputType keyboardType = TextInputType.text,
  final bool readOnly = false,
  final String? initialValue,
  final void Function(String?)? onChanged,
  final String? Function(String?)? validator,
  final AutovalidateMode? autovalidateMode,
  final bool obscureText = false,
  final FocusNode? focusNode,
  final String hintText = '',
  final Widget? prefixIcon,
  final Widget? suffixIcon,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget child = TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      initialValue: initialValue,
      onChanged: onChanged,
      validator: validator,
      readOnly: readOnly,
      autovalidateMode: autovalidateMode,
      obscureText: obscureText,
      obscuringCharacter: '*',
      style: const TextStyle(color: AppColors.base, fontSize: 16),
      focusNode: focusNode,
      decoration: InputDecoration(
        contentPadding: UIHelpers.paddingA16,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
      ),
    );

    if (title != null) {
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseText(
            title!,
            color: titleColor,
            textType: titleSize ?? TextType.titleSmall,
          ),
          UIHelpers.spaceV8,
          child,
        ],
      );
    }

    return child;
  }
}
