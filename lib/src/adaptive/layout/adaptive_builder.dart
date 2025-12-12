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
/// The [onSizeClassChanged] callback is only invoked when the size class
/// actually changes (not on every build), preventing callback spam during
/// window resizing.
class AdaptiveBuilder extends StatefulWidget {
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
  State<AdaptiveBuilder> createState() => _AdaptiveBuilderState();
}

class _AdaptiveBuilderState extends State<AdaptiveBuilder> {
  /// Cached size class to detect actual changes
  WindowSizeClass? _lastSizeClass;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final windowSizeClass = WindowSizeClass.fromConstraints(constraints);

        // Only notify when size class actually changes
        if (widget.onSizeClassChanged != null &&
            windowSizeClass != _lastSizeClass) {
          // Cache the new size class immediately to prevent duplicate callbacks
          final previousSizeClass = _lastSizeClass;
          _lastSizeClass = windowSizeClass;

          // Schedule callback to avoid build-phase state change errors
          // Only call if this isn't the initial build (previousSizeClass != null)
          // or if you want to notify on initial build too, remove the condition
          if (previousSizeClass != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.onSizeClassChanged!(windowSizeClass);
            });
          }
        } else {
          // First build - just cache without callback
          _lastSizeClass ??= windowSizeClass;
        }

        return widget.builder(context, windowSizeClass, widget.child);
      },
    );
  }
}
