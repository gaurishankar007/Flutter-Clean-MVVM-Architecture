import 'dart:math' as math;

import 'package:clean_architecture/ui/core/themes/app_gradients.dart';
import 'package:clean_architecture/ui/core/themes/app_motion.dart';
import 'package:clean_architecture/ui/core/themes/theme.dart';
import 'package:material_ui/material_ui.dart';

/// A circular progress ring painted with the Aurora gradient, animating
/// between values. [child] sits in the middle (e.g. the percentage).
class const ProgressRing({
  super.key,
  required final double value,
  final double size = 72,
  final double strokeWidth = 8,
  final Widget? child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final track = context.colors.surfaceRaised;
    return Semantics(
      value: '${(value * 100).round()}%',
      child: SizedBox.square(
        dimension: size,
        child: TweenAnimationBuilder<double>(
          tween: Tween(end: value.clamp(0, 1)),
          duration: MediaQuery.disableAnimationsOf(context)
              ? .zero
              : AppMotion.slow,
          curve: AppMotion.emphasized,
          builder: (context, fraction, child) => CustomPaint(
            painter: _RingPainter(
              fraction: fraction,
              strokeWidth: strokeWidth,
              track: track,
            ),
            child: child,
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}

class const _RingPainter({
  required final double fraction,
  required final double strokeWidth,
  required final Color track,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final arcRect = rect.deflate(strokeWidth / 2);
    final base = Paint()
      ..style = .stroke
      ..strokeWidth = strokeWidth
      ..color = track;
    canvas.drawArc(arcRect, 0, math.pi * 2, false, base);
    if (fraction <= 0) {
      return;
    }
    final progress = Paint()
      ..style = .stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = .round
      ..shader = const SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: math.pi * 1.5,
        colors: AppGradients.auroraColors,
        transform: GradientRotation(-math.pi / 2),
      ).createShader(rect);
    canvas.drawArc(
      arcRect,
      -math.pi / 2,
      math.pi * 2 * fraction,
      false,
      progress,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.fraction != fraction || old.track != track;
}
