import 'package:flutter/material.dart';
import 'window_size_class.dart';

typedef AdaptiveBuilderCallback =
    Widget Function(
      BuildContext context,
      WindowSizeClass windowSizeClass,
      Widget? child,
    );

class AdaptiveBuilder extends StatelessWidget {
  final AdaptiveBuilderCallback builder;
  final Widget? child;
  final ValueChanged<WindowSizeClass>? onSizeClassChanged;

  const AdaptiveBuilder({
    required this.builder,
    this.child,
    this.onSizeClassChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final windowSizeClass = WindowSizeClass.fromConstraints(constraints);
        if (onSizeClassChanged != null) {
          // Schedule update to avoid build-phase state change errors
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onSizeClassChanged!(windowSizeClass);
          });
        }
        return builder(context, windowSizeClass, child);
      },
    );
  }
}
