import 'package:flutter/material.dart';
import 'package:rhizosphere/rhizosphere.dart';

/// A comprehensive demo showcasing multiple assistive technologies.
///
/// Demonstrates:
/// - Screen Reader Order (Traversal)
/// - Switch Access (Focus)
/// - Alternative Inputs (Gestures)
/// - Live Announcements
class FullAssistiveDemo extends StatefulWidget {
  const FullAssistiveDemo({super.key});

  @override
  State<FullAssistiveDemo> createState() => _FullAssistiveDemoState();
}

class _FullAssistiveDemoState extends State<FullAssistiveDemo> {
  String _status = 'Ready';
  int _counter = 0;

  void _handleAction(String actionName) {
    setState(() {
      _counter++;
      _status = '$actionName executed (Count: $_counter)';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assistive Tech Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Live Region Section
            _buildSectionHeader('Live Status Updates'),
            const Text(
              'The box below announces changes to screen readers automatically.',
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: LiveAnnouncer(
                message: _status,
                child: Row(
                  children: [
                    const Icon(Icons.info_outline),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        _status,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Semantic Order Section
            _buildSectionHeader('Semantic Navigation'),
            const Text(
              'These items are grouped logically. Screen readers should read the group label first, then the content.',
            ),
            const SizedBox(height: 16),
            MergeSemantics(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Group A',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const Text('Description for Group A content.'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Input Alternatives Section
            _buildSectionHeader('Input Alternatives'),
            const Text('Try tapping, long-pressing, or swiping the box below.'),
            const SizedBox(height: 16),
            GestureHandler(
              onTap: () => _handleAction('Gesture Box'),
              child: Container(
                height: 100,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Interactive Zone',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Focus & Keyboard Section
            _buildSectionHeader('Keyboard & Switch Access'),
            const Text(
              'These buttons have explicit focus order and large touch targets.',
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                AccessibleButton(
                  label: 'Action 1',
                  semanticLabel: 'Perform Action 1',
                  onPressed: () => _handleAction('Button 1'),
                ),
                AccessibleButton(
                  label: 'Action 2',
                  semanticLabel: 'Perform Action 2',
                  onPressed: () => _handleAction('Button 2'),
                ),
                AccessibleTextField(label: 'Input Data', hint: 'Type here...'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
