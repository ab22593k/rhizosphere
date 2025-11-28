import 'window_size_class.dart';

enum PaneVisibility { hidden, collapsible, permanent, floating }

enum PaneBehavior { stacked, sidebar, reflow }

class PaneConfiguration {
  final WindowSizeClass sizeClass;
  final PaneVisibility supportingPane;
  final PaneVisibility primaryPane;
  final PaneVisibility detailPane;
  final PaneBehavior behavior;

  const PaneConfiguration({
    required this.sizeClass,
    required this.supportingPane,
    required this.primaryPane,
    required this.detailPane,
    required this.behavior,
  });

  factory PaneConfiguration.forSizeClass(WindowSizeClass sizeClass) {
    switch (sizeClass) {
      case WindowSizeClass.compact:
        return PaneConfiguration(
          sizeClass: sizeClass,
          supportingPane: PaneVisibility.hidden,
          primaryPane: PaneVisibility.permanent,
          detailPane: PaneVisibility.hidden, // Or stacked navigation
          behavior: PaneBehavior.stacked,
        );
      case WindowSizeClass.medium:
        return PaneConfiguration(
          sizeClass: sizeClass,
          supportingPane: PaneVisibility.permanent, // Rail
          primaryPane: PaneVisibility.permanent,
          detailPane: PaneVisibility.floating, // Levitate
          behavior: PaneBehavior.sidebar,
        );
      case WindowSizeClass.expanded:
        return PaneConfiguration(
          sizeClass: sizeClass,
          supportingPane: PaneVisibility.permanent,
          primaryPane: PaneVisibility.permanent,
          detailPane: PaneVisibility.permanent, // Reflow
          behavior: PaneBehavior.reflow,
        );
    }
  }
}
