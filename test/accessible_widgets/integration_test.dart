// ignore: library_annotations
@Tags(['accessibility'])
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/rhizosphere.dart';

void main() {
  group('Integration Tests at 1.0x textScaler', () {
    testWidgets('All widgets work together at 1.0x scale', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(1.0)),
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                title: DynamicTooltipLabel(
                  text: 'Long app bar title that might truncate',
                ),
              ),
              body: Column(
                children: [
                  AccessibleImage(
                    image: AssetImage('test.png'),
                    semanticsLabel: 'Test image',
                    caption: 'Image caption',
                  ),
                  AccessibleText(text: 'Accessible text content', maxLines: 2),
                  TruncationHandler(
                    text: 'Long text that will be truncated',
                    maxWidth: 200,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify all widgets render
      expect(find.byType(AccessibleImage), findsOneWidget);
      expect(find.byType(AccessibleText), findsOneWidget);
      expect(find.byType(TruncationHandler), findsAtLeast(1));
      expect(find.byType(DynamicTooltipLabel), findsOneWidget);

      // Verify text content
      expect(find.text('Image caption'), findsOneWidget);
      expect(find.text('Accessible text content'), findsOneWidget);
    });
  });

  group('Integration Tests at 2.0x textScaler', () {
    testWidgets('All widgets work together at 2.0x scale', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2.0)),
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                title: DynamicTooltipLabel(
                  text: 'Long app bar title that might truncate',
                ),
              ),
              body: Column(
                children: [
                  AccessibleImage(
                    image: AssetImage('test.png'),
                    semanticsLabel: 'Test image',
                    caption: 'Image caption',
                  ),
                  AccessibleText(text: 'Accessible text content', maxLines: 2),
                  TruncationHandler(
                    text: 'Long text that will be truncated',
                    maxWidth: 200,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify all widgets render at 2x scale
      expect(find.byType(AccessibleImage), findsOneWidget);
      expect(find.byType(AccessibleText), findsOneWidget);
      expect(find.byType(TruncationHandler), findsAtLeast(1));
      expect(find.byType(DynamicTooltipLabel), findsOneWidget);

      // Verify text content still present
      expect(find.text('Image caption'), findsOneWidget);
      expect(find.text('Accessible text content'), findsOneWidget);
    });
  });
}
