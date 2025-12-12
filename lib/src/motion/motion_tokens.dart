import 'package:flutter/physics.dart';
import 'motion_scheme.dart';

class MotionTokens {
  const MotionTokens._();

  // Expressive Scheme
  static const SpringDescription expressiveFastSpatial = SpringDescription(
    mass: 1.0,
    stiffness: 1400.0,
    damping: 67.35, // ratio 0.9
  );
  static const SpringDescription expressiveDefaultSpatial = SpringDescription(
    mass: 1.0,
    stiffness: 700.0,
    damping: 47.62, // ratio 0.9
  );
  static const SpringDescription expressiveSlowSpatial = SpringDescription(
    mass: 1.0,
    stiffness: 300.0,
    damping: 31.17, // ratio 0.9
  );

  static const SpringDescription expressiveFastEffects = SpringDescription(
    mass: 1.0,
    stiffness: 3800.0,
    damping: 123.29, // ratio 1.0
  );
  static const SpringDescription expressiveDefaultEffects = SpringDescription(
    mass: 1.0,
    stiffness: 1600.0,
    damping: 80.0, // ratio 1.0
  );
  static const SpringDescription expressiveSlowEffects = SpringDescription(
    mass: 1.0,
    stiffness: 800.0,
    damping: 56.57, // ratio 1.0
  );

  // Standard Scheme
  static const SpringDescription standardFastSpatial = SpringDescription(
    mass: 1.0,
    stiffness: 1400.0,
    damping: 74.83, // ratio 1.0
  );
  static const SpringDescription standardDefaultSpatial = SpringDescription(
    mass: 1.0,
    stiffness: 700.0,
    damping: 52.91, // ratio 1.0
  );
  static const SpringDescription standardSlowSpatial = SpringDescription(
    mass: 1.0,
    stiffness: 300.0,
    damping: 34.64, // ratio 1.0
  );

  // Effects in standard scheme are also critically damped (ratio 1.0)
  // so they match the expressive effects tokens.
  static const SpringDescription standardFastEffects = expressiveFastEffects;
  static const SpringDescription standardDefaultEffects =
      expressiveDefaultEffects;
  static const SpringDescription standardSlowEffects = expressiveSlowEffects;

  // Reduced Motion Scheme
  // Very high stiffness + critical damping = near-instant animations
  // Respects platform "Reduce Motion" accessibility setting
  static const SpringDescription reducedMotion = SpringDescription(
    mass: 1.0,
    stiffness: 10000.0, // Very stiff for near-instant motion
    damping: 200.0, // Critically damped (no oscillation)
  );
}

extension MotionSchemeResolver on MotionScheme {
  /// Resolves to the appropriate spring based on scheme, speed, and type.
  ///
  /// When [MotionScheme.reduced] is used, returns a near-instant spring
  /// regardless of speed and type, respecting accessibility settings.
  SpringDescription resolve(MotionSpeed speed, MotionType type) {
    switch (this) {
      case MotionScheme.reduced:
        // For reduced motion, always return near-instant spring
        return MotionTokens.reducedMotion;

      case MotionScheme.expressive:
        switch (type) {
          case MotionType.spatial:
            switch (speed) {
              case MotionSpeed.fast:
                return MotionTokens.expressiveFastSpatial;
              case MotionSpeed.defaultSpeed:
                return MotionTokens.expressiveDefaultSpatial;
              case MotionSpeed.slow:
                return MotionTokens.expressiveSlowSpatial;
            }
          case MotionType.effects:
            switch (speed) {
              case MotionSpeed.fast:
                return MotionTokens.expressiveFastEffects;
              case MotionSpeed.defaultSpeed:
                return MotionTokens.expressiveDefaultEffects;
              case MotionSpeed.slow:
                return MotionTokens.expressiveSlowEffects;
            }
        }
      case MotionScheme.standard:
        switch (type) {
          case MotionType.spatial:
            switch (speed) {
              case MotionSpeed.fast:
                return MotionTokens.standardFastSpatial;
              case MotionSpeed.defaultSpeed:
                return MotionTokens.standardDefaultSpatial;
              case MotionSpeed.slow:
                return MotionTokens.standardSlowSpatial;
            }
          case MotionType.effects:
            switch (speed) {
              case MotionSpeed.fast:
                return MotionTokens.standardFastEffects;
              case MotionSpeed.defaultSpeed:
                return MotionTokens.standardDefaultEffects;
              case MotionSpeed.slow:
                return MotionTokens.standardSlowEffects;
            }
        }
    }
  }
}
