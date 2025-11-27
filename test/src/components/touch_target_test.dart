import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/rhizosphere.dart';

void main() {
  testWidgets('AccessibleButton has minimum touch target size of 48x48', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AccessibleButton(
            label: 'Tap Me',
            semanticLabel: 'Tap Me',
            onPressed: () {},
          ),
        ),
      ),
    );

    final button = find.byType(AccessibleButton);
    final size = tester.getSize(button);

    // Check if the widget itself or its touch target is at least 48x48
    // Note: ElevatedButtons have an internal minimum size, but let's verify our wrapper ensures it or exposes it
    // Actually, tester.getSize gets the render box size.
    // Material guidelines say the visual size can be smaller but the touch target must be 48x48.
    // Flutter's Material buttons usually handle this internally with padding/visuals.
    // Let's verify the Size is effectively ensuring 48x48 constraint or similar.

    // However, for a strict test, we might check if the center of the button is tappable
    // and if the widget has a minimum size constraint.

    // Let's check if the HitTestBehavior or MinSize is respected.
    // A simpler check for this test: check if the render object size is >= 48x48 OR if it's wrapped in something that enforces it.
    // Standard ElevatedButton has a default minSize, but let's assume we want to enforce it strictly.

    // Actually, we should test that our AccessibleButton implementation *enforces* this,
    // e.g., by using a ConstrainedBox or similar if the child doesn't guarantee it.

    // Let's expect it to be at least 48 height. Width might vary by text.
    // But for a square or icon button it matters more. For a text button, height >= 48 is key.

    expect(size.height, greaterThanOrEqualTo(48.0));
    expect(size.width, greaterThanOrEqualTo(48.0));
  });
}
