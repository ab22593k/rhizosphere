import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/src/accessibility/components/accessible_button.dart';

void main() {
  testWidgets('Button labels performance (length check)', (
    WidgetTester tester,
  ) async {
    // Task T025: Performance test for 3-4 word button labels.

    // Valid short label
    await tester.pumpWidget(
      MaterialApp(
        home: AccessibleButton(
          onPressed: () {},
          label: 'Click Me',
          semanticLabel: 'Click Me',
        ),
      ),
    );
    expect(find.text('Click Me'), findsOneWidget);

    // Long label should fail assertion (to be implemented)
    await tester.pumpWidget(
      MaterialApp(
        home: AccessibleButton(
          onPressed: () {},
          label: 'This button label is way too long for scanning',
          semanticLabel: 'Long Label',
        ),
      ),
    );
    expect(tester.takeException(), isA<AssertionError>());
  });
}
