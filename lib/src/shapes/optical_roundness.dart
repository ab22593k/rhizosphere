import 'package:flutter/material.dart';

/// Extension on [BuildContext] to calculate optical roundness.
extension OpticalRoundness on BuildContext {
  /// Calculates the inner radius based on the outer radius and padding.
  ///
  /// This ensures that nested shapes maintain concentricity, which is visually
  /// pleasing and mathematically correct.
  ///
  /// Formula: innerRadius = outerRadius - padding
  ///
  /// Returns 0 if the result is negative.
  double computeInnerRadius(double outerRadius, double padding) {
    return (outerRadius - padding).clamp(0.0, double.infinity);
  }

  /// Adjusts a [BorderRadius] for nesting inside a container with [padding].
  ///
  /// This applies [computeInnerRadius] to each corner of the [BorderRadius].
  BorderRadius adjustForNesting(BorderRadius outer, double padding) {
    return BorderRadius.only(
      topLeft: Radius.circular(computeInnerRadius(outer.topLeft.x, padding)),
      topRight: Radius.circular(computeInnerRadius(outer.topRight.x, padding)),
      bottomLeft: Radius.circular(
        computeInnerRadius(outer.bottomLeft.x, padding),
      ),
      bottomRight: Radius.circular(
        computeInnerRadius(outer.bottomRight.x, padding),
      ),
    );
  }
}
