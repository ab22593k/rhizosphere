import 'window_size_class.dart';

enum NavigationType { bottomNavigationBar, navigationRail }

class NavigationStrategy {
  final WindowSizeClass sizeClass;
  final NavigationType type;
  final double? railWidth;
  final bool showLabels;
  final bool extendedRail;

  const NavigationStrategy({
    required this.sizeClass,
    required this.type,
    this.railWidth,
    this.showLabels = true,
    this.extendedRail = false,
  });

  factory NavigationStrategy.forSizeClass(WindowSizeClass sizeClass) {
    switch (sizeClass) {
      case WindowSizeClass.compact:
        return NavigationStrategy(
          sizeClass: sizeClass,
          type: NavigationType.bottomNavigationBar,
        );
      case WindowSizeClass.medium:
        return NavigationStrategy(
          sizeClass: sizeClass,
          type: NavigationType.navigationRail,
          railWidth: 80,
          showLabels: false,
          extendedRail: false,
        );
      case WindowSizeClass.expanded:
        return NavigationStrategy(
          sizeClass: sizeClass,
          type: NavigationType.navigationRail,
          railWidth: 250,
          showLabels: true,
          extendedRail: true,
        );
    }
  }
}
