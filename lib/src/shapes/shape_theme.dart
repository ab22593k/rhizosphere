import 'package:flutter/material.dart';
import 'corner_style.dart';
import 'corner_radius.dart';
import 'shape_borders.dart';

/// Theme extension for shape tokens.
class ShapeTheme extends ThemeExtension<ShapeTheme> {
  const ShapeTheme({
    required this.cornerStyles,
    required this.defaultBorderRadius,
    this.morphDuration = const Duration(milliseconds: 300),
    this.morphCurve = Curves.easeOutCubic,
  });

  /// Map of [CornerStyle] to radius values.
  final Map<CornerStyle, double> cornerStyles;

  /// Default corner style to use when none is specified.
  final CornerStyle defaultBorderRadius;

  /// Duration for shape morphing animations.
  final Duration morphDuration;

  /// Curve for shape morphing animations.
  final Curve morphCurve;

  /// Returns a [BorderRadius] for the given [style].
  ///
  /// If [style] is [CornerStyle.full], this returns a large value (9999)
  /// to simulate a stadium border when applied to a RoundedRectangleBorder.
  BorderRadius borderRadius(CornerStyle style) {
    if (style == CornerStyle.full) {
      return BorderRadius.circular(9999);
    }
    return BorderRadius.circular(cornerStyles[style] ?? 0.0);
  }

  @override
  ThemeExtension<ShapeTheme> copyWith({
    Map<CornerStyle, double>? cornerStyles,
    CornerStyle? defaultBorderRadius,
    Duration? morphDuration,
    Curve? morphCurve,
  }) {
    return ShapeTheme(
      cornerStyles: cornerStyles ?? this.cornerStyles,
      defaultBorderRadius: defaultBorderRadius ?? this.defaultBorderRadius,
      morphDuration: morphDuration ?? this.morphDuration,
      morphCurve: morphCurve ?? this.morphCurve,
    );
  }

  @override
  ThemeExtension<ShapeTheme> lerp(ThemeExtension<ShapeTheme>? other, double t) {
    if (other is! ShapeTheme) return this;
    return ShapeTheme(
      cornerStyles: cornerStyles, // Styles are static, no lerp needed
      defaultBorderRadius: t < 0.5
          ? defaultBorderRadius
          : other.defaultBorderRadius,
      morphDuration: other.morphDuration,
      morphCurve: other.morphCurve,
    );
  }

  /// Creates a default [ShapeTheme].
  static ShapeTheme get defaults => ShapeTheme(
    cornerStyles: CornerRadius.values,
    defaultBorderRadius: CornerStyle.m,
  );

  /// Creates a [TokenRoundedRectangleBorder] with the given styles.
  TokenRoundedRectangleBorder roundedRectangle({
    CornerStyle? topStart,
    CornerStyle? topEnd,
    CornerStyle? bottomStart,
    CornerStyle? bottomEnd,
  }) {
    return TokenRoundedRectangleBorder(
      topStart: topStart ?? defaultBorderRadius,
      topEnd: topEnd ?? defaultBorderRadius,
      bottomStart: bottomStart ?? defaultBorderRadius,
      bottomEnd: bottomEnd ?? defaultBorderRadius,
    );
  }

  /// Creates a [TokenCutCornerBorder] with the given style.
  TokenCutCornerBorder cutCorner({
    CornerStyle? topStart,
    CornerStyle? topEnd,
    CornerStyle? bottomStart,
    CornerStyle? bottomEnd,
  }) {
    return TokenCutCornerBorder(
      topStart: topStart ?? defaultBorderRadius,
      topEnd: topEnd ?? defaultBorderRadius,
      bottomStart: bottomStart ?? defaultBorderRadius,
      bottomEnd: bottomEnd ?? defaultBorderRadius,
    );
  }

  /// Creates a [TokenStadiumBorder].
  TokenStadiumBorder stadium() {
    return const TokenStadiumBorder();
  }
}
