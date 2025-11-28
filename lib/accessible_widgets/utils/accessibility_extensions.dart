import 'package:flutter/material.dart';

extension TextStyleScaled on TextStyle {
  /// Returns a scaled version of this TextStyle based on the current text scale factor.
  /// Useful for forcing scaling on widgets that don't automatically scale,
  /// or for calculations.
  TextStyle scaled(BuildContext context) {
    final scaler = MediaQuery.textScalerOf(context);
    // Note: TextStyle doesn't strictly apply scaler logic internally on fontSize
    // in the same way Text widget does, but this is a helper for explicit scaling.
    // If fontSize is null, we default to 14.0 standard.
    final scaledSize = scaler.scale(fontSize ?? 14.0);
    return copyWith(fontSize: scaledSize);
  }
}
