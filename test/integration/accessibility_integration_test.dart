import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/rhizosphere.dart';

void main() {
  group('Accessibility Integration Test', () {
    testWidgets('All accessible widgets work together', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  AccessibleImage(
                    image: AssetImage('test.png'),
                    altText: 'Test Image',
                    caption: 'A Caption',
                  ),
                  AccessibleText(text: 'Accessible Text', maxLines: 2),
                  ExpandableTruncatedText(text: 'Long text content...'),
                  DynamicTooltipLabel(text: 'Nav Label'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(AccessibleImage), findsOneWidget);
      expect(
        find.byType(AccessibleText),
        findsNWidgets(2),
      ); // One direct, one in Expandable
      expect(find.byType(ExpandableTruncatedText), findsOneWidget);
      expect(find.byType(DynamicTooltipLabel), findsOneWidget);

      // Verify semantics presence
      expect(find.bySemanticsLabel('Test Image'), findsOneWidget);
    });
  });
}
