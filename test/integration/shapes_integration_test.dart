import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/src/data/app_theme.dart';
import 'package:rhizosphere/src/shapes/shape_theme.dart';

void main() {
  testWidgets('AppTheme applies shape tokens', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Builder(
          builder: (context) {
            final shapeTheme = Theme.of(context).extension<ShapeTheme>();
            expect(shapeTheme, isNotNull);
            return const SizedBox();
          },
        ),
      ),
    );
  });

  testWidgets('Material widgets use token shapes', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const Scaffold(
          body: Column(
            children: [
              Card(child: Text('Card')),
              Chip(label: Text('Chip')),
            ],
          ),
        ),
      ),
    );

    final card = tester.widget<Card>(find.byType(Card));
    expect(card.shape, isNotNull);

    final chip = tester.widget<Chip>(find.byType(Chip));
    expect(chip.shape, isNotNull);
  });
}
