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
  bool _showFAB = true;
  bool _useCustomAppBar = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Comprehensive NavigationSuiteScaffold examples
    return NavigationSuiteScaffold(
      // Example 1: Custom AppBar with actions
      appBar: _useCustomAppBar
          ? AdaptiveAppBar(
              title: Text('${l10n.appTitle} - Advanced Demo'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: 'Search',
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  tooltip: 'Filter',
                  onPressed: () {},
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    setState(() {
                      if (value == 'fab') {
                        _showFAB = !_showFAB;
                      }
                      if (value == 'appbar') {
                        _useCustomAppBar = !_useCustomAppBar;
                      }
                    });
                  },
                  itemBuilder: (context) => [
                    CheckedPopupMenuItem(
                      value: 'fab',
                      checked: _showFAB,
                      child: const Text('Show FAB'),
                    ),
                    CheckedPopupMenuItem(
                      value: 'appbar',
                      checked: _useCustomAppBar,
                      child: const Text('Custom AppBar'),
                    ),
                  ],
                ),
              ],
            )
          : AdaptiveAppBar(title: Text('${l10n.appTitle} - Adaptive Demo')),

      // Example 2: Comprehensive destinations with icons, labels, and tooltips
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },

      // Bottom navigation destinations (compact screens)
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.dashboard),
          selectedIcon: Icon(Icons.dashboard_outlined),
          label: 'Dashboard',
          tooltip: 'View main dashboard',
        ),
        NavigationDestination(
          icon: Icon(Icons.list),
          selectedIcon: Icon(Icons.list_outlined),
          label: 'Items',
          tooltip: 'Browse items list',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings),
          selectedIcon: Icon(Icons.settings_outlined),
          label: 'Settings',
          tooltip: 'App settings',
        ),
        NavigationDestination(
          icon: Icon(Icons.help),
          selectedIcon: Icon(Icons.help_outline),
          label: 'Help',
          tooltip: 'Get help',
        ),
      ],

      // Navigation rail destinations (medium screens)
      railDestinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.dashboard),
          selectedIcon: Icon(Icons.dashboard_outlined),
          label: Text('Dashboard'),
          padding: EdgeInsets.symmetric(vertical: 8),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.list),
          selectedIcon: Icon(Icons.list_outlined),
          label: Text('Items'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings),
          selectedIcon: Icon(Icons.settings_outlined),
          label: Text('Settings'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.help),
          selectedIcon: Icon(Icons.help_outline),
          label: Text('Help'),
        ),
      ],

      // Navigation drawer destinations (expanded screens)
      drawerDestinations: [
        NavigationDrawerDestination(
          icon: const Icon(Icons.dashboard),
          label: const Text('Dashboard'),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.list),
          label: const Text('Items'),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.settings),
          label: Text(l10n.settingsLabel),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.help),
          label: Text('Help'),
        ),
        const Divider(),
        NavigationDrawerDestination(
          icon: const Icon(Icons.logout),
          label: Text(l10n.signOut),
        ),
      ],

      // Example 3: Dynamic body content based on selection
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
        return const SettingsPane();
      case 3:
        return const HelpPane();
      default:
        return const SizedBox.shrink();
    }
  }
}

// Example 1: Dashboard with FAB and list
class DashboardPane extends StatelessWidget {
  const DashboardPane({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AdaptiveFAB(
        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('FAB pressed!')));
        },
        tooltip: 'Add new item',
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AccessibleHeader(text: 'Dashboard Overview', level: 1),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text('Dashboard item ${index + 1}'),
                  subtitle: const Text(
                    'Adaptive content that reflows based on screen size',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
              );
            }, childCount: 20),
          ),
        ],
      ),
    );
  }
}

// Example 2: Comprehensive ThreePaneLayout with all features
class ItemsPane extends StatefulWidget {
  const ItemsPane({super.key});

  @override
  State<ItemsPane> createState() => _ItemsPaneState();
}

