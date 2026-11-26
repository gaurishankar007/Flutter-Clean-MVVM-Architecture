import 'package:clean_architecture/ui/core/themes/app_gradients.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:material_ui/material_ui.dart';

/// A soft, blurred Aurora glow behind a screen's header. Decoration only.
class const AuroraGlow({super.key, final double height = 320})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final opacity = context.isDark ? 0.28 : 0.16;
    // The mask fades the glow out before its box ends, so no edge shows.
    return IgnorePointer(
      child: ShaderMask(
        blendMode: .dstIn,
        shaderCallback: const LinearGradient(
          begin: .topCenter,
          end: .bottomCenter,
          colors: [Colors.white, Colors.transparent],
          stops: [0.5, 1],
        ).createShader,
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.6, -1.1),
                radius: 1.3,
                colors: [
                  AppGradients.auroraColors[0].withValues(alpha: opacity),
                  AppGradients.auroraColors[2].withValues(alpha: opacity * 0.5),
                  Colors.transparent,
                ],
                stops: const [0, 0.45, 1],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
