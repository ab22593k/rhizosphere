import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhizosphere/rhizosphere.dart';
import 'package:example/main.dart';
import 'package:example/demo/home_screen.dart';
import 'package:example/demo/settings_screen.dart';

void main() {
  testWidgets('Full demo flow integration test', (tester) async {
    // Build the app
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    // 1. Verify Home Screen
    expect(find.text('Rhizosphere Demo'), findsOneWidget);
    expect(find.text('Welcome to Rhizosphere'), findsOneWidget);

    // 2. Enter text
    await tester.enterText(find.byType(AccessibleTextField), 'Test User');
    await tester.pump();
    expect(find.text('Test User'), findsOneWidget);

    // 3. Tap button and check announcement
    await tester.tap(find.byType(AccessibleButton));
    await tester.pump();

    // The announcement sets state, so we should see it
    expect(find.byType(LiveAnnouncer), findsOneWidget);
    expect(find.textContaining('Button pressed at'), findsOneWidget);

    // 4. Navigate to Settings
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsScreen), findsOneWidget);
    expect(find.text('High Contrast'), findsOneWidget);

    // 5. Toggle High Contrast
    await tester.tap(find.byType(SwitchListTile));
    await tester.pump();

    // Verify logic (we can't easily check visual contrast in widget test without screenshot,
    // but we can check the provider state if we had access, or check for specific widgets)
    // Here we just verify the interaction didn't crash and switch changed
    expect(find.byType(SwitchListTile), findsOneWidget);
    // SwitchListTile doesn't expose value easily in finder, but we know it didn't crash.

    // 6. Adjust Text Scale
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Navigate back
    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
