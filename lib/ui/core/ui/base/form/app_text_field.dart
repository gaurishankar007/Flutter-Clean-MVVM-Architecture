import 'package:clean_architecture/ui/core/themes/app_spacing.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:material_ui/material_ui.dart';

/// A labelled text field on a raised surface. [errorText] comes from the
/// notifier's state (validation is business logic), not from a `Form`.
class const AppTextField({
  super.key,
  required final TextEditingController controller,
  final String? label,
  final String? hint,
  final String? errorText,
  final IconData? icon,
  final Widget? trailing,
  final bool obscureText = false,
  final bool autofocus = false,
  final int minLines = 1,
  final int maxLines = 1,
  final int? maxLength,
  final TextInputType? keyboardType,
  final TextInputAction? textInputAction,
  final TextCapitalization textCapitalization = .none,
  final Iterable<String>? autofillHints,
  final ValueChanged<String>? onChanged,
  final ValueChanged<String>? onSubmitted,
  final FocusNode? focusNode,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: color, width: width),
        );

    return Column(
      crossAxisAlignment: .stretch,
      spacing: AppSpacing.sm,
      children: [
        if (label != null)
          Text(
            label!,
            style: context.text.label.copyWith(color: colors.textSecondary),
          ),
        TextField(
          controller: controller,
          focusNode: focusNode,
          autofocus: autofocus,
          obscureText: obscureText,
          minLines: obscureText ? 1 : minLines,
          maxLines: obscureText ? 1 : maxLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          autofillHints: autofillHints,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: context.text.body,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: context.text.body.copyWith(color: colors.textMuted),
            errorText: errorText,
            errorStyle: context.text.caption.copyWith(color: colors.error),
            filled: true,
            fillColor: colors.surfaceRaised,
            counterText: '',
            prefixIcon: icon == null
                ? null
                : Icon(icon, size: 20, color: colors.textMuted),
            suffixIcon: trailing,
            contentPadding: const .symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md + 2,
            ),
            border: border(colors.outline),
            enabledBorder: border(colors.outline),
            focusedBorder: border(colors.primaryText, 1.5),
            errorBorder: border(colors.error),
            focusedErrorBorder: border(colors.error, 1.5),
          ),
        ),
      ],
    );
  }
}
