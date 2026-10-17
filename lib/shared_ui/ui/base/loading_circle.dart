import 'package:material_ui/material_ui.dart';

class const LoadingCircle({
  super.key,
  final double strokeWidth = 4,
  final double height = 30,
  final double width = 30,
  final Color? color,
  final bool centered = true,
}) extends StatefulWidget {
  factory small([Color? color]) =>
      LoadingCircle(strokeWidth: 2, height: 20, width: 20, color: color);

  @override
  State<LoadingCircle> createState() => _LoadingCircleState();
}

class _LoadingCircleState extends State<LoadingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.color != null) {
      return;
    }

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    colorAnimation = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.deepPurple, end: Colors.indigo),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.indigo, end: Colors.pink),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.pink, end: Colors.teal),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.teal, end: Colors.deepPurple),
        weight: 25,
      ),
    ]).animate(controller);
  }

  @override
  void dispose() {
    // Dispose animation controller only if it is initialized
    // The animation controller is initialized only when the color is null
    if (widget.color == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget child = SizedBox(
      height: widget.height,
      width: widget.width,
      child: switch (widget.color) {
        final Color color => CircularProgressIndicator(
          color: color,
          strokeWidth: widget.strokeWidth,
        ),
        null => AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return CircularProgressIndicator(
              color: colorAnimation.value,
              strokeWidth: widget.strokeWidth,
            );
          },
        ),
      },
    );

    if (widget.centered) {
      return Center(child: child);
    }
    return child;
  }
}
