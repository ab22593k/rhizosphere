import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhizosphere/rhizosphere.dart';
import 'adaptive_demo.dart';
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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: DynamicTooltipLabel(text: '${l10n.appTitle} Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: l10n.settingsLabel,
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
              AccessibleHeader(text: 'Welcome to ${l10n.appTitle}', level: 1),
              const SizedBox(height: 20),
              // Demonstrate AccessibleImage
              const AccessibleImage(
                image: AssetImage('assets/placeholder.png'),
                semanticsLabel:
                    'Placeholder image demonstrating accessibility caption positioning',
                caption: 'Accessible image with caption',
              ),
              const SizedBox(height: 20),
              // Demonstrate Localized Button (Positive Outcome)
              AccessibleButton(
                label: l10n.savePhoto,
                semanticLabel: 'Save photo to gallery',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${l10n.savePhoto} clicked')),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Demonstrate AccessibleText
              const AccessibleText(
                text:
                    'This is accessible text that scales with system settings.',
                maxLines: 2,
              ),
              const SizedBox(height: 20),
              // Demonstrate TruncationHandler
              const SizedBox(
                width: 200,
                child: TruncationHandler(
                  text:
                      'This is a long text that will be truncated with ellipsis and tooltip',
                  maxWidth: 200,
                ),
              ),
              const SizedBox(height: 20),
              AccessibleTextField(
                label: 'Username',
                hint: 'Enter your username',
                controller: _textController,
              ),
              const SizedBox(height: 20),
              AccessibleButton(
                label: l10n.pressMe,
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
                    l10n.swipeHoldMe,
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
                label: l10n.fullDemoLabel,
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
                label: l10n.adaptiveDemoLabel,
                semanticLabel: 'Navigate to Adaptive Layout Demo',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AdaptiveDemo()),
                  );
                },
              ),
              const SizedBox(height: 20),
              AccessibleButton(
                label: l10n.hierarchyDemoLabel,
                semanticLabel: 'Navigate to Hierarchy View Demo',
                onPressed: () {
                  final demoItems = [
                    NavigationItem(
                      id: '1',
                      title: 'Accessibility',
                      description: 'Core accessibility features',
                      route: '/accessibility',
                    ),
                    NavigationItem(
                      id: '2',
                      title: 'Adaptive Layout',
                      description: 'Responsive design patterns',
                      route: '/adaptive',
                    ),
                    NavigationItem(
                      id: '3',
                      title: 'Localization',
                      description: 'Internationalization support',
                      route: '/l10n',
                    ),
                  ];
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => HierarchyView(items: demoItems),
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
