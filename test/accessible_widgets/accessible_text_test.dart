// ignore: library_annotations
@Tags(['accessibility'])
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/rhizosphere.dart';

void main() {
  testWidgets('AccessibleText respects textScaler', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(2.0)),
          child: child!,
        ),
        home: const AccessibleText(text: 'Scaled Text'),
      ),
    );

    final textWidget = tester.widget<Text>(find.byType(Text));
    expect(textWidget.textScaler, const TextScaler.linear(2.0));
  });

  testWidgets('AccessibleText handles contrast (debug mode check)', (
    WidgetTester tester,
  ) async {
    // This test verifies the widget builds without error even with poor contrast
    // In a real scenario, we might want to intercept the debugPrint,
    // but for now we ensure it renders.
    await tester.pumpWidget(
      MaterialApp(
        home: const AccessibleText(
          text: 'Low Contrast',
          style: TextStyle(color: Colors.white),
          backgroundColor: Colors.white, // Invisible!
        ),
      ),
    );

    expect(find.text('Low Contrast'), findsOneWidget);
  });

  testWidgets('AccessibleText at 1.0x textScaler', (WidgetTester tester) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(1.0)),
        child: MaterialApp(home: const AccessibleText(text: 'Test text')),
      ),
    );

    final textWidget = tester.widget<Text>(find.byType(Text));
    expect(textWidget.textScaler, const TextScaler.linear(1.0));
  });

  testWidgets('AccessibleText at 2.0x textScaler', (WidgetTester tester) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(2.0)),
        child: MaterialApp(home: const AccessibleText(text: 'Test text')),
      ),
    );

    final textWidget = tester.widget<Text>(find.byType(Text));
    expect(textWidget.textScaler, const TextScaler.linear(2.0));
  });

  testWidgets('AccessibleText contrast enforcement warning', (
    WidgetTester tester,
  ) async {
    // Capture debug prints
    final log = <String>[];
    final originalDebugPrint = debugPrint;
    debugPrint = (message, {wrapWidth}) => log.add(message ?? '');

    await tester.pumpWidget(
      MaterialApp(
        home: const AccessibleText(
          text: 'Low contrast text',
          style: TextStyle(color: Colors.grey),
          backgroundColor: Colors.white,
        ),
      ),
    );

    debugPrint = originalDebugPrint;

    // Check that a contrast warning was logged
    expect(log, contains(contains('contrast ratio')));
  });
}
