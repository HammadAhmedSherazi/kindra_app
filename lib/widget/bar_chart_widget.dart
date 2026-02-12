import 'package:flutter/material.dart';

/// One data series: list of values and color.
class BarChartSeries {
  final List<double> values;
  final Color color;

  const BarChartSeries({required this.values, required this.color});
}

/// Generic bar chart with optional dark theme, dashed grid, Y-axis labels,
/// multiple series per category, and rounded bar tops. No external package.
class BarChartWidget extends StatelessWidget {
  const BarChartWidget({
    super.key,
    required this.labels,
    required this.series,
    this.maxY,
    this.yTickCount = 5,
    this.barRadius = 6,
    this.barGap = 6,
    this.darkTheme = true,
    this.chartHeight = 220,
    this.yLabelFormat,
  });

  /// X-axis labels (e.g. ['Jan', 'Feb', ...]).
  final List<String> labels;

  /// One or more series; each series must have same length as [labels].
  final List<BarChartSeries> series;

  /// Max value for Y-axis. If null, computed from all series.
  final double? maxY;

  /// Number of horizontal grid lines / Y ticks (including 0).
  final int yTickCount;

  /// Top corner radius of bars.
  final double barRadius;

  /// Gap between bars within same category.
  final double barGap;

  /// Dark background with dashed white grid; if false, light theme.
  final bool darkTheme;

  /// Height of the chart area (excluding title and axis labels).
  final double chartHeight;

  /// Optional formatter for Y-axis labels (e.g. 150000 -> "150K").
  final String Function(double)? yLabelFormat;

  double get _effectiveMaxY {
    if (maxY != null && maxY! > 0) return maxY!;
    double m = 0;
    for (final s in series) {
      for (final v in s.values) {
        if (v > m) m = v;
      }
    }
    return m <= 0 ? 1 : m;
  }

  @override
  Widget build(BuildContext context) {
    final maxVal = _effectiveMaxY;
    final bgColor = darkTheme ? Colors.black : Colors.white;
    final gridColor = darkTheme ? Colors.white.withValues(alpha: 0.35) : Colors.black.withValues(alpha: 0.12);
    final textColor = darkTheme ? Colors.white : Colors.black87;
    final axisColor = darkTheme ? Colors.white.withValues(alpha: 0.6) : Colors.black54;

    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(constraints.maxWidth, chartHeight),
          painter: _BarChartPainter(
            labels: labels,
            series: series,
            maxY: maxVal,
            yTickCount: yTickCount,
            barRadius: barRadius,
            barGap: barGap,
            backgroundColor: bgColor,
            gridColor: gridColor,
            textColor: textColor,
            axisColor: axisColor,
            yLabelFormat: yLabelFormat,
          ),
        );
      },
    );
  }
}

class _BarChartPainter extends CustomPainter {
  _BarChartPainter({
    required this.labels,
    required this.series,
    required this.maxY,
    required this.yTickCount,
    required this.barRadius,
    required this.barGap,
    required this.backgroundColor,
    required this.gridColor,
    required this.textColor,
    required this.axisColor,
    this.yLabelFormat,
  });

  final List<String> labels;
  final List<BarChartSeries> series;
  final double maxY;
  final int yTickCount;
  final double barRadius;
  final double barGap;
  final Color backgroundColor;
  final Color gridColor;
  final Color textColor;
  final Color axisColor;
  final String Function(double)? yLabelFormat;

  static const double _leftPadding = 44;
  static const double _bottomPadding = 28;
  static const double _rightPadding = 12;
  static const double _topPadding = 8;

  @override
  void paint(Canvas canvas, Size size) {
    final chartLeft = _leftPadding;
    final chartRight = size.width - _rightPadding;
    final chartTop = _topPadding;
    final chartBottom = size.height - _bottomPadding;
    final chartWidth = chartRight - chartLeft;
    final chartHeight = chartBottom - chartTop;

    // Background
    final bgRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(bgRect, Paint()..color = backgroundColor);

    final textPainter = (String text, double fontSize, Color color) {
      final tp = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            fontFamily: 'Roboto Flex',
            fontSize: fontSize,
            color: color,
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

      final label = yLabelFormat != null ? yLabelFormat!(value) : _defaultFormat(value);
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

    // X-axis labels and vertical dashed lines
    final n = labels.length;
    if (n == 0) return;

    final groupWidth = chartWidth / n;
    final barGroupWidth = groupWidth * 0.72;
    final barW = (barGroupWidth - (series.length - 1) * barGap) / series.length;
    final barWClamped = barW.clamp(8.0, 22.0);
    final totalBarWidth = series.length * barWClamped + (series.length - 1) * barGap;

    for (int i = 0; i < n; i++) {
      final cx = chartLeft + (i + 0.5) * groupWidth;
      final xLabel = labels[i];
      final tp = textPainter(xLabel, 11, axisColor);
      tp.paint(
        canvas,
        Offset(cx - tp.width / 2, chartBottom + 4),
      );

      final lineX = chartLeft + (i + 1) * groupWidth;
      if (i < n - 1) {
        _drawDashedLine(
          canvas,
          Offset(lineX, chartTop),
          Offset(lineX, chartBottom),
          gridColor,
          4,
          4,
        );
      }
    }

    // Bars
    var barOffset = -totalBarWidth / 2 + barWClamped / 2;

    for (int sIdx = 0; sIdx < series.length; sIdx++) {
      final s = series[sIdx];
      final barPaint = Paint()..color = s.color;

      for (int i = 0; i < n && i < s.values.length; i++) {
        final cx = chartLeft + (i + 0.5) * groupWidth;
        final x = cx + barOffset;
        final v = s.values[i].clamp(0.0, maxY);
        final h = maxY > 0 ? (v / maxY) * chartHeight : 0.0;
        final top = chartBottom - h;
        final barRect = RRect.fromRectAndCorners(
          Rect.fromLTWH(x - barWClamped / 2, top, barWClamped, h),
          topLeft: Radius.circular(barRadius),
          topRight: Radius.circular(barRadius),
        );
        canvas.drawRRect(barRect, barPaint);
      }

      barOffset += barWClamped + barGap;
    }
  }

  String _defaultFormat(double value) {
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(0)}K';
    return value.toStringAsFixed(0);
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Color color, double dash, double gap) {
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final len = (Offset(dx, dy)).distance;
    if (len == 0) return;
    final step = dash + gap;
    final count = (len / step).floor();
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    for (int i = 0; i <= count; i++) {
      final t0 = (i * step) / len;
      final t1 = ((i * step + dash) / len).clamp(0.0, 1.0);
      if (t0 <= 1.0) {
        final p0 = Offset(start.dx + dx * t0, start.dy + dy * t0);
        final p1 = Offset(start.dx + dx * t1, start.dy + dy * t1);
        canvas.drawLine(p0, p1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BarChartPainter oldDelegate) {
    return oldDelegate.labels != labels ||
        oldDelegate.series != series ||
        oldDelegate.maxY != maxY ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
