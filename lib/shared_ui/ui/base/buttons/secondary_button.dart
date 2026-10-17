import 'package:clean_architecture/core/constants/app_colors.dart';
import 'package:clean_architecture/shared_ui/ui/base/loading_circle.dart';
import 'package:clean_architecture/shared_ui/ui/base/text/base_text.dart';
import 'package:clean_architecture/shared_ui/utils/screen_util/screen_util.dart';
import 'package:clean_architecture/shared_ui/utils/ui_helpers.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

class const SecondaryButton({
  super.key,
  required final Future<void> Function() onTap,
  required final String text,
  final TextType textType = .bodyLarge,
  final FontWeight textFontWeight = .w500,
  final Color? foregroundColor = AppColors.primary,
  final double? height,
  final double? width,
  final Color color = AppColors.primary,
  final bool loadableButton = false,
  final double? elevation,
  final bool expandWidth = false,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final loadingNotifier = useValueNotifier(false);
    final onPressed = useCallback(() async {
      /// If the button is loading, discard the task
      if (loadingNotifier.value) {
        return;
      }

      /// If the button is not loadable
      if (!loadableButton) {
        return await onTap();
      }

      loadingNotifier.value = true;
      await onTap();

      /// If the widget is disposed, don't update value
      if (context.mounted) {
        loadingNotifier.value = false;
      }
    });

    return SizedBox(
      height: height ?? ScreenUtil.I.actionHeight,
      width: expandWidth ? double.maxFinite : width,
      child: ValueListenableBuilder(
        valueListenable: loadingNotifier,
        builder: (builderContext, loading, setState) {
          return OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.white,
              side: BorderSide(color: color, width: 1.5),
              shape: RoundedRectangleBorder(borderRadius: UIHelpers.radiusC8),
              elevation: elevation ?? 0,
              splashFactory: InkRipple.splashFactory,
            ),
            child: loading
                ? LoadingCircle.small(foregroundColor)
                : BaseText(
                    text,
                    color: foregroundColor,
                    textType: textType,
                    fontWeight: textFontWeight,
                  ),
          );
        },
      ),
    );
  }
}
