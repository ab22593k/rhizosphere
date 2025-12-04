import 'package:flutter/physics.dart';

extension SpringDescriptionScaling on SpringDescription {
  /// Returns a new [SpringDescription] with the duration scaled by [factor].
  ///
  /// A factor > 1.0 slows down the animation (lower stiffness).
  /// A factor < 1.0 speeds up the animation (higher stiffness).
  /// Damping ratio is preserved.
  SpringDescription scaleDuration(double factor) {
    if (factor == 1.0) return this;
    // Stiffness k' = k / S^2
    final newStiffness = stiffness / (factor * factor);
    // Damping c' = c / S
    final newDamping = damping / factor;

    return SpringDescription(
      mass: mass,
      stiffness: newStiffness,
      damping: newDamping,
    );
  }
}
