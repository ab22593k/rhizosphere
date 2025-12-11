import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/adaptive/layout/adaptive_builder.dart';
import '../../../core/adaptive/layout/window_size_class.dart';
import '../providers/adaptive_layout_provider.dart';

class NavigationSuiteScaffold extends ConsumerWidget {
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationDestination> destinations;
  final List<NavigationRailDestination> railDestinations;
  final PreferredSizeWidget? appBar;

  const NavigationSuiteScaffold({
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    required this.railDestinations,
    this.appBar,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdaptiveBuilder(
      onSizeClassChanged: (sizeClass) {
        ref.read(windowSizeClassProvider.notifier).update(sizeClass);
      },
      builder: (context, sizeClass, child) {
        switch (sizeClass) {
          case WindowSizeClass.compact:
            return Scaffold(
              appBar: appBar,
              body: body,
              bottomNavigationBar: NavigationBar(
                selectedIndex: selectedIndex,
                onDestinationSelected: onDestinationSelected,
                destinations: destinations,
              ),
            );
          case WindowSizeClass.medium:
            return Scaffold(
              appBar: appBar,
              body: Row(
                children: [
                  NavigationRail(
                    extended: false,
                    selectedIndex: selectedIndex,
                    onDestinationSelected: onDestinationSelected,
                    destinations: railDestinations,
                    labelType: NavigationRailLabelType.none,
                  ),
                  Expanded(child: body),
                ],
              ),
            );
          case WindowSizeClass.expanded:
            return Scaffold(
              appBar: appBar,
              body: Row(
                children: [
                  NavigationRail(
                    extended: true,
                    selectedIndex: selectedIndex,
                    onDestinationSelected: onDestinationSelected,
                    destinations: railDestinations,
                  ),
                  Expanded(child: body),
                ],
              ),
            );
        }
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
      destinations: [],
      railDestinations: [],

      body: Container(),
    );
  }
}
