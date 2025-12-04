import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rhizosphere/rhizosphere.dart';

void main() {
  testWidgets('HierarchyView has semantic header and accessible cards', (
    WidgetTester tester,
  ) async {
    final items = [
      const NavigationItem(
        id: '1',
        title: 'Item 1',
        description: 'Desc 1',
        route: '/1',
      ),
      const NavigationItem(
        id: '2',
        title: 'Item 2',
        description: 'Desc 2',
        route: '/2',
      ),
    ];

    await tester.pumpWidget(MaterialApp(home: HierarchyView(items: items)));

    // Check for semantic header
    expect(find.bySemanticsLabel('Categories'), findsOneWidget);
    // Use tester.getSemantics to verify header property if needed,
    // but finding by label is a good start.

    // Check for cards
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Desc 1'), findsOneWidget);

    // Verify semantic button exists
    expect(find.bySemanticsLabel(RegExp('Item 1, Desc 1')), findsOneWidget);
  });
}
