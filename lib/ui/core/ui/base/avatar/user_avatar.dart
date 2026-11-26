import 'package:clean_architecture/core/utils/extensions/string_extension.dart';
import 'package:clean_architecture/ui/core/themes/app_gradients.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:flutter/foundation.dart' show Uint8List;
import 'package:material_ui/material_ui.dart';

/// A round avatar: picked photo bytes, else a network image, else initials
/// on the Aurora gradient.
class const UserAvatar({
  super.key,
  required final String name,
  final Uint8List? bytes,
  final String? imageUrl,
  final double size = 48,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final initials = Container(
      alignment: .center,
      decoration: const BoxDecoration(gradient: AppGradients.aurora),
      child: Text(
        name.initials,
        style: context.text.headline.copyWith(
          color: context.colors.onPrimary,
          fontSize: size * 0.36,
        ),
      ),
    );
    final image = switch ((bytes, imageUrl)) {
      (final bytes?, _) => Image.memory(bytes, fit: .cover),
      (_, final url?) when url.isNotEmpty => Image.network(
        url,
        fit: .cover,
        errorBuilder: (_, _, _) => initials,
      ),
      _ => initials,
    };
    return Semantics(
      image: true,
      label: name,
      child: Container(
        width: size,
        height: size,
        clipBehavior: .antiAlias,
        decoration: BoxDecoration(
          shape: .circle,
          color: context.colors.surfaceRaised,
          border: .all(color: context.colors.outline),
        ),
        child: image,
      ),
    );
  }
}
