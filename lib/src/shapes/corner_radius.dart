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
    CornerStyle.l_increased: 20.0,
    CornerStyle.xl: 24.0,
    CornerStyle.xl_increased: 32.0,
    CornerStyle.xxl: 40.0,
    CornerStyle.full: double.infinity,
  };

  /// Gets the radius value for a given [CornerStyle].
  ///
  /// Returns [double.infinity] for [CornerStyle.full], indicating a stadium
  /// border where the radius should be computed as height/2.
  static double getValue(CornerStyle style) {
    return values[style] ?? 0.0;
  }
}
