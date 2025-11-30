import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/src/components/accessible_button.dart';
import 'package:rhizosphere/views/components/accessible_header.dart';

void main() {
  testWidgets('Widgets handle text expansion without overflow', (
    WidgetTester tester,
  ) async {
    // Test AccessibleButton with a very long single word to test character expansion
    // (avoiding word count validation which limits to 4 words)
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            // Using a constrained width to force wrapping
            child: SizedBox(
              width: 200,
              child: AccessibleButton(
                onPressed: () {},
                label: 'Donaudampfschiffahrtsgesellschaftskapitän',
                semanticLabel: 'Long Word',
              ),
            ),
          ),
        ),
      ),
    );

    // Expect no overflow exception
    expect(tester.takeException(), isNull);

    // Test AccessibleHeader wrapping
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 200,
            child: AccessibleHeader(
              text: 'LongWordOne LongWordTwo LongWordThree LongWordFour',
              level: 1,
            ),
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
  });
}
