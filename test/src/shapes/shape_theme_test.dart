import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/src/shapes/shape_theme.dart';
import 'package:rhizosphere/src/shapes/corner_style.dart';
import 'package:rhizosphere/src/shapes/corner_radius.dart';

void main() {
  group('ShapeTheme', () {
    test('defaults has correct values', () {
      final theme = ShapeTheme.defaults;
      expect(theme.cornerStyles, CornerRadius.values);
      expect(theme.defaultBorderRadius, CornerStyle.m);
    });

    test('borderRadius returns correct radius', () {
      final theme = ShapeTheme.defaults;
      expect(theme.borderRadius(CornerStyle.s), BorderRadius.circular(8.0));
      expect(
        theme.borderRadius(CornerStyle.full),
        BorderRadius.circular(double.infinity),
      );
    });

    test('copyWith updates values', () {
      final theme =
          ShapeTheme.defaults.copyWith(defaultBorderRadius: CornerStyle.l)
              as ShapeTheme;
      expect(theme.defaultBorderRadius, CornerStyle.l);
    });

    test('lerp interpolates values', () {
      final a =
          ShapeTheme.defaults.copyWith(defaultBorderRadius: CornerStyle.s)
              as ShapeTheme;
      final b =
          ShapeTheme.defaults.copyWith(defaultBorderRadius: CornerStyle.l)
              as ShapeTheme;

      expect((a.lerp(b, 0.0) as ShapeTheme).defaultBorderRadius, CornerStyle.s);
      expect((a.lerp(b, 1.0) as ShapeTheme).defaultBorderRadius, CornerStyle.l);
    });

    test('lerp interpolates values', () {
      final a = ShapeTheme.defaults.copyWith(
        defaultBorderRadius: CornerStyle.s,
      );
      final b = ShapeTheme.defaults.copyWith(
        defaultBorderRadius: CornerStyle.l,
      );

      final lerp0 = a.lerp(b, 0.0) as ShapeTheme;
      final lerp1 = a.lerp(b, 1.0) as ShapeTheme;

      expect(lerp0.defaultBorderRadius, CornerStyle.s);
      expect(lerp1.defaultBorderRadius, CornerStyle.l);
    });
  });
}
