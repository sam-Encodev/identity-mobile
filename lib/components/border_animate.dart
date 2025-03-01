import 'package:flutter/material.dart';

class BorderAnimate extends StatefulWidget {
  final Widget child;
  final List<Color> colors;
  final Duration duration;
  final double strokeWidth;
  final double blurRadius;
  final BorderRadius borderRadius;
  final bool showBlur;
  final double width;
  final double height;

  const BorderAnimate({
    super.key,
    required this.child,
    this.colors = const [Colors.transparent],
    this.duration = const Duration(seconds: 3),
    this.strokeWidth = 5,
    this.blurRadius = 15,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.showBlur = true,
    this.width = 300,
    this.height = 200,
  });

  @override
  BorderAnimateState createState() => BorderAnimateState();
}

class BorderAnimateState extends State<BorderAnimate>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BorderAnimatePainter(
        progress: _animation.value,
        colors: widget.colors,
        strokeWidth: widget.strokeWidth,
        blurRadius: widget.blurRadius,
        borderRadius: widget.borderRadius,
        showBlur: widget.showBlur,
      ),
      child: Container(child: widget.child),
    );
  }
}

class _BorderAnimatePainter extends CustomPainter {
  final double progress;
  final List<Color> colors;
  final double strokeWidth;
  final double blurRadius;
  final BorderRadius borderRadius;
  final bool showBlur;

  _BorderAnimatePainter({
    required this.progress,
    required this.colors,
    required this.strokeWidth,
    required this.blurRadius,
    required this.borderRadius,
    required this.showBlur,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final gradient = SweepGradient(
      colors: colors,
      stops: List.generate(
        colors.length,
        (index) => index / (colors.length - 1),
      ),
      startAngle: 0,
      endAngle: 2 * 3.141592653589793,
      transform: GradientRotation(progress * 2 * 3.141592653589793),
    );

    final paint =
        Paint()
          ..shader = gradient.createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

    final path =
        Path()..addRRect(RRect.fromRectAndRadius(rect, borderRadius.topLeft));

    canvas.drawPath(path, paint);

    if (showBlur) {
      final blurPaint =
          Paint()
            ..shader = gradient.createShader(rect)
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius);

      canvas.drawPath(path, blurPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
