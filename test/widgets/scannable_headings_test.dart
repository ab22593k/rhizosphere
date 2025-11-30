import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/views/components/accessible_header.dart';

void main() {
  testWidgets('ScannableHeading accepts short text (<= 4 words)', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AccessibleHeader(text: 'Short Header Text', level: 1),
      ),
    );

    expect(find.text('Short Header Text'), findsOneWidget);
  });

  testWidgets('ScannableHeading throws/warns on long text (> 4 words)', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AccessibleHeader(
          text: 'This is a very long header text that should fail',
          level: 1,
        ),
      ),
    );

    expect(tester.takeException(), isA<AssertionError>());
  });

  testWidgets('ScannableHeading is bold', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: AccessibleHeader(text: 'Bold Header', level: 1)),
    );

    final textWidget = tester.widget<Text>(find.text('Bold Header'));
    expect(textWidget.style?.fontWeight, FontWeight.bold);
  });
}
