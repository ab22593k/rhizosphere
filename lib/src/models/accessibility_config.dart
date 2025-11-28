class AccessibilityConfig {
  final double textScaleFactor;
  final bool highContrast;

  const AccessibilityConfig({
    this.textScaleFactor = 1.0,
    this.highContrast = false,
  });

  AccessibilityConfig copyWith({double? textScaleFactor, bool? highContrast}) {
    return AccessibilityConfig(
      textScaleFactor: textScaleFactor ?? this.textScaleFactor,
      highContrast: highContrast ?? this.highContrast,
    );
  }
}
