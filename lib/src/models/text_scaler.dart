import 'package:flutter/material.dart';

/// Helper for dynamic text scaling logic.
class AppTextScaler {
  /// Creates a linear text scaler from a scale factor.
  static TextScaler fromScale(double scaleFactor) {
    return TextScaler.linear(scaleFactor);
  }

  /// Calculates a new scale factor clamped within a range.
  static double clampScale(
    double currentScale, {
    double min = 0.5,
    double max = 2.0,
  }) {
    return currentScale.clamp(min, max);
  }
}
