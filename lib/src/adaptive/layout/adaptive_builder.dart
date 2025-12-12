import 'package:flutter/material.dart';
import 'window_size_class.dart';

typedef AdaptiveBuilderCallback =
    Widget Function(
      BuildContext context,
      WindowSizeClass windowSizeClass,
      Widget? child,
    );

/// A widget that builds different layouts based on the current window size class.
///
/// Uses [LayoutBuilder] to determine the available space and maps it to a
/// [WindowSizeClass]. The [builder] callback is invoked with the current size
/// class to build the appropriate layout.
///
/// This widget is purely declarative and does not trigger any side effects.
/// If you need to share the [WindowSizeClass] state across the widget tree,
/// use the [windowSizeClassProvider] which listens to window metrics changes
/// via [WidgetsBindingObserver.didChangeMetrics].
class AdaptiveBuilder extends StatelessWidget {
  /// Builder callback that receives the current [WindowSizeClass].
  final AdaptiveBuilderCallback builder;

  /// Optional child widget that is passed to the builder for optimization.
  final Widget? child;

  const AdaptiveBuilder({required this.builder, this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final windowSizeClass = WindowSizeClass.fromConstraints(constraints);
        return builder(context, windowSizeClass, child);
      },
    );
  }
}
