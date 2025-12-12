// ignore_for_file: constant_identifier_names

/// Represents the 11 corner radius values in the Material 3 scale.
library;

enum CornerStyle {
  /// 0dp - Square
  none(0.0),

  /// 4dp - Extra Small
  xs(4.0),

  /// 8dp - Small
  s(8.0),

  /// 12dp - Medium
  m(12.0),

  /// 16dp - Large
  l(16.0),

  /// 20dp - Large Increased
  l_increased(20.0),

  /// 24dp - Extra Large
  xl(24.0),

  /// 32dp - Extra Large Increased
  xl_increased(32.0),

  /// 40dp - Extra Extra Large
  xxl(40.0),

  /// Dynamic - Fully Rounded (Stadium)
  ///
  /// Uses [double.infinity] to indicate that the radius should be
  /// computed dynamically as height/2 for stadium borders.
  full(double.infinity);

  const CornerStyle(this.value);

  /// The raw corner radius value in logical pixels.
  ///
  /// For [CornerStyle.full], this returns [double.infinity] to indicate
  /// a stadium border where the radius is computed as height/2.
  final double value;

  /// Whether this style represents a fully rounded (stadium) shape.
  bool get isFull => this == CornerStyle.full;
}
