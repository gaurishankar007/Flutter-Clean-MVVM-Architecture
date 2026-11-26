import 'package:clean_architecture/core/messages/app_messages.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

class const PasswordVisibilityButton({
  super.key,
  required final bool obscured,
  required final VoidCallback onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: obscured ? AuthMessages.showPassword : AuthMessages.hidePassword,
      onPressed: onPressed,
      icon: Icon(
        obscured ? Symbols.visibility_rounded : Symbols.visibility_off_rounded,
        size: 20,
        color: context.colors.textMuted,
      ),
    );
  }
}
