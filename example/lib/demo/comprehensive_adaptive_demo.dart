import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhizosphere/rhizosphere.dart';

/// Comprehensive NavigationSuiteScaffold and ThreePaneLayout Examples
///
/// This file demonstrates various configurations and use cases for:
/// - NavigationSuiteScaffold with different destination types
/// - ThreePaneLayout with various pane arrangements
/// - Adaptive behavior across screen sizes
/// - Integration with Rhizosphere components

/// Comprehensive NavigationSuiteScaffold and ThreePaneLayout Examples
///
/// This file demonstrates various configurations and use cases for:
/// - NavigationSuiteScaffold with different destination types
/// - ThreePaneLayout with various pane arrangements
/// - Adaptive behavior across screen sizes
/// - Integration with Rhizosphere components
class ComprehensiveAdaptiveDemo extends ConsumerStatefulWidget {
  const ComprehensiveAdaptiveDemo({super.key});

  @override
  ConsumerState<ComprehensiveAdaptiveDemo> createState() =>
      _ComprehensiveAdaptiveDemoState();
}

class _ComprehensiveAdaptiveDemoState
    extends ConsumerState<ComprehensiveAdaptiveDemo> {
  int _selectedIndex = 0;
  DemoConfiguration _config = const DemoConfiguration();

  @override
  Widget build(BuildContext context) {
    return NavigationSuiteScaffold(
      appBar: AdaptiveAppBar(
        title: const Text('Comprehensive Adaptive Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Demo Settings',
            onPressed: _showDemoSettings,
          ),
        ],
      ),
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      destinations: _buildDestinations(),
      railDestinations: _buildRailDestinations(),
      drawerDestinations: _buildDrawerDestinations(),
      body: _buildBody(),
    );
  }

  List<NavigationDestination> _buildDestinations() {
    return const [
      NavigationDestination(icon: Icon(Icons.grid_view), label: 'Grid Layout'),
      NavigationDestination(icon: Icon(Icons.view_list), label: 'List Layout'),
      NavigationDestination(
        icon: Icon(Icons.account_tree),
        label: 'Tree Layout',
      ),
      NavigationDestination(
        icon: Icon(Icons.table_chart),
        label: 'Table Layout',
      ),
    ];
  }

  List<NavigationRailDestination> _buildRailDestinations() {
    return const [
      NavigationRailDestination(
        icon: Icon(Icons.grid_view),
        label: Text('Grid'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.view_list),
        label: Text('List'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.account_tree),
        label: Text('Tree'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.table_chart),
        label: Text('Table'),
      ),
    ];
  }

  List<Widget> _buildDrawerDestinations() {
    return const [
      NavigationDrawerDestination(
        icon: Icon(Icons.grid_view),
        label: Text('Grid Layout Demo'),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.view_list),
        label: Text('List Layout Demo'),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.account_tree),
        label: Text('Tree Layout Demo'),
      ),
      NavigationDrawerDestination(
        icon: Icon(Icons.table_chart),
        label: Text('Table Layout Demo'),
      ),
    ];
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const GridLayoutDemo();
      case 1:
        return const ListLayoutDemo();
      case 2:
        return const TreeLayoutDemo();
      case 3:
        return const TableLayoutDemo();
      default:
        return const SizedBox.shrink();
    }
  }

  void _showDemoSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Demo Configuration'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text('Show Supporting Pane'),
              value: _config.showSupportingPane,
              onChanged: (value) {
                setState(() {
                  _config = _config.copyWith(showSupportingPane: value);
                });
              },
            ),
            SwitchListTile(
              title: const Text('Show Detail Pane'),
              value: _config.showDetailPane,
              onChanged: (value) {
                setState(() {
                  _config = _config.copyWith(showDetailPane: value);
                });
              },
            ),
            ListTile(
              title: const Text('Pane Ratio'),
              subtitle: Text(_config.paneRatio.toStringAsFixed(1)),
              trailing: SizedBox(
                width: 150,
                child: Slider(
                  value: _config.paneRatio,
                  min: 0.2,
                  max: 0.8,
                  onChanged: (value) {
                    setState(() {
                      _config = _config.copyWith(paneRatio: value);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

/// Configuration for demo customization
class DemoConfiguration {
  const DemoConfiguration({
    this.showSupportingPane = true,
    this.showDetailPane = true,
    this.paneRatio = 0.3,
  });

  final bool showSupportingPane;
  final bool showDetailPane;
  final double paneRatio;

  DemoConfiguration copyWith({
    bool? showSupportingPane,
    bool? showDetailPane,
    double? paneRatio,
  }) {
    return DemoConfiguration(
      showSupportingPane: showSupportingPane ?? this.showSupportingPane,
      showDetailPane: showDetailPane ?? this.showDetailPane,
      paneRatio: paneRatio ?? this.paneRatio,
    );
  }
}

/// Grid Layout Demo - Shows ThreePaneLayout with grid content
class GridLayoutDemo extends StatelessWidget {
  const GridLayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ThreePaneLayout(
      supportingPane: _buildSupportingPane(),
      primaryPane: _buildPrimaryPane(),
      detailPane: _buildDetailPane(),
    );
  }

  Widget _buildSupportingPane() {
    return Builder(
      builder: (context) => Container(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccessibleHeader(text: 'Filters', level: 2),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: true,
                  onSelected: (_) {},
                ),
                FilterChip(label: const Text('Active'), onSelected: (_) {}),
                FilterChip(label: const Text('Completed'), onSelected: (_) {}),
                FilterChip(label: const Text('Archived'), onSelected: (_) {}),
              ],
            ),
            const SizedBox(height: 24),
            AccessibleHeader(text: 'Categories', level: 3),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(title: Text('Work'), dense: true),
                  ListTile(title: Text('Personal'), dense: true),
                  ListTile(title: Text('Shopping'), dense: true),
                  ListTile(title: Text('Health'), dense: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryPane() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              AccessibleHeader(text: 'Grid Items', level: 2),
              const Spacer(),
              IconButton(icon: const Icon(Icons.sort), onPressed: () {}),
              IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Reduced from 3 to 2 columns
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2, // Taller than wide
            ),
            itemCount: 24,
            itemBuilder: (context, index) {
              return Card(
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.grid_view, size: 28),
                        const SizedBox(height: 8),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Item ${index + 1}',
                            style: const TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDetailPane() {
    return const Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Grid Item Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Select a grid item to view its details here.'),
            SizedBox(height: 16),
            Text(
              'This pane shows detailed information about the selected item, including:',
            ),
            SizedBox(height: 8),
            Text('• Item properties'),
            Text('• Related actions'),
            Text('• Additional content'),
          ],
        ),
      ),
    );
  }
}

/// List Layout Demo - Traditional list with master-detail
class ListLayoutDemo extends StatefulWidget {
  const ListLayoutDemo({super.key});

  @override
  State<ListLayoutDemo> createState() => _ListLayoutDemoState();
}

class _ListLayoutDemoState extends State<ListLayoutDemo> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ThreePaneLayout(
      supportingPane: _buildSupportingPane(),
      primaryPane: _buildPrimaryPane(),
      detailPane: _buildDetailPane(),
    );
  }

  Widget _buildSupportingPane() {
    return Builder(
      builder: (context) => Container(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: AccessibleHeader(text: 'Quick Actions', level: 2),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add Item'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Search'),
              onTap: () {},
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(title: Text('Recent'), dense: true),
                  ListTile(title: Text('Favorites'), dense: true),
                  ListTile(title: Text('Shared'), dense: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimaryPane() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: AccessibleHeader(text: 'Items List', level: 2),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 50,
            itemBuilder: (context, index) {
              final isSelected = _selectedIndex == index;
              return ListTile(
                selected: isSelected,
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: Text('List Item ${index + 1}'),
                subtitle: Text('Description for item ${index + 1}'),
                trailing: isSelected ? const Icon(Icons.chevron_right) : null,
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
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
    if (_selectedIndex == null) {
      return const Center(
        child: Text('Select an item from the list to view details'),
      );
    }

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Item ${_selectedIndex! + 1} Details',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Detailed Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Text(
              'This is comprehensive information about Item ${_selectedIndex! + 1}.',
            ),
            const SizedBox(height: 24),
            const Text(
              'Properties:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            const Text('• Status: Active'),
            const Text('• Created: Today'),
            const Text('• Modified: 2 hours ago'),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = null;
                    });
                  },
                  child: const Text('Close'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: () {}, child: const Text('Save')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Tree Layout Demo - Hierarchical navigation
class TreeLayoutDemo extends StatefulWidget {
  const TreeLayoutDemo({super.key});

  @override
  State<TreeLayoutDemo> createState() => _TreeLayoutDemoState();
}

class _TreeLayoutDemoState extends State<TreeLayoutDemo> {
  final List<TreeNode> _treeData = [
    TreeNode('Root 1', [
      TreeNode('Child 1.1', [TreeNode('Leaf 1.1.1'), TreeNode('Leaf 1.1.2')]),
      TreeNode('Child 1.2'),
    ]),
    TreeNode('Root 2', [
      TreeNode('Child 2.1'),
      TreeNode('Child 2.2', [TreeNode('Leaf 2.2.1')]),
    ]),
  ];

  TreeNode? _selectedNode;

  @override
  Widget build(BuildContext context) {
    return ThreePaneLayout(
      supportingPane: _buildTreePane(),
      primaryPane: _buildContentPane(),
      detailPane: _buildPropertiesPane(),
    );
  }

  Widget _buildTreePane() {
    return Builder(
      builder: (context) => Container(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: AccessibleHeader(text: 'Project Tree', level: 2),
            ),
            Expanded(
              child: ListView(
                children: _treeData
                    .map((node) => _buildTreeNode(node))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTreeNode(TreeNode node, [int depth = 0]) {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _selectedNode = node;
              });
            },
            child: Container(
              padding: EdgeInsets.only(
                left: 16.0 + depth * 20,
                top: 8,
                bottom: 8,
                right: 16,
              ),
              color: _selectedNode == node
                  ? Theme.of(context).colorScheme.primaryContainer
                  : null,
              child: Row(
                children: [
                  if (node.children.isNotEmpty)
                    Icon(
                      node.expanded ? Icons.expand_more : Icons.chevron_right,
                    )
                  else
                    const SizedBox(width: 24),
                  const SizedBox(width: 8),
                  Text(node.title),
                ],
              ),
            ),
          ),
          if (node.expanded)
            ...node.children.map((child) => _buildTreeNode(child, depth + 1)),
        ],
      ),
    );
  }

  Widget _buildContentPane() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: AccessibleHeader(text: 'Content View', level: 2),
        ),
        Expanded(
          child: _selectedNode != null
              ? ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(
                      'Selected: ${_selectedNode!.title}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    Text('Children: ${_selectedNode!.children.length}'),
                    const SizedBox(height: 16),
                    const Text('Content preview would appear here...'),
                  ],
                )
              : const Center(child: Text('Select a node from the tree')),
        ),
      ],
    );
  }

  Widget _buildPropertiesPane() {
    if (_selectedNode == null) {
      return const Center(child: Text('Select a node to view properties'));
    }

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _selectedNode!.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const Text(
              'Properties:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              'Type: ${(_selectedNode!.children.isEmpty ? 'Leaf' : 'Branch')}',
            ),
            Text('Children: ${_selectedNode!.children.length}'),
            Text('Depth: ${_getDepth(_selectedNode!)}'),
            const SizedBox(height: 24),
            const Text(
              'Actions:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Edit')),
                OutlinedButton(onPressed: () {}, child: const Text('Delete')),
                TextButton(onPressed: () {}, child: const Text('Duplicate')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _getDepth(TreeNode node) {
    int maxDepth = 0;
    for (final child in node.children) {
      maxDepth = maxDepth > _getDepth(child) + 1
          ? maxDepth
          : _getDepth(child) + 1;
    }
    return maxDepth;
  }
}

