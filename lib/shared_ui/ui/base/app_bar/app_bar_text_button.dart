import 'package:clean_architecture/shared_ui/ui/base/buttons/base_text_button.dart';
import 'package:clean_architecture/shared_ui/ui/base/text/base_text.dart';
import 'package:material_ui/material_ui.dart';

class const AppBarTextButton({
  super.key,
  required final void Function() onPressed,
  required final String text,
  final EdgeInsets? padding,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Widget child = BaseTextButton(
      onPressed: onPressed,
      text: text,
      textType: TextType.bodyLarge,
      textFontWeight: FontWeight.w500,
      visualDensity: const VisualDensity(horizontal: -3, vertical: -2),
    );

    if (padding != null) {
      return Padding(padding: padding!, child: child);
    }

    return child;
  }
}
