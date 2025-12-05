import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/src/shapes/optical_roundness.dart';

void main() {
  group('OpticalRoundness', () {
    testWidgets('computeInnerRadius calculates correctly', (tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            expect(context.computeInnerRadius(20.0, 4.0), 16.0);
            expect(context.computeInnerRadius(10.0, 12.0), 0.0); // Clamps to 0
            return const SizedBox();
          },
        ),
      );
    });

    testWidgets('adjustForNesting calculates border radius', (tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            final outer = BorderRadius.circular(20.0);
            final inner = context.adjustForNesting(outer, 4.0);

            expect(inner.topLeft.x, 16.0);
            expect(inner.topRight.x, 16.0);
            expect(inner.bottomLeft.x, 16.0);
            expect(inner.bottomRight.x, 16.0);
            return const SizedBox();
          },
        ),
      );
    });
  });
}
