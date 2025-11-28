import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhizosphere/rhizosphere.dart';

class AdaptiveDemo extends ConsumerStatefulWidget {
  const AdaptiveDemo({super.key});

  @override
  ConsumerState<AdaptiveDemo> createState() => _AdaptiveDemoState();
}

class _AdaptiveDemoState extends ConsumerState<AdaptiveDemo> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Example destinations
    final destinations = const [
      NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
      NavigationDestination(icon: Icon(Icons.list), label: 'Items'),
      NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
    ];

    final railDestinations = const [
      NavigationRailDestination(
        icon: Icon(Icons.dashboard),
        label: Text('Dashboard'),
      ),
      NavigationRailDestination(icon: Icon(Icons.list), label: Text('Items')),
      NavigationRailDestination(
        icon: Icon(Icons.settings),
        label: Text('Settings'),
      ),
    ];

    final drawerDestinations = const [
      NavigationDrawerDestination(
        icon: Icon(Icons.dashboard),
        label: Text('Dashboard'),
      ),
      NavigationDrawerDestination(icon: Icon(Icons.list), label: Text('Items')),
      NavigationDrawerDestination(
        icon: Icon(Icons.settings),
        label: Text('Settings'),
      ),
    ];

    return NavigationSuiteScaffold(
      appBar: AdaptiveAppBar(
        title: const Text('Adaptive Layout Demo'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      destinations: destinations,
      railDestinations: railDestinations,
      drawerDestinations: drawerDestinations,
      body: _buildBody(_selectedIndex),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return const DashboardPane();
      case 1:
        return const ItemsPane();
      case 2:
        return const Center(child: Text('Settings Page'));
      default:
        return const SizedBox.shrink();
    }
  }
}

class DashboardPane extends StatelessWidget {
  const DashboardPane({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AdaptiveFAB(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text('Dashboard Item ${index + 1}'),
              subtitle: const Text('Adaptive content goes here'),
            ),
          );
        },
      ),
    );
  }
}

class ItemsPane extends StatefulWidget {
  const ItemsPane({super.key});

  @override
  State<ItemsPane> createState() => _ItemsPaneState();
}

class _ItemsPaneState extends State<ItemsPane> {
  int? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return ThreePaneLayout(
      supportingPane: _buildSupportingPane(),
      primaryPane: _buildPrimaryPane(),
      detailPane: _buildDetailPane(),
    );
  }

  Widget _buildSupportingPane() {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: ListView(
        children: const [
          ListTile(title: Text('Category A')),
          ListTile(title: Text('Category B')),
          ListTile(title: Text('Category C')),
        ],
      ),
    );
  }

  Widget _buildPrimaryPane() {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item $index'),
          selected: _selectedItem == index,
          onTap: () {
            setState(() {
              _selectedItem = index;
            });
          },
        );
      },
    );
  }

  Widget? _buildDetailPane() {
    if (_selectedItem == null) {
      return const Center(child: Text('Select an item'));
    }
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details for Item $_selectedItem',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            const Text(
              'Here are the full details for the selected item. This pane reflows based on available width.',
            ),
            const Spacer(),
            ElevatedButton(onPressed: () {}, child: const Text('Action')),
          ],
        ),
      ),
    );
  }
}
