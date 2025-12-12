import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/src/accessibility/components/accessible_text_field.dart';

void main() {
  testWidgets('AccessibleTextField has semantic label and hint', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AccessibleTextField(
            label: 'Username',
            hint: 'Enter your username',
          ),
        ),
      ),
    );

    final textField = find.byType(AccessibleTextField);
    expect(textField, findsOneWidget);

    // Verify semantics
    // We search for EditableText which handles the text input semantics
    expect(
      tester.getSemantics(find.byType(EditableText)),
      matchesSemantics(
        label: 'Username',
        isTextField: true,
        isFocused: false,
        isHeader: false,
        hasEnabledState: true,
        isEnabled: true,
        isFocusable: true,
        hasTapAction: true,
        hasFocusAction: true,
      ),
    );
  });
}
