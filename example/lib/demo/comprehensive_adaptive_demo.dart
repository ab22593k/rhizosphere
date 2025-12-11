import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhizosphere/rhizosphere.dart';

/// Comprehensive NavigationSuiteScaffold and ThreePaneLayout Examples
class ComprehensiveAdaptiveDemo extends ConsumerStatefulWidget {
  const ComprehensiveAdaptiveDemo({super.key});

  @override
  ConsumerState<ComprehensiveAdaptiveDemo> createState() =>
      _ComprehensiveAdaptiveDemoState();
}

class _ComprehensiveAdaptiveDemoState
    extends ConsumerState<ComprehensiveAdaptiveDemo> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationSuiteScaffold(
      // Top App Bar is hidden in this specific design preference to match the visual
      // or we can use a minimal one. The image shows a search bar in the body.
      // We'll keep the scaffold app bar for structural correctness or hide it.
      // The image implies the search is part of the content pane.
      navigationRailLeading: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            elevation: 0,
            onPressed: () {},
            tooltip: 'Compose',
            child: const Icon(Icons.edit),
          ),
          const SizedBox(height: 16),
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
      body: _buildBody(),
    );
  }

  List<NavigationDestination> _buildDestinations() {
    return const [
      NavigationDestination(
        icon: Badge(label: Text('4'), child: Icon(Icons.mail)),
        label: 'Mail',
      ),
      NavigationDestination(
        icon: Icon(Icons.chat_bubble_outline),
        label: 'Chat',
      ),
      NavigationDestination(icon: Icon(Icons.people_outline), label: 'Spaces'),
      NavigationDestination(icon: Icon(Icons.videocam_outlined), label: 'Meet'),
    ];
  }

  List<NavigationRailDestination> _buildRailDestinations() {
    return const [
      NavigationRailDestination(
        icon: Badge(label: Text('4'), child: Icon(Icons.mail)),
        label: Text('Mail'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.chat_bubble_outline),
        label: Text('Chat'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.people_outline),
        label: Text('Spaces'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.videocam_outlined),
        label: Text('Meet'),
      ),
    ];
  }

  Widget _buildBody() {
    // We only implement the Mail demo as requested by the visual translation
    switch (_selectedIndex) {
      case 0:
        return const MailLayoutDemo();
      default:
        return Center(child: Text('Placeholder for $_selectedIndex'));
    }
  }
}

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

/// Mail Layout Demo - Matches the visual UI provided
/// Translates visual cues into semantic structure.
class MailLayoutDemo extends StatefulWidget {
  const MailLayoutDemo({super.key});

  @override
  State<MailLayoutDemo> createState() => _MailLayoutDemoState();
}

class _MailLayoutDemoState extends State<MailLayoutDemo> {
  int? _selectedEmailId = 2; // Default selected "Dinner Club"

  final List<EmailData> _emails = [
    EmailData(
      id: 1,
      sender: '老强',
      time: '10 min ago',
      subject: '豆花鱼',
      preview: '最近忙吗？昨晚我去了你最爱的那家饭馆，点了他们的特色豆花鱼，吃着吃着就想你了。',
      avatarColor: Colors.teal,
      isStarred: false,
    ),
    EmailData(
      id: 2,
      sender: 'So Duri',
      time: '20 min ago',
      subject: 'Dinner Club',
      preview:
          'I think it\'s time for us to finally try that new noodle shop downtown that doesn\'t use menus. Anyone...',
      avatarColor: Colors.purple,
      isStarred: true,
    ),
    EmailData(
      id: 3,
      sender: 'Lily MacDonald',
      time: '2 hours ago',
      subject: 'This food show is made for you',
      preview: 'Ping– you\'d love this new food show I started',
      avatarColor: Colors.orange,
      isStarred: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ThreePaneLayout(
      // The visual design implies a List-Detail view.
      // Supporting pane is not visually present in the "Middle" column concept of the image,
      // but conceptually the navigation rail acts as the first pane of the app.
      // In ThreePaneLayout terms, the List is Primary and thread is Detail.
      // If we wanted 3 panes, we could put folders/labels in Supporting.
      // Here we map List -> Primary, Detail -> Detail.
      supportingPane: null,
      primaryPane: _buildEmailListPane(),
      detailPane: _buildEmailDetailPane(),
    );
  }

  Widget _buildEmailListPane() {
    return Column(
      children: [
        // Search Bar Area
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SearchBar(
            leading: const Icon(Icons.search),
            hintText: 'Search replies',
            trailing: [
              CircleAvatar(
                radius: 16,
                backgroundImage: const NetworkImage(
                  'https://ui-avatars.com/api/?name=User&background=0D8ABC',
                ),
                child: const Text('U'),
              ),
            ],
            elevation: WidgetStateProperty.all(0),
            backgroundColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
          ),
        ),
        // Email List
        Expanded(
          child: ListView.builder(
            itemCount: _emails.length,
            itemBuilder: (context, index) {
              final email = _emails[index];
              final isSelected = _selectedEmailId == email.id;
              final colorScheme = Theme.of(context).colorScheme;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: MergeSemantics(
                  child: Material(
                    color: isSelected
                        ? colorScheme.primaryContainer
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(28),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(28),
                      onTap: () {
                        setState(() {
                          _selectedEmailId = email.id;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: email.avatarColor,
                                  backgroundImage: email.avatarUrl != null
                                      ? NetworkImage(email.avatarUrl!)
                                      : null,
                                  child: Text(email.sender[0]),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            email.sender,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            email.time,
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        email.subject,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    email.isStarred
                                        ? Icons.star
                                        : Icons.star_border,
                                  ),
                                  onPressed: () {}, // Toggle star action
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  iconSize: 20,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              email.preview,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
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

  Widget? _buildEmailDetailPane() {
    if (_selectedEmailId == null) {
      return const Center(child: Text('Select an email to read'));
    }

    final email = _emails.firstWhere((e) => e.id == _selectedEmailId);

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        email.subject,
                        style: Theme.of(context).textTheme.headlineSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      const Text('3 Messages'),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {},
                      tooltip: 'Delete',
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {},
                      tooltip: 'More options',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // User Info
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: email.avatarColor,
                  child: Text(email.sender[0]),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      email.sender,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(email.time),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.star_border),
              ],
            ),
            const SizedBox(height: 16),
            const Text('To me, Ziad, and Lily'),
            const SizedBox(height: 24),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  email.preview *
                      5, // Simulating longer content based on preview
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: () {},
                    child: const Text('Reply'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: () {},
                    child: const Text('Reply all'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmailData {
  final int id;
  final String sender;
  final String time;
  final String subject;
  final String preview;
  final Color avatarColor;
  final bool isStarred;
  final String? avatarUrl;

  EmailData({
    required this.id,
    required this.sender,
    required this.time,
    required this.subject,
    required this.preview,
    this.avatarColor = Colors.blue,
    this.isStarred = false,
    this.avatarUrl,
  });
}
