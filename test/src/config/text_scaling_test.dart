import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/rhizosphere.dart';

void main() {
  testWidgets('AccessibleWrapper applies text scale factor', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MediaQuery(
          data: MediaQueryData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: AccessibleWrapper(child: Text('Scaling Test')),
          ),
        ),
      ),
    );

    // Default scale should be 1.0
    final context = tester.element(find.text('Scaling Test'));
    expect(
      MediaQuery.of(context).textScaler,
      equals(const TextScaler.linear(1.0)),
    );
  });
}
