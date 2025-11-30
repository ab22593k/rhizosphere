import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhizosphere/rhizosphere.dart';
import 'demo/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(accessibilityProvider);

    final baseScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);

    final effectiveScheme = config.highContrast
        ? const ColorScheme.highContrastLight(primary: Colors.deepPurple)
        : baseScheme;

    return MaterialApp(
      title: 'Rhizosphere Demo',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('es'), Locale('de')],
      theme: ThemeData(colorScheme: effectiveScheme, useMaterial3: true),
      builder: (context, child) {
        return AccessibleWrapper(child: child!);
      },
      home: const HomeScreen(),
    );
  }
}
