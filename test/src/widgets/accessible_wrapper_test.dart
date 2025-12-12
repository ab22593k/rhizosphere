import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide ScrollBehavior;
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhizosphere/src/accessibility/widgets/accessible_wrapper.dart';
import 'package:rhizosphere/src/theme/scroll/scroll_behavior.dart';

void main() {
  testWidgets('AccessibleWrapper applies RhizosphereScrollBehavior', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: AccessibleWrapper(child: SizedBox())),
      ),
    );

    // Find ScrollConfiguration
    final scrollConfig = tester.widget<ScrollConfiguration>(
      find.descendant(
        of: find.byType(AccessibleWrapper),
        matching: find.byType(ScrollConfiguration),
      ),
    );

    expect(scrollConfig.behavior, isA<ScrollBehavior>());

    final behavior = scrollConfig.behavior;
    expect(behavior.dragDevices, contains(PointerDeviceKind.mouse));
    expect(behavior.dragDevices, contains(PointerDeviceKind.touch));
  });
}
