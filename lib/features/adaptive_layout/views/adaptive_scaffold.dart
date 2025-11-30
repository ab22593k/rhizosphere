import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/adaptive/components/adaptive_app_bar.dart';
import '../../../core/adaptive/layout/adaptive_builder.dart';
import '../../../core/adaptive/layout/window_size_class.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/adaptive_layout_provider.dart';

class NavigationSuiteScaffold extends ConsumerWidget {
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationDestination> destinations; // For NavigationBar
  final List<NavigationRailDestination> railDestinations; // For Rail
  final List<Widget> drawerDestinations; // For Drawer (usually list tiles)
  final PreferredSizeWidget? appBar;

  const NavigationSuiteScaffold({
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
    required this.railDestinations,
    required this.drawerDestinations,
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
                    selectedIndex: selectedIndex,
                    onDestinationSelected: onDestinationSelected,
                    destinations: railDestinations,
                    labelType: NavigationRailLabelType.none, // Or selected
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
                  NavigationDrawer(
                    selectedIndex: selectedIndex,
                    onDestinationSelected: onDestinationSelected,
                    children: drawerDestinations,
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
    final l10n = AppLocalizations.of(context)!;
    return NavigationSuiteScaffold(
      appBar: AdaptiveAppBar(title: Text(l10n.appTitle)),
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home),
          label: l10n.homeLabel,
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings),
          label: l10n.settingsLabel,
        ),
      ],
      railDestinations: [
        NavigationRailDestination(
          icon: const Icon(Icons.home),
          label: Text(l10n.homeLabel),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.settings),
          label: Text(l10n.settingsLabel),
        ),
      ],
      drawerDestinations: [
        NavigationDrawerDestination(
          icon: const Icon(Icons.home),
          label: Text(l10n.homeLabel),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.settings),
          label: Text(l10n.settingsLabel),
        ),
      ],
      body: Center(child: Text(l10n.adaptiveBody)),
    );
  }
}
