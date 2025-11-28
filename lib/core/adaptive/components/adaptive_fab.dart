import 'package:flutter/material.dart';
import '../layout/window_size_class.dart';
import '../layout/adaptive_builder.dart';

class AdaptiveFAB extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final String? tooltip;

  const AdaptiveFAB({
    required this.onPressed,
    required this.child,
    this.tooltip,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizeClass, _) {
        switch (sizeClass) {
          case WindowSizeClass.compact:
            return FloatingActionButton(
              onPressed: onPressed,
              tooltip: tooltip,
              mini: true,
              child: child,
            );
          case WindowSizeClass.medium:
            return FloatingActionButton(
              onPressed: onPressed,
              tooltip: tooltip,
              mini: false,
              child: child,
            );
          case WindowSizeClass.expanded:
            return FloatingActionButton.large(
              onPressed: onPressed,
              tooltip: tooltip,
              child: child,
            );
        }
      },
    );
  }
}
