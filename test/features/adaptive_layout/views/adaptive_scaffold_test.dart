import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/features/adaptive_layout/views/adaptive_scaffold.dart';
import 'package:rhizosphere/l10n/app_localizations.dart';

void main() {
  testWidgets('AdaptiveScaffold shows BottomNavigationBar on Compact', (
    tester,
  ) async {
    // Set screen size to Compact
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('en')],
          home: AdaptiveScaffold(),
        ),
      ),
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
    tester.view.physicalSize = const Size(800, 600);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('en')],
          home: AdaptiveScaffold(),
        ),
      ),
    );

    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
  });

  testWidgets('AdaptiveScaffold shows NavigationDrawer on Expanded', (
    tester,
  ) async {
    // Set screen size to Expanded
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale('en')],
          home: AdaptiveScaffold(),
        ),
      ),
    );

    expect(find.byType(NavigationDrawer), findsOneWidget); // Permanent drawer
    expect(find.byType(NavigationRail), findsNothing);
  });
}
