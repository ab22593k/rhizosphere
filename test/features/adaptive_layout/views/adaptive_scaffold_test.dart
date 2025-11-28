import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/features/adaptive_layout/views/adaptive_scaffold.dart';

void main() {
  testWidgets('AdaptiveScaffold shows BottomNavigationBar on Compact', (
    tester,
  ) async {
    // Set screen size to Compact
    tester.binding.window.physicalSizeTestValue = const Size(400, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: AdaptiveScaffold())),
    );

    // Expect BottomNavigationBar
    // Note: NavigationBar is Material 3
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
    expect(find.byType(NavigationDrawer), findsNothing);
  });

  testWidgets('AdaptiveScaffold shows NavigationRail on Medium', (
    tester,
  ) async {
    // Set screen size to Medium
    tester.binding.window.physicalSizeTestValue = const Size(800, 600);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: AdaptiveScaffold())),
    );

    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('AdaptiveScaffold shows NavigationDrawer on Expanded', (
    tester,
  ) async {
    // Set screen size to Expanded
    tester.binding.window.physicalSizeTestValue = const Size(1200, 800);
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: AdaptiveScaffold())),
    );

    expect(find.byType(NavigationDrawer), findsOneWidget); // Permanent drawer
    expect(find.byType(NavigationRail), findsNothing);
  });
}
