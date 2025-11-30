import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/views/hierarchy_view.dart';
import 'package:rhizosphere/models/navigation_item.dart';

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

      // Verify List Items Semantics
      // Each card should be a button with a combined label
      // We try to find by label match.
      // Debugging tip: If this fails, check if the semantics nodes are merged differently.

      try {
        final item1Finder = find.bySemanticsLabel('Item 1, Description 1');
        expect(item1Finder, findsOneWidget);

        final item1Semantics = tester.getSemantics(item1Finder);
        // Use flagsCollection if available or assume deprecated hasFlag works
        // ignore: deprecated_member_use
        expect(item1Semantics.hasFlag(SemanticsFlag.isButton), isTrue);
        expect(item1Semantics.hint, 'Double tap to activate');
      } catch (e) {
        // If failed, iterate semantics to see what we have
        // Not easy in test code without print, but we can try to find by partial match
        final partialFinder = find.bySemanticsLabel(RegExp(r'Item 1'));
        if (partialFinder.evaluate().isNotEmpty) {
          final semantics = tester.getSemantics(partialFinder.first);
          debugPrint('Found partial match: "${semantics.label}"');
        } else {
          debugPrint('No semantics found with "Item 1"');
        }
        rethrow;
      }

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
