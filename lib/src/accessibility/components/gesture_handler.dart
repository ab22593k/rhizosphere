import 'package:flutter/material.dart';

/// A wrapper that provides alternative gesture inputs for an action.
///
/// Rationale:
/// - **Motor Impairments**: Users with tremors or limited dexterity may struggle with precise taps.
///   Providing alternatives like [onLongPress] or [onVerticalDragEnd] (swipe) allows easier interaction.
/// - **Redundancy**: Ensures that if one gesture is difficult, another is available.
class GestureHandler extends StatelessWidget {
  /// The widget that receives the gestures.
  final Widget child;

  /// The callback triggered by any of the supported gestures.
  final VoidCallback? onTap;

  const GestureHandler({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // Map long press to the same action for users who can hold but not quick-tap.
      onLongPress: onTap,
      // Map vertical swipe to the same action for users who find swiping easier than tapping.
      onVerticalDragEnd: (_) => onTap?.call(),
      child: child,
    );
  }
}
