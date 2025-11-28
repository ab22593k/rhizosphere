import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/accessible_widgets/utils/truncation_handler.dart';

void main() {
  testWidgets('TruncationHandler shows full text when space is sufficient', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 300,
              child: TruncationHandler(text: 'Short text', maxWidth: 300),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Short text'), findsOneWidget);
    expect(find.byType(Tooltip), findsNothing);
  });

  testWidgets('TruncationHandler uses Tooltip when text overflows', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 100,
              child: TruncationHandler(
                text: 'Very long text that definitely truncates',
                maxWidth: 100,
              ),
            ),
          ),
        ),
      ),
    );

    // Should find the text widget with overflow handling
    expect(
      find.text('Very long text that definitely truncates'),
      findsOneWidget,
    );

    // Should be wrapped in a tooltip
    expect(find.byType(Tooltip), findsOneWidget);
  });
}
