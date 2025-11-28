// ignore: library_annotations
@Tags(['accessibility'])
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/rhizosphere.dart';

void main() {
  testWidgets('DynamicTooltipLabel shows tooltip on long press when truncated', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 100,
              child: DynamicTooltipLabel(
                text: 'Very long text that definitely truncates',
              ),
            ),
          ),
        ),
      ),
    );

    // Verify ellipsis is shown
    expect(find.byType(DynamicTooltipLabel), findsOneWidget);

    // Long press to trigger tooltip
    await tester.longPress(find.byType(DynamicTooltipLabel));
    await tester.pumpAndSettle();

    // Verify tooltip content.
    // The Tooltip widget in Flutter creates an Overlay.
    // When testing tooltips, finding the text in the overlay can be tricky if we don't wait enough or if the tree structure is complex.
    // However, `find.text` searches the entire tree including overlays.
    // We expect 2 widgets: one is the label itself (ellipsis), one is the tooltip text.
    // But wait! The label itself has overflow: ellipsis. Does it still render the full text?
    // Yes, Text widget renders the full text but paints it clipped/ellipsized.
    // So finding by text should find the label.
    // Then the tooltip appears, so we should find a second one.
    expect(
      find.text('Very long text that definitely truncates'),
      findsNWidgets(2),
    );
  });

  testWidgets('DynamicTooltipLabel does not show tooltip when not truncated', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 300, // Sufficient width
              child: DynamicTooltipLabel(text: 'Short'),
            ),
          ),
        ),
      ),
    );

    await tester.longPress(find.byType(DynamicTooltipLabel));
    await tester.pumpAndSettle();

    expect(find.byType(Tooltip), findsNothing);
  });

  testWidgets('DynamicTooltipLabel scaled tooltip at 1.0x textScaler', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(1.0)),
        child: MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 100,
                child: DynamicTooltipLabel(
                  text: 'Very long text that definitely truncates',
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.longPress(find.byType(DynamicTooltipLabel));
    await tester.pumpAndSettle();

    expect(find.byType(Tooltip), findsOneWidget);
  });

  testWidgets('DynamicTooltipLabel scaled tooltip at 2.0x textScaler', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(2.0)),
        child: MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 100,
                child: DynamicTooltipLabel(
                  text: 'Very long text that definitely truncates',
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.longPress(find.byType(DynamicTooltipLabel));
    await tester.pumpAndSettle();

    expect(find.byType(Tooltip), findsOneWidget);
  });
}
