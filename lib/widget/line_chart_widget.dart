import 'package:flutter/material.dart';

/// Simple line chart with circular data points. No external package.
class LineChartWidget extends StatelessWidget {
  const LineChartWidget({
    super.key,
    required this.labels,
    required this.values,
    this.color = const Color(0xFF2196F3),
    this.maxY,
    this.yTickCount = 5,
    this.chartHeight = 220,
    this.pointRadius = 5,
    this.lineWidth = 2.5,
    this.yLabelFormat,
  });

  /// X-axis labels (e.g. ['Jan', 'Feb', ...]).
  final List<String> labels;

  /// Y values; must have same length as [labels].
  final List<double> values;

  /// Line and point color.
  final Color color;

  /// Max value for Y-axis. If null, computed from values.
  final double? maxY;

  /// Number of horizontal grid lines / Y ticks (including 0).
  final int yTickCount;

  /// Height of the chart area.
  final double chartHeight;

  /// Radius of data point circles.
  final double pointRadius;

  /// Line stroke width.
  final double lineWidth;

  /// Optional formatter for Y-axis labels.
  final String Function(double)? yLabelFormat;

  double get _effectiveMaxY {
    if (maxY != null && maxY! > 0) return maxY!;
    double m = 0;
    for (final v in values) {
      if (v > m) m = v;
    }
    return m <= 0 ? 100 : m;
  }

  @override
  Widget build(BuildContext context) {
    final maxVal = _effectiveMaxY;
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(constraints.maxWidth, chartHeight),
          painter: _LineChartPainter(
            labels: labels,
            values: values,
            color: color,
            maxY: maxVal,
            yTickCount: yTickCount,
            pointRadius: pointRadius,
            lineWidth: lineWidth,
            yLabelFormat: yLabelFormat,
          ),
        );
      },
    );
  }
}

class _LineChartPainter extends CustomPainter {
  _LineChartPainter({
    required this.labels,
    required this.values,
    required this.color,
    required this.maxY,
    required this.yTickCount,
    required this.pointRadius,
    required this.lineWidth,
    this.yLabelFormat,
  });

  final List<String> labels;
  final List<double> values;
  final Color color;
  final double maxY;
  final int yTickCount;
  final double pointRadius;
  final double lineWidth;
  final String Function(double)? yLabelFormat;

  static const double _leftPadding = 44;
  static const double _bottomPadding = 28;
  static const double _rightPadding = 12;
  static const double _topPadding = 8;

  String _format(double value) {
    if (yLabelFormat != null) return yLabelFormat!(value);
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(0)}K';
    return value.toStringAsFixed(0);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final chartLeft = _leftPadding;
    final chartRight = size.width - _rightPadding;
    final chartTop = _topPadding;
    final chartBottom = size.height - _bottomPadding;
    final chartWidth = chartRight - chartLeft;
    final chartHeight = chartBottom - chartTop;

    final gridColor = Colors.black.withValues(alpha: 0.12);
    final axisColor = Colors.black54;

    final textPainter = (String text, double fontSize, Color c) {
      final tp = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            fontFamily: 'Roboto Flex',
            fontSize: fontSize,
            color: c,
            fontWeight: FontWeight.w400,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      return tp;
    };

    // Y-axis labels and horizontal dashed lines
    for (int i = 0; i < yTickCount; i++) {
      final t = i / (yTickCount - 1);
      final value = (1 - t) * maxY;
      final y = chartTop + t * chartHeight;

      final label = _format(value);
      final tp = textPainter(label, 10, axisColor);
      tp.paint(canvas, Offset(0, y - tp.height / 2));

      if (i > 0) {
        _drawDashedLine(
          canvas,
          Offset(chartLeft, y),
          Offset(chartRight, y),
          gridColor,
          4,
          4,
        );
      }
    }

    final n = labels.length;
    if (n == 0 || values.isEmpty) return;

    final groupWidth = chartWidth / (n - 1);
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final pointPaint = Paint()..color = color;

    // Compute points
    final points = <Offset>[];
    for (int i = 0; i < n && i < values.length; i++) {
      final x = chartLeft + i * groupWidth;
      final v = values[i].clamp(0.0, maxY);
      final normalized = maxY > 0 ? (v / maxY) : 0.0;
      final y = chartBottom - normalized * chartHeight;
      points.add(Offset(x, y));
    }

    // Draw line
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], linePaint);
    }

    // Draw points (filled circles)
    for (final p in points) {
      canvas.drawCircle(p, pointRadius, pointPaint);
    }

    // X-axis labels
    for (int i = 0; i < n; i++) {
      final cx = chartLeft + i * groupWidth;
      final tp = textPainter(labels[i], 11, axisColor);
      tp.paint(canvas, Offset(cx - tp.width / 2, chartBottom + 4));
    }
  }

  void _drawDashedLine(
    Canvas canvas,
    Offset start,
    Offset end,
    Color color,
    double dash,
    double gap,
  ) {
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final len = Offset(dx, dy).distance;
    if (len == 0) return;
    final step = dash + gap;
    final count = (len / step).floor();
    final paint = Paint()..color = color..strokeWidth = 1;
    for (int i = 0; i <= count; i++) {
      final t0 = (i * step) / len;
      final t1 = ((i * step + dash) / len).clamp(0.0, 1.0);
      if (t0 <= 1.0) {
        canvas.drawLine(
          Offset(start.dx + dx * t0, start.dy + dy * t0),
          Offset(start.dx + dx * t1, start.dy + dy * t1),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return oldDelegate.labels != labels ||
        oldDelegate.values != values ||
        oldDelegate.maxY != maxY;
  }
}
