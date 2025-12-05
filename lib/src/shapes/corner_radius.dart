import 'corner_style.dart';

/// Helper class for mapping [CornerStyle] to [double] values.
class CornerRadius {
  const CornerRadius._();

  /// Map of [CornerStyle] to their radius values.
  static const Map<CornerStyle, double> values = {
    CornerStyle.none: 0.0,
    CornerStyle.xs: 4.0,
    CornerStyle.s: 8.0,
    CornerStyle.m: 12.0,
    CornerStyle.l: 16.0,
    CornerStyle.l_inc: 20.0,
    CornerStyle.xl: 24.0,
    CornerStyle.xl_inc: 32.0,
    CornerStyle.xxl: 40.0,
    CornerStyle.full: -1.0, // Handled dynamically
  };

  /// Gets the radius value for a given [CornerStyle].
  ///
  /// Returns -1.0 for [CornerStyle.full].
  static double getValue(CornerStyle style) {
    return values[style] ?? 0.0;
  }
}
