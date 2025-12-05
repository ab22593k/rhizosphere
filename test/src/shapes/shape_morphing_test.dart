import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/src/shapes/shape_morphing.dart';

void main() {
  testWidgets('ShapeMorphTransition animates shape', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ShapeMorphTransition(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: const SizedBox(width: 100, height: 100),
        ),
      ),
    );

    expect(find.byType(ShapeMorphTransition), findsOneWidget);

    // Trigger update
    await tester.pumpWidget(
      MaterialApp(
        home: ShapeMorphTransition(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: const SizedBox(width: 100, height: 100),
        ),
      ),
    );

    // Check initial state
    await tester.pump();

    // Advance animation
    await tester.pump(const Duration(milliseconds: 150));

    // Complete animation
    await tester.pump(const Duration(milliseconds: 150));
  });
}
