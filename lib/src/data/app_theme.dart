import 'package:flutter/material.dart';

class AppTheme {
  static final ColorScheme lightColorScheme =
      ColorScheme.fromSeed(
        seedColor: const Color(0xFF1A237E), // Deep Blue (High Contrast)
        brightness: Brightness.light,
      ).copyWith(
        // Ensure high contrast for surface/background pairs
        surface: Colors.white,
        onSurface: Colors.black, // 21:1 contrast
        primary: const Color(0xFF1A237E),
        onPrimary: Colors.white, // 14:1 contrast
      );

  static final ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF8C9EFF), // Lighter Blue for Dark Mode
    brightness: Brightness.dark,
  ).copyWith(surface: const Color(0xFF121212), onSurface: Colors.white);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      // Target sizes: 48x48dp touch target size enforcement
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
      appBarTheme: AppBarTheme(
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
        centerTitle: true,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
    );
  }
}
