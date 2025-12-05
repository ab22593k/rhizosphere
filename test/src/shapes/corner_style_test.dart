import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/src/shapes/corner_style.dart';

void main() {
  group('CornerStyle', () {
    test('values are correct', () {
      expect(CornerStyle.none.value, 0.0);
      expect(CornerStyle.xs.value, 4.0);
      expect(CornerStyle.s.value, 8.0);
      expect(CornerStyle.m.value, 12.0);
      expect(CornerStyle.l.value, 16.0);
      expect(CornerStyle.l_increased.value, 20.0);
      expect(CornerStyle.xl.value, 24.0);
      expect(CornerStyle.xl_increased.value, 32.0);
      expect(CornerStyle.xxl.value, 40.0);
      expect(CornerStyle.full.value, -1.0);
    });

    test('isFull getter works correctly', () {
      expect(CornerStyle.full.isFull, isTrue);
      expect(CornerStyle.m.isFull, isFalse);
    });
  });
}
