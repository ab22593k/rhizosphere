import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/src/shapes/shape_borders.dart';
import 'package:rhizosphere/src/shapes/corner_style.dart';

void main() {
  group('TokenRoundedRectangleBorder', () {
    test('defaults to none', () {
      const border = TokenRoundedRectangleBorder();
      expect(border.topStart, CornerStyle.none);
      expect(border.topEnd, CornerStyle.none);
      expect(border.bottomStart, CornerStyle.none);
      expect(border.bottomEnd, CornerStyle.none);
    });

    test('supports asymmetry', () {
      const border = TokenRoundedRectangleBorder(
        topStart: CornerStyle.s,
        bottomEnd: CornerStyle.l,
      );
      expect(border.topStart, CornerStyle.s);
      expect(border.topEnd, CornerStyle.none);
      expect(border.bottomStart, CornerStyle.none);
      expect(border.bottomEnd, CornerStyle.l);
    });

    test('copyWith works correctly', () {
      const border = TokenRoundedRectangleBorder(topStart: CornerStyle.s);
      final newBorder = border.copyWith(topEnd: CornerStyle.m);

      expect(newBorder.topStart, CornerStyle.s);
      expect(newBorder.topEnd, CornerStyle.m);
    });

    test('scale scales the side', () {
      const border = TokenRoundedRectangleBorder(side: BorderSide(width: 2.0));
      final scaled = border.scale(2.0) as TokenRoundedRectangleBorder;
      expect(scaled.side.width, 4.0);
    });
  });

  group('TokenCutCornerBorder', () {
    test('defaults to none', () {
      const border = TokenCutCornerBorder();
      expect(border.topStart, CornerStyle.none);
    });

    test('supports asymmetry', () {
      const border = TokenCutCornerBorder(
        topStart: CornerStyle.s,
        bottomEnd: CornerStyle.l,
      );
      expect(border.topStart, CornerStyle.s);
      expect(border.bottomEnd, CornerStyle.l);
    });

    test('copyWith works correctly', () {
      const border = TokenCutCornerBorder(topStart: CornerStyle.s);
      final newBorder = border.copyWith(topEnd: CornerStyle.m);
      expect(newBorder.topEnd, CornerStyle.m);
    });
  });
}
