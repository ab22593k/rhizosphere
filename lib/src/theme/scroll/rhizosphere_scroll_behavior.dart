import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A custom [ScrollBehavior] that enables smooth scrolling and drag gestures
/// for all pointer devices, including mouse and trackpad.
///
/// This behavior is applied globally via [AccessibleWrapper] to ensure
/// a consistent and accessible scrolling experience across all platforms.
class RhizosphereScrollBehavior extends MaterialScrollBehavior {
  const RhizosphereScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.invertedStylus,
    PointerDeviceKind.unknown,
  };

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    // Use BouncingScrollPhysics for a smoother feel on all platforms,
    // or fallback to default if strictly platform-specific behavior is preferred.
    // BouncingScrollPhysics provides a nice overscroll effect that feels responsive.
    return const BouncingScrollPhysics();
  }
}
