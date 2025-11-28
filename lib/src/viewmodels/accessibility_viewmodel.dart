import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/accessibility_config.dart';

class AccessibilityNotifier extends Notifier<AccessibilityConfig> {
  @override
  AccessibilityConfig build() {
    return const AccessibilityConfig();
  }

  void setTextScale(double scale) {
    state = state.copyWith(textScaleFactor: scale);
  }

  void toggleHighContrast() {
    state = state.copyWith(highContrast: !state.highContrast);
  }

  void setHighContrast(bool value) {
    state = state.copyWith(highContrast: value);
  }
}

final accessibilityProvider =
    NotifierProvider<AccessibilityNotifier, AccessibilityConfig>(() {
      return AccessibilityNotifier();
    });
