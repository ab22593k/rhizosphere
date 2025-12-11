import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/adaptive/layout/adaptive_builder.dart';
import '../../../core/adaptive/layout/window_size_class.dart';
import '../providers/adaptive_layout_provider.dart';

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
            children: [
              NavigationRail(
                extended: extended,
                selectedIndex: widget.selectedIndex,
                onDestinationSelected: widget.onDestinationSelected,
                destinations: widget.railDestinations,
                minWidth: 80, // Enforce 80 width from designs
                minExtendedWidth: 256, // Standard extended width
                // Center items on tablet (Medium) for reachability, Top (-1.0) otherwise
                groupAlignment: sizeClass == WindowSizeClass.medium
                    ? 0.0
                    : -1.0,
                // Combine Menu, FAB, and custom leading
                leading: Column(
                  children: [
                    // Menu Button to toggle expansion
                    IconButton(
                      icon: Icon(extended ? Icons.menu_open : Icons.menu),
                      onPressed: () {
                        setState(() {
                          // Toggle and store the preference
                          _railExpanded = !extended;
                        });
                      },
                      tooltip: extended ? 'Collapse menu' : 'Expand menu',
                    ),
                    const SizedBox(height: 8),
                    // Floating Action Button
                    if (widget.floatingActionButton != null) ...[
                      Theme(
                        data: Theme.of(context).copyWith(
                          floatingActionButtonTheme:
                              const FloatingActionButtonThemeData(elevation: 0),
                        ),
                        child: widget.floatingActionButton!,
                      ),
                      const SizedBox(height: 32),
                    ],
                    // Custom leading widget
                    if (widget.navigationRailLeading != null)
                      widget.navigationRailLeading!,
                  ],
                ),
                trailing: widget.navigationRailTrailing,
                // In M3, collapsed rail usually shows icons.
                // LabelType.all ensures labels are shown if desired, but
                // typical M3 behavior:
                // Collapsed: Icons only (labelType: none or selected).
                // Expanded: Labels next to icons.
                // Flutter's NavigationRail handles 'extended' by showing labels.
                // So we can leave labelType null or set it based on preference.
                // User requirement: "Collapsed... should contain 3-7 items... Label text - inactive...".
                // Actually image "Collapsed navigation rail with timer icon" shows just icons.
                // "Label text - active", "Label text - inactive" are listed in Anatomy.
                // But typically for collapsed rail, labels are removed or small.
                // "Collapsed ... should not be hidden".
                // Let's stick to default behavior which hides labels when not extended unless specified.
                labelType: extended ? null : NavigationRailLabelType.all,
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

class AdaptiveScaffold extends ConsumerStatefulWidget {
  const AdaptiveScaffold({super.key});

  @override
  ConsumerState<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

class _AdaptiveScaffoldState extends ConsumerState<AdaptiveScaffold> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationSuiteScaffold(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.alarm), label: 'Alarm'),
        NavigationDestination(icon: Icon(Icons.access_time), label: 'Clock'),
        NavigationDestination(icon: Icon(Icons.timer), label: 'Timer'),
        NavigationDestination(icon: Icon(Icons.timer_off), label: 'Stopwatch'),
      ],
      railDestinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.alarm),
          label: Text('Alarm'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.access_time),
          label: Text('Clock'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.timer),
          label: Text('Timer'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.timer_off),
          label: Text('Stopwatch'),
        ),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 0,
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Text(
          'Page Index: $_selectedIndex',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
