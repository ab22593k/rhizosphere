import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../layout/adaptive_builder.dart';
import '../layout/window_size_class.dart';
import '../state/window_size_class_provider.dart';

class NavigationSuiteScaffold extends ConsumerStatefulWidget {
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationDestination> destinations;
  final List<NavigationRailDestination> railDestinations;
  final PreferredSizeWidget? appBar;
  final Widget? navigationRailLeading;
  final Widget? navigationRailTrailing;
  final Widget? floatingActionButton;

  const NavigationSuiteScaffold({
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    required this.railDestinations,
    this.appBar,
    this.navigationRailLeading,
    this.navigationRailTrailing,
    this.floatingActionButton,
    super.key,
  });

  @override
  ConsumerState<NavigationSuiteScaffold> createState() =>
      _NavigationSuiteScaffoldState();
}

class _NavigationSuiteScaffoldState
    extends ConsumerState<NavigationSuiteScaffold> {
  bool? _railExpanded;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      onSizeClassChanged: (sizeClass) {
        ref.read(windowSizeClassProvider.notifier).update(sizeClass);
      },
      builder: (context, sizeClass, child) {
        // Determine if we should show the Navigation Rail
        final isCompact = sizeClass == WindowSizeClass.compact;
        final isDesktop = sizeClass == WindowSizeClass.expanded;

        // Default expanded state logic
        final defaultExpanded = isDesktop;
        final extended = _railExpanded ?? defaultExpanded;

        if (isCompact) {
          return Scaffold(
            appBar: widget.appBar,
            body: widget.body,
            floatingActionButton: widget.floatingActionButton,
            bottomNavigationBar: NavigationBar(
              selectedIndex: widget.selectedIndex,
              onDestinationSelected: widget.onDestinationSelected,
              destinations: widget.destinations,
            ),
          );
        }

        return Scaffold(
          appBar: widget.appBar,
          // When using Rail, FAB is placed inside the rail leading
          floatingActionButton: null,
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom left panel: Menu + FAB + NavigationRail
              // Using IntrinsicWidth to constrain width based on NavigationRail
              IntrinsicWidth(
                child: Container(
                  // M3: md.comp.nav-rail.collapsed.container.color = #FEF7FF
                  color: Theme.of(context).colorScheme.surface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // M3: md.comp.nav-rail.collapsed.top-space = 44dp
                      const SizedBox(height: 44),
                      // Menu Button to toggle expansion
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: IconButton(
                          icon: Icon(extended ? Icons.menu_open : Icons.menu),
                          onPressed: () {
                            setState(() {
                              _railExpanded = !extended;
                            });
                          },
                          tooltip: extended ? 'Collapse menu' : 'Expand menu',
                        ),
                      ),
                      // M3: Vertical spacing between menu and FAB
                      const SizedBox(height: 8),
                      // Floating Action Button
                      if (widget.floatingActionButton != null) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              floatingActionButtonTheme:
                                  const FloatingActionButtonThemeData(
                                    elevation: 0,
                                  ),
                            ),
                            child: widget.floatingActionButton!,
                          ),
                        ),
                        // M3: md.comp.nav-rail.expanded.vertical.trailing-space = 20dp
                        const SizedBox(height: 20),
                      ],
                      // Custom leading widget
                      if (widget.navigationRailLeading != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: widget.navigationRailLeading!,
                        ),
                      // Navigation Rail (destinations only, no leading)
                      Expanded(
                        child: NavigationRail(
                          extended: extended,
                          selectedIndex: widget.selectedIndex,
                          onDestinationSelected: widget.onDestinationSelected,
                          destinations: widget.railDestinations,
                          minWidth: 80,
                          minExtendedWidth: 220,
                          groupAlignment: sizeClass == WindowSizeClass.medium
                              ? 0.0
                              : -1.0,
                          leading: const SizedBox.shrink(),
                          trailing: widget.navigationRailTrailing,
                          labelType: extended
                              ? null
                              : NavigationRailLabelType.all,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Use a divider to separate rail from content
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(child: widget.body),
            ],
          ),
        );
      },
    );
  }
}
