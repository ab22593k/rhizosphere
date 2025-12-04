import 'package:flutter/widgets.dart';

/// Helper class for device-adaptive motion scaling.
class MotionAdaptive {
  /// Returns a duration scaling factor based on the device type (inferred from width).
  ///
  /// - Wearable (width < 300): 0.8x (faster)
  /// - Tablet (width > 600): 1.2x (slower)
  /// - Phone (default): 1.0x
  static double getDurationScale(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 300) {
      return 0.8;
    } else if (width > 600) {
      return 1.2;
    }
    return 1.0;
  }
}
