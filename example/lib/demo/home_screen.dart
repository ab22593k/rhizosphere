import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rhizosphere/rhizosphere.dart';
import 'adaptive_demo.dart';
import 'comprehensive_adaptive_demo.dart';
import 'full_assistive_demo.dart';
import 'settings_screen.dart';
import 'motion_showcase.dart';
import 'shape_scale_demo.dart';
import 'tension_gallery_demo.dart';
import 'morphing_buttons_demo.dart';
import 'loading_indicators_demo.dart';
import 'nested_cards_demo.dart';

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
                label: 'Comprehensive Demo',
                semanticLabel: 'Navigate to Comprehensive Adaptive Demo',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ComprehensiveAdaptiveDemo(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              AccessibleButton(
                label: 'Motion System Showcase',
                semanticLabel: 'Navigate to Motion System Showcase',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const MotionShowcase()),
                  );
                },
              ),
              const SizedBox(height: 20),
              Divider(color: Theme.of(context).dividerColor),
              const SizedBox(height: 20),
              AccessibleHeader(text: 'Shape System', level: 2),
              const SizedBox(height: 20),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  AccessibleButton(
                    label: 'Shape Scale',
                    semanticLabel: 'View Shape Scale Reference',
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ShapeScaleDemo()),
                    ),
                  ),
                  AccessibleButton(
                    label: 'Tension Gallery',
                    semanticLabel: 'View Tension Gallery Demo',
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const TensionGalleryDemo(),
                      ),
                    ),
                  ),
                  AccessibleButton(
                    label: 'Morphing Buttons',
                    semanticLabel: 'View Morphing Buttons Demo',
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const MorphingButtonsDemo(),
                      ),
                    ),
                  ),
                  AccessibleButton(
                    label: 'Loading Indicators',
                    semanticLabel: 'View Loading Indicators Demo',
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LoadingIndicatorsDemo(),
                      ),
                    ),
                  ),
                  AccessibleButton(
                    label: 'Optical Roundness',
                    semanticLabel: 'View Optical Roundness Demo',
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const NestedCardsDemo(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
