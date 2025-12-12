import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/src/accessibility/components/accessible_button.dart';

void main() {
  testWidgets('Button labels performance (length check)', (
    WidgetTester tester,
  ) async {
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
  });
}
