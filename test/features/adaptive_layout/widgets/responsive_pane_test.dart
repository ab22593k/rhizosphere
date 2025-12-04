import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rhizosphere/rhizosphere.dart';

void main() {
  testWidgets('ThreePaneLayout shows all panes on Expanded', (tester) async {
    // Setup Expanded size
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: ThreePaneLayout(
          supportingPane: Text('Supporting'),
          primaryPane: Text('Primary'),
          detailPane: Text('Detail'),
        ),
      ),
    );

    expect(find.text('Supporting'), findsOneWidget);
    expect(find.text('Primary'), findsOneWidget);
    expect(find.text('Detail'), findsOneWidget);
  });

  testWidgets('ThreePaneLayout hides supporting/detail on Compact', (
    tester,
  ) async {
    // Setup Compact size
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: ThreePaneLayout(
          supportingPane: Text('Supporting'),
          primaryPane: Text('Primary'),
          detailPane: Text('Detail'),
        ),
      ),
    );

    expect(find.text('Primary'), findsOneWidget);
    expect(
      find.text('Supporting'),
      findsNothing,
    ); // Assuming hidden by default in stacked
    // Note: In stacked mode, navigation usually handles switching panes
  });
}
