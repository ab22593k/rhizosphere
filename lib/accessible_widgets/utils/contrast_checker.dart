import 'dart:ui';

class ContrastChecker {
  /// Calculates the luminance of a color.
  static double calculateLuminance(Color color) {
    return color.computeLuminance();
  }

  /// Calculates the contrast ratio between two colors.
  static double calculateContrastRatio(Color foreground, Color background) {
    final lum1 = calculateLuminance(foreground);
    final lum2 = calculateLuminance(background);
    final lighter = lum1 > lum2 ? lum1 : lum2;
    final darker = lum1 > lum2 ? lum2 : lum1;
    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Checks if the contrast ratio meets WCAG AA standards.
  /// Large text: >= 18pt or >= 14pt bold requires 3:1.
  /// Normal text: requires 4.5:1.
  static bool meetsWcagAA(
    double ratio, {
    required double fontSize,
    required bool isBold,
  }) {
    final isLargeText = fontSize >= 18 || (fontSize >= 14 && isBold);
    return ratio >= (isLargeText ? 3.0 : 4.5);
  }
}
