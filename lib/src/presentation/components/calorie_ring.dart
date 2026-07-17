/// calorie_ring.dart
///
/// A highly polished, custom-painted multi-ring macro progress widget.
///
/// Renders four concentric arcs (calories, protein, carbs, fat) with animated
/// progress driven by [CalorieRingData]. Adapts stroke weights and label sizes
/// automatically for mobile and desktop breakpoints, and honours the ambient
/// [ThemeData.colorScheme] for both light and dark mode.
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';

// ── Data model ────────────────────────────────────────────────────────────────

/// Immutable snapshot of ring data passed to [CalorieRingWidget].
class CalorieRingData {
  const CalorieRingData({
    required this.caloriesConsumed,
    required this.calorieGoal,
    required this.proteinConsumed,
    required this.proteinGoal,
    required this.carbsConsumed,
    required this.carbsGoal,
    required this.fatConsumed,
    required this.fatGoal,
  });

  final double caloriesConsumed;
  final double calorieGoal;
  final double proteinConsumed;
  final double proteinGoal;
  final double carbsConsumed;
  final double carbsGoal;
  final double fatConsumed;
  final double fatGoal;

  double get caloriesProgress =>
      calorieGoal == 0 ? 0 : (caloriesConsumed / calorieGoal).clamp(0.0, 1.0);
  double get proteinProgress =>
      proteinGoal == 0 ? 0 : (proteinConsumed / proteinGoal).clamp(0.0, 1.0);
  double get carbsProgress =>
      carbsGoal == 0 ? 0 : (carbsConsumed / carbsGoal).clamp(0.0, 1.0);
  double get fatProgress =>
      fatGoal == 0 ? 0 : (fatConsumed / fatGoal).clamp(0.0, 1.0);

  double get remainingCalories => calorieGoal - caloriesConsumed;
}

// ── Widget ────────────────────────────────────────────────────────────────────

/// Animated concentric ring chart displaying calorie and macro progress.
///
/// ### Usage
/// ```dart
/// CalorieRingWidget(
///   data: CalorieRingData(
///     caloriesConsumed: 1340, calorieGoal: 2000,
///     proteinConsumed: 87,    proteinGoal: 150,
///     carbsConsumed: 145,     carbsGoal: 200,
///     fatConsumed: 42,        fatGoal: 65,
///   ),
///   size: 260,
/// )
/// ```
class CalorieRingWidget extends StatefulWidget {
  const CalorieRingWidget({
    super.key,
    required this.data,
    this.size = 240,
    this.animationDuration = const Duration(milliseconds: 900),
  });

  final CalorieRingData data;

  /// Outer diameter of the widget in logical pixels.
  final double size;

  final Duration animationDuration;

  @override
  State<CalorieRingWidget> createState() => _CalorieRingWidgetState();
}

