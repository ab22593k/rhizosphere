import 'package:flutter/material.dart';

import '../shapes/shape_theme.dart';
import '../shapes/corner_style.dart';

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

  static final _shapeTheme = ShapeTheme.defaults;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      // Target sizes: 48x48dp touch target size enforcement
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
      extensions: [_shapeTheme],
      appBarTheme: AppBarTheme(
        backgroundColor: lightColorScheme.primary,
        foregroundColor: lightColorScheme.onPrimary,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        shape: _shapeTheme.roundedRectangle(
          topStart: CornerStyle.m,
          topEnd: CornerStyle.m,
          bottomStart: CornerStyle.m,
          bottomEnd: CornerStyle.m,
        ),
      ),
      chipTheme: ChipThemeData(shape: _shapeTheme.stadium()),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(shape: _shapeTheme.stadium()),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(shape: _shapeTheme.stadium()),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(shape: _shapeTheme.stadium()),
      ),
      dialogTheme: DialogThemeData(
        shape: _shapeTheme.roundedRectangle(
          topStart: CornerStyle.xl,
          topEnd: CornerStyle.xl,
          bottomStart: CornerStyle.xl,
          bottomEnd: CornerStyle.xl,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
      extensions: [_shapeTheme],
      cardTheme: CardThemeData(
        shape: _shapeTheme.roundedRectangle(
          topStart: CornerStyle.m,
          topEnd: CornerStyle.m,
          bottomStart: CornerStyle.m,
          bottomEnd: CornerStyle.m,
        ),
      ),
      chipTheme: ChipThemeData(shape: _shapeTheme.stadium()),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(shape: _shapeTheme.stadium()),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(shape: _shapeTheme.stadium()),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(shape: _shapeTheme.stadium()),
      ),
      dialogTheme: DialogThemeData(
        shape: _shapeTheme.roundedRectangle(
          topStart: CornerStyle.xl,
          topEnd: CornerStyle.xl,
          bottomStart: CornerStyle.xl,
          bottomEnd: CornerStyle.xl,
        ),
      ),
    );
  }
}
