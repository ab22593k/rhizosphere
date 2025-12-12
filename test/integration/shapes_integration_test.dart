import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/src/theme/app_theme.dart';
import 'package:rhizosphere/src/shapes/shape_theme.dart';
import 'package:rhizosphere/src/shapes/shape_borders.dart';
import 'package:rhizosphere/src/shapes/corner_style.dart';

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
    late CardThemeData cardTheme;
    late ChipThemeData chipTheme;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Builder(
          builder: (context) {
            // Capture the theme data for assertions
            cardTheme = CardTheme.of(context);
            chipTheme = ChipTheme.of(context);
            return const Scaffold(
              body: Column(
                children: [
                  Card(child: Text('Card')),
                  Chip(label: Text('Chip')),
                ],
              ),
            );
          },
        ),
      ),
    );

    // Test that the widgets render correctly
    final cardFinder = find.byType(Card);
    final chipFinder = find.byType(Chip);

    expect(cardFinder, findsOneWidget);
    expect(chipFinder, findsOneWidget);

    // Verify that the CardTheme uses TokenRoundedRectangleBorder
    final cardShape = cardTheme.shape;
    expect(cardShape, isNotNull, reason: 'CardTheme should have a shape');
    expect(
      cardShape,
      isA<TokenRoundedRectangleBorder>(),
      reason: 'CardTheme shape should be TokenRoundedRectangleBorder',
    );

    // Verify specific corner styles on the Card shape
    final tokenCardShape = cardShape as TokenRoundedRectangleBorder;
    expect(
      tokenCardShape.topStart,
      equals(CornerStyle.m),
      reason: 'Card topStart corner should be CornerStyle.m',
    );
    expect(
      tokenCardShape.topEnd,
      equals(CornerStyle.m),
      reason: 'Card topEnd corner should be CornerStyle.m',
    );
    expect(
      tokenCardShape.bottomStart,
      equals(CornerStyle.m),
      reason: 'Card bottomStart corner should be CornerStyle.m',
    );
    expect(
      tokenCardShape.bottomEnd,
      equals(CornerStyle.m),
      reason: 'Card bottomEnd corner should be CornerStyle.m',
    );

    // Verify that the ChipTheme uses TokenStadiumBorder
    final chipShape = chipTheme.shape;
    expect(chipShape, isNotNull, reason: 'ChipTheme should have a shape');
    expect(
      chipShape,
      isA<TokenStadiumBorder>(),
      reason: 'ChipTheme shape should be TokenStadiumBorder',
    );
  });
}
