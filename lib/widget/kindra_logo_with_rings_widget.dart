import 'package:flutter/material.dart';
import '../utils/assets.dart';

/// Draws exactly 3 partial ring segments (light grey) behind the Kindra logo —
/// concentric arcs from top edge curving down and to the left, as in the design.
class _KindraRingsPainter extends CustomPainter {
  static const Color _ringColor = Color(0xFFD4D4D4);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Center of the 3 concentric rings (top-right of visible area so we see only "parts" of rings)
    final centerX = size.width * 0.85;
    final centerY = size.height * -0.15;

    // Exactly 3 rings — only the segment from top curving downwards and to the left
    const int ringCount = 3;
    final maxRadius = size.longestSide * 0.75;

    for (int i = 1; i <= ringCount; i++) {
      final radius = maxRadius * (i / ringCount);
      final rect = Rect.fromCircle(
        center: Offset(centerX, centerY),
        radius: radius,
      );
      // Draw only the visible part of each ring: arc from top toward bottom-left (~120°)
      canvas.drawArc(
        rect,
        2.05 * 3.14159, // start: top-left area
        1.15 * 3.14159, // sweep: curve down and left (part of ring)
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Kindra text logo with decorative ring elements in the background (as in brand image).
class KindraLogoWithRingsWidget extends StatelessWidget {
  final double logoWidth;
  final double logoHeight;
  final double? width;
  final double? height;

  const KindraLogoWithRingsWidget({
    super.key,
    this.logoWidth = 150,
    this.logoHeight = 70,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final w = width ?? logoWidth + 80;
    final h = height ?? logoHeight + 80;

    return SizedBox(
      width: w,
      height: h,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _KindraRingsPainter(),
              size: Size(w, h),
            ),
          ),
          Image.asset(
            Assets.kindraTextLogo,
            width: logoWidth,
            height: logoHeight,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
