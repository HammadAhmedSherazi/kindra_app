import 'package:flutter/material.dart';

/// Custom back arrow (left-pointing chevron). Fixed size, black stroke.
class CustomBackArrowWidget extends StatelessWidget {
  const CustomBackArrowWidget({
    super.key,
    this.width = 10,
    this.height = 16,
    this.color = Colors.black,
    this.strokeWidth = 2.0,
  });

  final double width;
  final double height;
  final Color color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _BackArrowPainter(
          color: color,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _BackArrowPainter extends CustomPainter {
  _BackArrowPainter({
    required this.color,
    required this.strokeWidth,
  });

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;
    // Left-pointing chevron: top-left to center to bottom-left
    final path = Path()
      ..moveTo(w, 0)
      ..lineTo(0, h * 0.5)
      ..lineTo(w, h);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BackArrowPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}