class _ItemsPaneState extends State<ItemsPane> {
  int? _selectedItem;
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return ThreePaneLayout(
      // Supporting pane: Categories filter
      supportingPane: _buildSupportingPane(),

      // Primary pane: Items list
      primaryPane: _buildPrimaryPane(),

      // Detail pane: Item details (conditional)
      detailPane: _buildDetailPane(),
    );
  }

  Widget _buildSupportingPane() {
    final categories = ['All', 'Work', 'Personal', 'Archive'];

    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AccessibleHeader(text: 'Categories', level: 2),
          ),
          Expanded(
            child: ListView(
              children: categories.map((category) {
                return ListTile(
                  title: Text(category),
                  selected: _selectedCategory == category,
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add Category'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryPane() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              AccessibleHeader(text: 'Items ($_selectedCategory)', level: 2),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.sort),
                tooltip: 'Sort items',
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.view_list),
                tooltip: 'Change view',
                onPressed: () {},
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 25,
            itemBuilder: (context, index) {
              final isSelected = _selectedItem == index;
              return AccessibleCard(
                title: 'Item ${index + 1}',
                description:
                    'This is a detailed description of item ${index + 1}. '
                    'It shows how content adapts to different pane sizes.',
                onTap: () {
                  setState(() {
                    _selectedItem = isSelected ? null : index;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget? _buildDetailPane() {
    if (_selectedItem == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            const Text(
              'Select an item to view details',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text(
              'The detail pane will show comprehensive information about the selected item.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AccessibleHeader(text: 'Item Details', level: 1),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: 'Edit item',
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Delete item',
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Comprehensive Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'This detail pane demonstrates how ThreePaneLayout adapts content '
              'based on available screen real estate. On larger screens, this pane '
              'can show rich content including images, charts, and detailed information.',
            ),
            const SizedBox(height: 24),
            const Text(
              'Key Features:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('• Adaptive layout that reflows content'),
            const Text('• Rich detail presentation'),
            const Text('• Contextual actions and navigation'),
            const Text('• Optimized for different screen sizes'),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedItem = null;
                    });
                  },
                  child: const Text('Close'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Save Changes'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Example 3: Settings pane with form elements
class SettingsPane extends StatelessWidget {
  const SettingsPane({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AccessibleHeader(text: 'Settings', level: 1),
        const SizedBox(height: 24),
        const Text(
          'Configure your app preferences below. Changes are saved automatically.',
        ),
        const SizedBox(height: 32),

        // Theme settings
        AccessibleHeader(text: 'Appearance', level: 2),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text('Dark Mode'),
          subtitle: const Text('Use dark theme'),
          value: false,
          onChanged: (value) {},
        ),
        SwitchListTile(
          title: const Text('High Contrast'),
          subtitle: const Text('Increase contrast for better visibility'),
          value: false,
          onChanged: (value) {},
        ),

        const SizedBox(height: 32),

        // Accessibility settings
        AccessibleHeader(text: 'Accessibility', level: 2),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text('Screen Reader'),
          subtitle: const Text('Optimize for screen readers'),
          value: true,
          onChanged: (value) {},
        ),
        ListTile(
          title: const Text('Text Scale'),
          subtitle: const Text('Adjust text size'),
          trailing: DropdownButton<String>(
            value: 'Normal',
            items: ['Small', 'Normal', 'Large', 'Extra Large']
                .map((size) => DropdownMenuItem(value: size, child: Text(size)))
                .toList(),
            onChanged: (value) {},
          ),
        ),

        const SizedBox(height: 32),

        // Account settings
        AccessibleHeader(text: 'Account', level: 2),
        const SizedBox(height: 16),
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: const Text('Profile'),
          subtitle: const Text('Update your profile information'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.notifications)),
          title: const Text('Notifications'),
          subtitle: const Text('Manage notification preferences'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),

        const SizedBox(height: 48),

        // Action buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Reset to Defaults'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Save Settings'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Example 4: Help pane with rich content
class HelpPane extends StatelessWidget {
  const HelpPane({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AccessibleHeader(text: 'Help & Support', level: 1),
        const SizedBox(height: 24),

        // Quick actions
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccessibleHeader(text: 'Quick Actions', level: 2),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ActionChip(
                      label: const Text('Getting Started'),
                      onPressed: () {},
                    ),
                    ActionChip(label: const Text('FAQ'), onPressed: () {}),
                    ActionChip(
                      label: const Text('Contact Support'),
                      onPressed: () {},
                    ),
                    ActionChip(
                      label: const Text('Report Issue'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // NavigationSuiteScaffold explanation
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccessibleHeader(
                  text: 'NavigationSuiteScaffold Features',
                  level: 2,
                ),
                const SizedBox(height: 16),
                const Text(
                  'NavigationSuiteScaffold automatically adapts navigation based on screen size:',
                ),
                const SizedBox(height: 12),
                const Text('• Compact screens: Bottom navigation bar'),
                const Text('• Medium screens: Side navigation rail'),
                const Text('• Expanded screens: Navigation drawer'),
                const SizedBox(height: 16),
                const Text(
                  'This ensures optimal navigation experience across all device types.',
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // ThreePaneLayout explanation
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccessibleHeader(text: 'ThreePaneLayout Features', level: 2),
                const SizedBox(height: 16),
                const Text(
                  'ThreePaneLayout provides a flexible three-pane layout that adapts to available space:',
                ),
                const SizedBox(height: 12),
                const Text('• Supporting pane: Filters, categories, tools'),
                const Text('• Primary pane: Main content list'),
                const Text('• Detail pane: Selected item details'),
                const SizedBox(height: 16),
                const Text(
                  'Panes collapse or stack based on screen width, maintaining usability.',
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 48),

        // Demo controls
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccessibleHeader(text: 'Demo Controls', level: 2),
                const SizedBox(height: 16),
                const Text(
                  'Use the menu button in the app bar to toggle different demo features.',
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('Show FAB'),
                      selected: true,
                      onSelected: (selected) {},
                    ),
                    FilterChip(
                      label: const Text('Custom AppBar'),
                      selected: false,
                      onSelected: (selected) {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
