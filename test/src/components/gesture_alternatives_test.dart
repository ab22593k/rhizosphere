import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/src/accessibility/components/gesture_handler.dart';

void main() {
  testWidgets('GestureHandler accepts tap and long press alternatives', (
    tester,
  ) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GestureHandler(
            onTap: () => tapped = true,
            child: const Text('Interact'),
          ),
        ),
      ),
    );

    // Test standard tap
    await tester.tap(find.text('Interact'));
    expect(tapped, isTrue);

    tapped = false; // Reset

    // Test long press as alternative to tap (common accessibility pattern for motor impairments)
    // Or maybe swipe? The requirements said "swipe/hold".
    // Let's assume hold (LongPress) triggers the primary action or a special alternative action.
    // T024 says "Add swipe/hold GestureDetector alternatives".
    // Let's verify LongPress triggers the action if configured, or a specific alternative.

    await tester.longPress(find.text('Interact'));
    expect(
      tapped,
      isTrue,
    ); // Assuming hold triggers the same action for accessibility here
  });
}