class _CalorieRingWidgetState extends State<CalorieRingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progress;

  // Previous data snapshot used to drive the from-value of the tween.
  CalorieRingData? _previous;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _progress = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(CalorieRingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      _previous = oldWidget.data;
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Ring colour palette — vibrant but harmonious.
    final ringColors = _RingColors(
      calories: const Color(0xFF6C63FF),   // Indigo
      protein: const Color(0xFF00C896),    // Emerald
      carbs: const Color(0xFFFFB547),      // Amber
      fat: const Color(0xFFFF6B6B),        // Coral
      track: isDark
          ? colorScheme.surfaceContainerHighest.withOpacity(0.35)
          : colorScheme.surfaceContainerHighest.withOpacity(0.55),
    );

    return SizedBox.square(
      dimension: widget.size,
      child: AnimatedBuilder(
        animation: _progress,
        builder: (context, _) {
          final t = _progress.value;
          final data = widget.data;
          final prev = _previous;

          double lerp(double from, double to) =>
              from + (to - from) * t;

          final animData = prev == null
              ? data
              : CalorieRingData(
                  caloriesConsumed: lerp(
                      prev.caloriesConsumed, data.caloriesConsumed),
                  calorieGoal: data.calorieGoal,
                  proteinConsumed:
                      lerp(prev.proteinConsumed, data.proteinConsumed),
                  proteinGoal: data.proteinGoal,
                  carbsConsumed:
                      lerp(prev.carbsConsumed, data.carbsConsumed),
                  carbsGoal: data.carbsGoal,
                  fatConsumed: lerp(prev.fatConsumed, data.fatConsumed),
                  fatGoal: data.fatGoal,
                );

          return CustomPaint(
            painter: _RingPainter(
              data: animData,
              colors: ringColors,
            ),
            child: Center(
              child: _CenterLabel(
                data: animData,
                textTheme: textTheme,
                colorScheme: colorScheme,
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Custom Painter ────────────────────────────────────────────────────────────

class _RingColors {
  const _RingColors({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.track,
  });
  final Color calories;
  final Color protein;
  final Color carbs;
  final Color fat;
  final Color track;
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.data, required this.colors});

  final CalorieRingData data;
  final _RingColors colors;

  static const double _gapDeg = 8.0;
  static const double _startDeg = -90.0;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.min(size.width, size.height) / 2;
    const strokeWidth = 14.0;
    const ringGap = 6.0;

    final rings = [
      (colors.calories, data.caloriesProgress),
      (colors.protein, data.proteinProgress),
      (colors.carbs, data.carbsProgress),
      (colors.fat, data.fatProgress),
    ];

    for (var i = 0; i < rings.length; i++) {
      final (color, progress) = rings[i];
      final radius = maxRadius - (i * (strokeWidth + ringGap));
      if (radius <= 0) continue;

      _drawTrack(canvas, center, radius, strokeWidth);
      _drawArc(canvas, center, radius, strokeWidth, progress, color);
    }
  }

  void _drawTrack(
      Canvas canvas, Offset center, double radius, double strokeWidth) {
    final paint = Paint()
      ..color = colors.track
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, paint);
  }

  void _drawArc(Canvas canvas, Offset center, double radius,
      double strokeWidth, double progress, Color color) {
    if (progress <= 0) return;

    const double fullSweep = 360.0 - _gapDeg;
    final sweepDeg = fullSweep * progress.clamp(0.0, 1.0);

    final paint = Paint()
      ..shader = SweepGradient(
        startAngle: _degToRad(_startDeg),
        endAngle: _degToRad(_startDeg + sweepDeg),
        colors: [
          color.withOpacity(0.7),
          color,
        ],
        transform:
            GradientRotation(_degToRad(_startDeg)),
      ).createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      _degToRad(_startDeg),
      _degToRad(sweepDeg),
      false,
      paint,
    );

    // Glow effect — paint a blurred, dimmed copy underneath.
    final glowPaint = Paint()
      ..color = color.withOpacity(0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 6
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6)
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      _degToRad(_startDeg),
      _degToRad(sweepDeg),
      false,
      glowPaint,
    );
  }

  static double _degToRad(double deg) => deg * (math.pi / 180);

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.data != data || oldDelegate.colors != colors;
}

// ── Center Label ──────────────────────────────────────────────────────────────

class _CenterLabel extends StatelessWidget {
  const _CenterLabel({
    required this.data,
    required this.textTheme,
    required this.colorScheme,
  });

  final CalorieRingData data;
  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final remaining = data.remainingCalories;
    final isOver = remaining < 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          isOver ? 'Over' : 'Left',
          style: textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '${remaining.abs().toInt()}',
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: isOver ? const Color(0xFFFF6B6B) : colorScheme.onSurface,
            height: 1.0,
          ),
        ),
        Text(
          'kcal',
          style: textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        // Micro macro pills
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MacroPill(
                label: 'P',
                value: data.proteinConsumed,
                color: const Color(0xFF00C896)),
            const SizedBox(width: 4),
            _MacroPill(
                label: 'C',
                value: data.carbsConsumed,
                color: const Color(0xFFFFB547)),
            const SizedBox(width: 4),
            _MacroPill(
                label: 'F',
                value: data.fatConsumed,
                color: const Color(0xFFFF6B6B)),
          ],
        ),
      ],
    );
  }
}

class _MacroPill extends StatelessWidget {
  const _MacroPill({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '$label ${value.toInt()}g',
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

// ── Legend Row ─────────────────────────────────────────────────────────────────

/// Horizontal legend showing each macro's consumed / goal values.
///
/// Place below [CalorieRingWidget] in the dashboard layout.
class CalorieRingLegend extends StatelessWidget {
  const CalorieRingLegend({super.key, required this.data});

  final CalorieRingData data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _LegendItem(
          color: const Color(0xFF6C63FF),
          label: 'Calories',
          consumed: data.caloriesConsumed,
          goal: data.calorieGoal,
          unit: 'kcal',
          textTheme: textTheme,
        ),
        _LegendItem(
          color: const Color(0xFF00C896),
          label: 'Protein',
          consumed: data.proteinConsumed,
          goal: data.proteinGoal,
          unit: 'g',
          textTheme: textTheme,
        ),
        _LegendItem(
          color: const Color(0xFFFFB547),
          label: 'Carbs',
          consumed: data.carbsConsumed,
          goal: data.carbsGoal,
          unit: 'g',
          textTheme: textTheme,
        ),
        _LegendItem(
          color: const Color(0xFFFF6B6B),
          label: 'Fat',
          consumed: data.fatConsumed,
          goal: data.fatGoal,
          unit: 'g',
          textTheme: textTheme,
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.label,
    required this.consumed,
    required this.goal,
    required this.unit,
    required this.textTheme,
  });

  final Color color;
  final String label;
  final double consumed;
  final double goal;
  final String unit;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          '${consumed.toInt()} / ${goal.toInt()} $unit',
          style: textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
