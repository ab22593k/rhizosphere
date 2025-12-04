import 'package:flutter/animation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhizosphere/src/motion/spring_wrapper.dart';

void main() {
  testWidgets('SpringAnimation.animateTo starts animation', (tester) async {
    final controller = AnimationController(vsync: const TestVSync());
    final wrapper = SpringAnimation(controller);

    const spring = SpringDescription(mass: 1, stiffness: 100, damping: 10);

    wrapper.animateTo(1.0, spring);

    expect(controller.isAnimating, true);

    controller.dispose();
  });
}
