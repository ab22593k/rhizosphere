/// Configuration model for application-wide accessibility settings.
///
/// This class holds state that affects the visual presentation and structure
/// of the app to accommodate different needs.
class AccessibilityConfig {
  /// The multiplier for text size (e.g., 1.5 for 150% scale).
  /// Used to support large text requirements (WCAG 1.4.4 Resize text).
  final double textScaleFactor;

  /// Whether to enable high contrast mode.
  /// If true, the app should use a high-contrast [ColorScheme] (WCAG 1.4.6 Contrast (Enhanced)).
  final bool highContrast;

  const AccessibilityConfig({
    this.textScaleFactor = 1.0,
    this.highContrast = false,
  });

  /// Creates a copy of this config with the given fields replaced with the new values.
  AccessibilityConfig copyWith({double? textScaleFactor, bool? highContrast}) {
    return AccessibilityConfig(
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      highContrast: highContrast ?? this.highContrast,
    );
  }
}
