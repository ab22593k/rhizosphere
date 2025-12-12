/// Material Design 3 layout dimension tokens.
///
/// These constants are derived from the Material Design 3 specification for
/// various adaptive layout components. Using these tokens instead of magic
/// numbers improves maintainability and ensures consistency across the library.
///
/// References:
/// - [Material Design 3 Navigation Rail](https://m3.material.io/components/navigation-rail)
/// - [Material Design 3 Canonical Layouts](https://m3.material.io/foundations/layout/canonical-layouts)
class LayoutTokens {
  const LayoutTokens._();

  // ============================================================================
  // Navigation Rail Tokens
  // ============================================================================

  /// Top space for collapsed navigation rail.
  /// M3: md.comp.nav-rail.collapsed.top-space = 44dp
  static const double navigationRailTopSpace = 44.0;

  /// Minimum width for collapsed navigation rail.
  /// M3: md.comp.nav-rail.collapsed.container.width = 80dp
  static const double navigationRailMinWidth = 80.0;

  /// Minimum width for expanded navigation rail.
  /// M3: md.comp.nav-rail.expanded.container.width = 220dp (minimum)
  static const double navigationRailMinExtendedWidth = 220.0;

  /// Vertical spacing between menu button and FAB.
  /// M3: md.comp.nav-rail.vertical.spacing.menu-fab = 8dp
  static const double navigationRailMenuFabSpacing = 8.0;

  /// Trailing space after FAB in navigation rail.
  /// M3: md.comp.nav-rail.expanded.vertical.trailing-space = 20dp
  static const double navigationRailFabTrailingSpace = 20.0;

  /// Horizontal padding for navigation rail leading content.
  /// M3: md.comp.nav-rail.horizontal.padding = 12dp
  static const double navigationRailHorizontalPadding = 12.0;

  /// Width of the navigation rail divider.
  /// M3: md.comp.nav-rail.divider.width = 1dp
  static const double navigationRailDividerWidth = 1.0;

  // ============================================================================
  // Navigation Bar Tokens
  // ============================================================================

  /// Height of the navigation bar.
  /// M3: md.comp.nav-bar.container.height = 80dp
  static const double navigationBarHeight = 80.0;

  // ============================================================================
  // Pane Layout Tokens
  // ============================================================================

  /// Minimum width for the list pane in list-detail layout.
  /// M3 Canonical: Recommended minimum for list pane = 360dp
  static const double listPaneMinWidth = 360.0;

  /// Default width for the list pane in list-detail layout.
  /// M3 Canonical: Default list pane width = 412dp
  static const double listPaneDefaultWidth = 412.0;

  /// Maximum width for the detail pane in list-detail layout.
  /// M3 Canonical: Recommended maximum for detail pane = 640dp
  static const double detailPaneMaxWidth = 640.0;

  /// Minimum width for the supporting pane in three-pane layout.
  /// M3 Canonical: Minimum supporting pane width = 240dp
  static const double supportingPaneMinWidth = 240.0;

  /// Maximum width for the supporting pane in three-pane layout.
  /// M3 Canonical: Maximum supporting pane width = 400dp
  static const double supportingPaneMaxWidth = 400.0;

  /// Gutter width between panes.
  /// M3 Canonical: Pane gutter = 24dp
  static const double paneGutter = 24.0;

  /// Outer margin for canonical layouts.
  /// M3 Canonical: Outer margin = 24dp
  static const double canonicalOuterMargin = 24.0;

  // ============================================================================
  // General Spacing Tokens
  // ============================================================================

  /// Extra small spacing (4dp).
  static const double spacingXs = 4.0;

  /// Small spacing (8dp).
  static const double spacingSm = 8.0;

  /// Medium spacing (12dp).
  static const double spacingMd = 12.0;

  /// Large spacing (16dp).
  static const double spacingLg = 16.0;

  /// Extra large spacing (24dp).
  static const double spacingXl = 24.0;

  /// Extra extra large spacing (32dp).
  static const double spacingXxl = 32.0;
}
