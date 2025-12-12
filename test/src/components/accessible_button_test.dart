import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/src/accessibility/components/accessible_button.dart';

void main() {
  testWidgets('AccessibleButton has semantics', (tester) async {
    bool pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AccessibleButton(
            label: 'Click Me',
            semanticLabel: 'Submit Form',
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    final button = find.byType(AccessibleButton);
    expect(button, findsOneWidget);

    // With MergeSemantics, the semantics are merged with ElevatedButton's native semantics
    // Find by text since that's what's visible
    final buttonFinder = find.text('Click Me');
    expect(buttonFinder, findsOneWidget);

    // Verify the merged semantics include our label
    final semantics = tester.getSemantics(buttonFinder);
    expect(semantics.label, contains('Submit Form'));

    // Verify the button is tappable and works
    await tester.tap(button);
    expect(pressed, isTrue);
  });
}
