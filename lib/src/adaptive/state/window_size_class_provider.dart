import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../layout/window_size_class.dart';
import '../layout/navigation_strategy.dart';
import '../layout/pane_configuration.dart';

/// A [WidgetsBindingObserver] that listens to window metrics changes and
/// updates the [WindowSizeClass] state accordingly.
///
/// This approach is declarative and avoids the "ping-pong" effect caused by
/// updating state during the build phase. The observer listens to
/// [didChangeMetrics] which fires when the window size changes.
class WindowSizeClassNotifier extends Notifier<WindowSizeClass>
    with WidgetsBindingObserver {
  @override
  WindowSizeClass build() {
    // Register observer on initialization
    WidgetsBinding.instance.addObserver(this);

    // Clean up observer when provider is disposed
    ref.onDispose(() {
      WidgetsBinding.instance.removeObserver(this);
    });

    // Return initial size class based on current window
    return _computeSizeClass();
  }

  /// Computes the [WindowSizeClass] from the current window physical size.
  WindowSizeClass _computeSizeClass() {
    final view = WidgetsBinding.instance.platformDispatcher.views.firstOrNull;
    if (view == null) return WindowSizeClass.compact;

    final physicalSize = view.physicalSize;
    final devicePixelRatio = view.devicePixelRatio;

    // Convert physical pixels to logical pixels
    final logicalWidth = physicalSize.width / devicePixelRatio;

    return WindowSizeClass.fromWidth(logicalWidth);
  }

  @override
  void didChangeMetrics() {
    // When window metrics change, recompute and update state
    final newSizeClass = _computeSizeClass();
    if (state != newSizeClass) {
      state = newSizeClass;
    }
  }
}

/// Provider that reactively tracks the current [WindowSizeClass] based on
/// window size. Uses [WidgetsBindingObserver.didChangeMetrics] to detect
/// window size changes, avoiding side effects in build methods.
final windowSizeClassProvider =
    NotifierProvider<WindowSizeClassNotifier, WindowSizeClass>(
      WindowSizeClassNotifier.new,
    );

/// Derives the appropriate [NavigationStrategy] from the current window size.
final navigationStrategyProvider = Provider<NavigationStrategy>((ref) {
  final sizeClass = ref.watch(windowSizeClassProvider);
  return NavigationStrategy.forSizeClass(sizeClass);
});

/// Derives the appropriate [PaneConfiguration] from the current window size.
final paneConfigurationProvider = Provider<PaneConfiguration>((ref) {
  final sizeClass = ref.watch(windowSizeClassProvider);
  return PaneConfiguration.forSizeClass(sizeClass);
});
