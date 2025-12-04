import 'window_size_class.dart';

enum NavigationType { bottomNavigationBar, navigationRail, permanentDrawer }

class NavigationStrategy {
  final WindowSizeClass sizeClass;
  final NavigationType type;
  final double? railWidth;
  final double? drawerWidth;
  final bool showLabels;

  const NavigationStrategy({
    required this.sizeClass,
    required this.type,
    this.railWidth,
    this.drawerWidth,
    this.showLabels = true,
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
        );
      case WindowSizeClass.expanded:
        return NavigationStrategy(
          sizeClass: sizeClass,
          type: NavigationType.permanentDrawer,
          drawerWidth: 250,
          showLabels: true,
        );
    }
  }
}
