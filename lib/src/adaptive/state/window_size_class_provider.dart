import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../layout/window_size_class.dart';
import '../layout/navigation_strategy.dart';
import '../layout/pane_configuration.dart';

class WindowSizeClassNotifier extends StateNotifier<WindowSizeClass> {
  WindowSizeClassNotifier() : super(WindowSizeClass.compact);

  void update(WindowSizeClass newSizeClass) {
    if (state != newSizeClass) {
      state = newSizeClass;
    }
  }
}

final windowSizeClassProvider =
    StateNotifierProvider<WindowSizeClassNotifier, WindowSizeClass>((ref) {
      return WindowSizeClassNotifier();
    });

final navigationStrategyProvider = Provider<NavigationStrategy>((ref) {
  final sizeClass = ref.watch(windowSizeClassProvider);
  return NavigationStrategy.forSizeClass(sizeClass);
});

final paneConfigurationProvider = Provider<PaneConfiguration>((ref) {
  final sizeClass = ref.watch(windowSizeClassProvider);
  return PaneConfiguration.forSizeClass(sizeClass);
});
