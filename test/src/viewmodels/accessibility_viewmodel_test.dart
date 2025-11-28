import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/rhizosphere.dart';

void main() {
  test('AccessibilityNotifier toggles high contrast', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(accessibilityProvider.notifier);

    expect(container.read(accessibilityProvider).highContrast, isFalse);

    notifier.toggleHighContrast();
    expect(container.read(accessibilityProvider).highContrast, isTrue);

    notifier.toggleHighContrast();
    expect(container.read(accessibilityProvider).highContrast, isFalse);
  });

  test('AccessibilityNotifier sets text scale', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final notifier = container.read(accessibilityProvider.notifier);

    expect(container.read(accessibilityProvider).textScaleFactor, 1.0);

    notifier.setTextScale(1.5);
    expect(container.read(accessibilityProvider).textScaleFactor, 1.5);
  });
}
