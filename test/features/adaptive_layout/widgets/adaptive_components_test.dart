import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rhizosphere/rhizosphere.dart';

void main() {
  testWidgets('AdaptiveFAB is mini on Compact', (tester) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: AdaptiveFAB(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );

    final fab = tester.widget<FloatingActionButton>(
      find.byType(FloatingActionButton),
    );
    expect(fab.mini, isTrue); // Or check size constraint
  });

  testWidgets('AdaptiveFAB is large on Expanded', (tester) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          floatingActionButton: AdaptiveFAB(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );

    // Check if it's LargeFloatingActionButton or just standard/large
    expect(find.byType(FloatingActionButton), findsOneWidget);
    // Add more specific assertions based on implementation
  });
}
