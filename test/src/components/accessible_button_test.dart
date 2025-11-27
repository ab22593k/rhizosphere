import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/src/components/accessible_button.dart';

void main() {
  testWidgets('AccessibleButton has semantics', (tester) async {
    bool pressed = false;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AccessibleButton(
          label: 'Click Me',
          semanticLabel: 'Submit Form',
          onPressed: () => pressed = true,
        ),
      ),
    ));

    final button = find.byType(AccessibleButton);
    expect(button, findsOneWidget);

    // Verify semantics
    // Note: We look for the semantics of the interactive element inside
    expect(tester.getSemantics(find.byType(ElevatedButton)), matchesSemantics(
      label: 'Submit Form',
      isButton: true,
      isEnabled: true,
      hasEnabledState: true,
      hasTapAction: true,
      isFocusable: true,
      hasFocusAction: true,
    ));

    await tester.tap(button);
    expect(pressed, isTrue);
  });
}
