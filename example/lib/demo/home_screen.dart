import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhizosphere/rhizosphere.dart';
import 'full_assistive_demo.dart';
import 'settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _announcement = '';
  final _textController = TextEditingController();

  void _announce() {
    setState(() {
      _announcement = 'Button pressed at ${DateTime.now()}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rhizosphere Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Welcome to Rhizosphere'),
              const SizedBox(height: 20),
              AccessibleTextField(
                label: 'Username',
                hint: 'Enter your username',
                controller: _textController,
              ),
              const SizedBox(height: 20),
              AccessibleButton(
                label: 'Press Me',
                semanticLabel: 'Announce time',
                onPressed: _announce,
              ),
              const SizedBox(height: 20),
              GestureHandler(
                onTap: _announce,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  alignment: Alignment.center,
                  child: Text(
                    'Swipe/Hold Me',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_announcement.isNotEmpty)
                LiveAnnouncer(
                  message: _announcement,
                  child: Text(_announcement),
                ),
              const SizedBox(height: 40),
              Divider(color: Theme.of(context).dividerColor),
              const SizedBox(height: 20),
              AccessibleButton(
                label: 'Open Full Demo',
                semanticLabel: 'Navigate to Full Assistive Technology Demo',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const FullAssistiveDemo(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              AccessibleButton(
                label: 'Open Hierarchy Demo',
                semanticLabel:
                    'Navigate to Accessible Hierarchy Navigation Demo',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => HierarchyView(
                        items: const [
                          NavigationItem(
                            id: '1',
                            title: 'Accessibility',
                            description: 'Learn about a11y features',
                            route: '/a11y',
                          ),
                          NavigationItem(
                            id: '2',
                            title: 'Components',
                            description: 'View accessible widgets',
                            route: '/components',
                          ),
                          NavigationItem(
                            id: '3',
                            title: 'Settings',
                            description: 'Adjust app preferences',
                            route: '/settings',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
