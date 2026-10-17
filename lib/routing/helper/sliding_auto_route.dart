import 'package:auto_route/auto_route.dart';
import 'package:material_ui/material_ui.dart';

final class SlidingAutoRoute({
  required super.page,
  required super.path,
  super.duration = const Duration(milliseconds: 350),
  AxisDirection slideToward = .left,
}) extends CustomRoute<dynamic> {
  this
    : super(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final beginOffset = switch (slideToward) {
            .up => const Offset(0, 1),
            .down => const Offset(0, -1),
            .right => const Offset(-1, 0),
            .left => const Offset(1, 0),
          };

          final tween = Tween(
            begin: beginOffset,
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOut));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
}
