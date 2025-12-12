import 'package:flutter/material.dart' hide ScrollBehavior;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/scroll/scroll_behavior.dart';
import '../utils/text_scaler.dart';
import '../state/accessibility_controller.dart';

/// A root-level wrapper that injects accessibility overrides into the widget tree.
///
/// Rationale:
/// - **Central Control**: Allows the app to enforce text scaling and contrast settings
///   globally, regardless of system settings (useful for in-app overrides).
/// - **MediaQuery Override**: Updates [MediaQuery] data so that all child widgets
///   (like [Text] and [Theme]) automatically adapt to the [AccessibilityConfig].
/// - **Smooth Scrolling**: Applies [ScrollBehavior] to ensure consistent
///   scrolling physics and input handling (e.g., mouse drag) across platforms.
class AccessibleWrapper extends ConsumerWidget {
  final Widget child;

  const AccessibleWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(accessibilityProvider);

    // We override MediaQuery to propagate the custom text scale and contrast settings.
    // We also apply a custom ScrollBehavior.
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: AppTextScaler.fromScale(config.textScaleFactor),
          highContrast: config.highContrast,
        ),
        child: child,
      ),
    );
  }
}
