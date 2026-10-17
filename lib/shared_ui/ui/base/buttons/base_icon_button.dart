import 'package:material_ui/material_ui.dart';

class const BaseIconButton({
  super.key,
  required final void Function() onPressed,
  required final Icon icon,
  final double? splashRadius,
  final EdgeInsets? padding,
  final BoxConstraints? boxConstraints,
  final VisualDensity? visualDensity,
  final double? targetSize,
  final bool disableSplash = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget child = IconButton(
      splashRadius: splashRadius,
      onPressed: onPressed,
      padding: padding ?? EdgeInsets.zero,
      constraints: boxConstraints ?? const BoxConstraints(),
      visualDensity:
          visualDensity ?? const VisualDensity(horizontal: -4, vertical: -4),
      highlightColor: disableSplash ? Colors.transparent : null,
      icon: icon,
    );

    if (disableSplash) {
      child = Theme(
        data: ThemeData(splashFactory: NoSplash.splashFactory),
        child: child,
      );
    }

    if (targetSize != null) {
      child = SizedBox(height: targetSize, width: targetSize, child: child);
    }

    return child;
  }
}
