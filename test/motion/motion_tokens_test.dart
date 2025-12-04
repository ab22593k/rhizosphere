import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/src/motion/motion_tokens.dart';

void main() {
  group('MotionTokens Exact Specs', () {
    test('Expressive Fast Spatial values', () {
      const token = MotionTokens.expressiveFastSpatial;
      expect(token.mass, 1.0);
      expect(token.stiffness, 1400.0);
      expect(token.damping, closeTo(67.35, 0.02));
    });

    test('Expressive Default Spatial values', () {
      const token = MotionTokens.expressiveDefaultSpatial;
      expect(token.mass, 1.0);
      expect(token.stiffness, 700.0);
      expect(token.damping, closeTo(47.62, 0.02));
    });

    test('Expressive Slow Spatial values', () {
      const token = MotionTokens.expressiveSlowSpatial;
      expect(token.mass, 1.0);
      expect(token.stiffness, 300.0);
      expect(token.damping, closeTo(31.17, 0.02));
    });

    test('Expressive Fast Effects values', () {
      const token = MotionTokens.expressiveFastEffects;
      expect(token.mass, 1.0);
      expect(token.stiffness, 3800.0);
      expect(token.damping, closeTo(123.29, 0.02));
    });

    test('Expressive Default Effects values', () {
      const token = MotionTokens.expressiveDefaultEffects;
      expect(token.mass, 1.0);
      expect(token.stiffness, 1600.0);
      expect(token.damping, closeTo(80.0, 0.02));
    });

    test('Expressive Slow Effects values', () {
      const token = MotionTokens.expressiveSlowEffects;
      expect(token.mass, 1.0);
      expect(token.stiffness, 800.0);
      expect(token.damping, closeTo(56.57, 0.02));
    });

    test('Standard Fast Spatial values', () {
      const token = MotionTokens.standardFastSpatial;
      expect(token.mass, 1.0);
      expect(token.stiffness, 1400.0);
      expect(token.damping, closeTo(74.83, 0.02));
    });

    test('Standard Default Spatial values', () {
      const token = MotionTokens.standardDefaultSpatial;
      expect(token.mass, 1.0);
      expect(token.stiffness, 700.0);
      expect(token.damping, closeTo(52.91, 0.02));
    });

    test('Standard Slow Spatial values', () {
      const token = MotionTokens.standardSlowSpatial;
      expect(token.mass, 1.0);
      expect(token.stiffness, 300.0);
      expect(token.damping, closeTo(34.64, 0.02));
    });
  });
}
