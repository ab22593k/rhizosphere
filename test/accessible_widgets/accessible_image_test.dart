import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/rhizosphere.dart';

void main() {
  testWidgets('AccessibleImage semantics check', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AccessibleImage(
          image: AssetImage('test.png'),
          altText: 'A test image',
        ),
      ),
    );

    // Wait for widget to settle and semantics to be updated
    await tester.pumpAndSettle();

    final semantics = tester.getSemantics(find.byType(Image));
    expect(semantics.label, 'A test image');
    expect(semantics.flagsCollection.isImage, true);
  });

  testWidgets('Decorative image excludes semantics', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AccessibleImage(
          image: AssetImage('decorative.png'),
          isDecorative: true,
        ),
      ),
    );

    // Find Semantics widget that wraps Image. Since Image might have multiple ancestors,
    // we need to be specific. The one we created is a direct parent (or close to it).
    // However, finding by type Semantics is tricky because many widgets use Semantics.
    // Let's look for the Semantics widget that has the specific properties we set.
    final semanticsFinder = find.descendant(
      of: find.byType(AccessibleImage),
      matching: find.byWidgetPredicate(
        (widget) => widget is Semantics && widget.excludeSemantics == true,
      ),
    );

    expect(semanticsFinder, findsOneWidget);
    final semanticsWidget = tester.widget<Semantics>(semanticsFinder);
    expect(semanticsWidget.excludeSemantics, true);
  });

  testWidgets('Caption is rendered', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AccessibleImage(
          image: AssetImage('test.png'),
          altText: 'Test',
          caption: 'Image Caption',
        ),
      ),
    );

    expect(find.text('Image Caption'), findsOneWidget);
  });
}
