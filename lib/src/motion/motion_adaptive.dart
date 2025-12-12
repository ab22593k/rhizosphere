import 'package:flutter/widgets.dart';
import 'motion_scheme.dart';

/// Helper class for device-adaptive motion and accessibility integration.
///
/// This class provides utilities to:
/// - Scale motion duration based on device type
/// - Respect platform "Reduce Motion" accessibility settings
/// - Choose appropriate motion schemes based on context
class MotionAdaptive {
  /// Returns true if the platform requests reduced motion.
  ///
  /// Checks [MediaQueryData.disableAnimations] which is set by:
  /// - iOS "Reduce Motion" setting
  /// - Android "Remove animations" or low animator duration scale
  /// - Accessibility services that request reduced motion
  static bool shouldReduceMotion(BuildContext context) {
    return MediaQuery.of(context).disableAnimations;
  }

  /// Returns the effective motion scheme based on platform settings.
  ///
  /// If the platform requests reduced motion, returns [MotionScheme.reduced].
  /// Otherwise, returns the provided [preferredScheme].
  ///
  /// Usage:
  /// ```dart
  /// final scheme = MotionAdaptive.getEffectiveScheme(
  ///   context,
  ///   MotionScheme.expressive,
  /// );
  /// final spring = scheme.resolve(MotionSpeed.defaultSpeed, MotionType.spatial);
  /// ```
  static MotionScheme getEffectiveScheme(
    BuildContext context,
    MotionScheme preferredScheme,
  ) {
    if (shouldReduceMotion(context)) {
      return MotionScheme.reduced;
    }
    return preferredScheme;
  }

  /// Returns a duration scaling factor based on the device type and accessibility.
  ///
  /// - If reduce motion is enabled: returns near-zero (0.01) for minimal animation
  /// - Wearable (width < 300): 0.8x (faster)
  /// - Tablet (width > 600): 1.2x (slower)
  /// - Phone (default): 1.0x
  static double getDurationScale(BuildContext context) {
    // Respect platform reduce motion setting
    if (shouldReduceMotion(context)) {
      return 0.01; // Near-instant animations
    }

    final width = MediaQuery.of(context).size.width;
    if (width < 300) {
      return 0.8;
    } else if (width > 600) {
      return 1.2;
    }
    return 1.0;
  }

  /// Returns a duration adjusted for accessibility and device type.
  ///
  /// If reduce motion is enabled, returns [Duration.zero] or a minimal duration.
  /// Otherwise, scales the duration based on device type.
  static Duration getAccessibleDuration(
    BuildContext context,
    Duration baseDuration,
  ) {
    if (shouldReduceMotion(context)) {
      return Duration.zero;
    }
    final scale = getDurationScale(context);
    return baseDuration * scale;
  }
}
