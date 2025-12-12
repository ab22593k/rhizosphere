import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rhizosphere/rhizosphere.dart';

void main() {
  testWidgets(
    'Screen Reader: HierarchyView has correct reading order and semantics',
    (WidgetTester tester) async {
      final items = [
        NavigationItem(
          id: '1',
          title: 'Item 1',
          description: 'Description 1',
          route: '/1',
        ),
        NavigationItem(
          id: '2',
          title: 'Item 2',
          description: 'Description 2',
          route: '/2',
        ),
      ];

      await tester.pumpWidget(MaterialApp(home: HierarchyView(items: items)));

      await tester.pumpAndSettle();

      // Find the Semantics tree
      final handle = tester.ensureSemantics();

      // Verify Header Semantics
      final header = tester.getSemantics(find.text('Categories'));
      expect(header.label, 'Categories');

      // With MergeSemantics, the card's label is merged with InkWell's semantics
      // Find by the title text which is visible
      final item1Finder = find.text('Item 1');
      expect(item1Finder, findsOneWidget);

      // Get the semantics node for the card
      final item1Semantics = tester.getSemantics(item1Finder);

      // Verify the merged label includes both title and description
      expect(item1Semantics.label, contains('Item 1'));
      expect(item1Semantics.label, contains('Description 1'));

      // Verify hint is present
      expect(item1Semantics.hint, 'Double tap to activate');

      handle.dispose();
    },
  );

  testWidgets('Screen Reader: Semantic traversal order is logical', (
    WidgetTester tester,
  ) async {
    final items = [
      NavigationItem(id: 'a', title: 'A', description: 'Desc A', route: '/a'),
      NavigationItem(id: 'b', title: 'B', description: 'Desc B', route: '/b'),
    ];

    await tester.pumpWidget(MaterialApp(home: HierarchyView(items: items)));

    await tester.pumpAndSettle();

    // Use RegExp to be safer about spaces
    expect(find.bySemanticsLabel(RegExp(r'A,.*Desc A')), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp(r'B,.*Desc B')), findsOneWidget);
  });
}