class TreeNode {
  TreeNode(this.title, [this.children = const []]);

  final String title;
  final List<TreeNode> children;
  bool expanded = true;
}

/// Table Layout Demo - Data table with sorting and filtering
class TableLayoutDemo extends StatefulWidget {
  const TableLayoutDemo({super.key});

  @override
  State<TableLayoutDemo> createState() => _TableLayoutDemoState();
}

class _TableLayoutDemoState extends State<TableLayoutDemo> {
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  int? _selectedRow;

  final List<Map<String, dynamic>> _data = [
    {'id': 1, 'name': 'Item A', 'status': 'Active', 'value': 100},
    {'id': 2, 'name': 'Item B', 'status': 'Inactive', 'value': 200},
    {'id': 3, 'name': 'Item C', 'status': 'Active', 'value': 150},
    {'id': 4, 'name': 'Item D', 'status': 'Pending', 'value': 300},
  ];

  @override
  Widget build(BuildContext context) {
    return ThreePaneLayout(
      supportingPane: _buildFiltersPane(),
      primaryPane: _buildTablePane(),
      detailPane: _buildDetailPane(),
    );
  }

  Widget _buildFiltersPane() {
    return Builder(
      builder: (context) => Container(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccessibleHeader(text: 'Filters', level: 2),
            const SizedBox(height: 16),
            const Text('Status:'),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: true,
                  onSelected: (_) {},
                ),
                FilterChip(label: const Text('Active'), onSelected: (_) {}),
                FilterChip(label: const Text('Inactive'), onSelected: (_) {}),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Value Range:'),
            RangeSlider(
              values: const RangeValues(0, 400),
              min: 0,
              max: 400,
              onChanged: (values) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTablePane() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: AccessibleHeader(text: 'Data Table', level: 2),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              columns: [
                DataColumn(label: const Text('ID'), onSort: _onSort),
                DataColumn(label: const Text('Name'), onSort: _onSort),
                DataColumn(label: const Text('Status'), onSort: _onSort),
                DataColumn(
                  label: const Text('Value'),
                  numeric: true,
                  onSort: _onSort,
                ),
              ],
              rows: _data.map((item) {
                final isSelected = _selectedRow == item['id'];
                return DataRow(
                  selected: isSelected,
                  onSelectChanged: (selected) {
                    setState(() {
                      _selectedRow = selected == true ? item['id'] : null;
                    });
                  },
                  cells: [
                    DataCell(Text(item['id'].toString())),
                    DataCell(Text(item['name'])),
                    DataCell(Text(item['status'])),
                    DataCell(Text(item['value'].toString())),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailPane() {
    if (_selectedRow == null) {
      return const Center(child: Text('Select a row to view details'));
    }

    final item = _data.firstWhere((element) => element['id'] == _selectedRow);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Row ${item['id']} Details',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text('Name: ${item['name']}'),
            Text('Status: ${item['status']}'),
            Text('Value: ${item['value']}'),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedRow = null;
                    });
                  },
                  child: const Text('Close'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: () {}, child: const Text('Edit')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }
}
